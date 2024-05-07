import 'package:easy_lamp/core/params/create_schedule_params.dart';
import 'package:easy_lamp/core/params/update_schedule_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_back.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:easy_lamp/core/widgets/input_date.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/data/model/crontab_model.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/schudule_model.dart';
import 'package:easy_lamp/presenter/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/select_group_page.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ScheduleDetailPage extends StatefulWidget {
  ScheduleModel? schedule;

  ScheduleDetailPage({Key? key, this.schedule}) : super(key: key);

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  late AppLocalizations al;
  List<int> dayOffWeek = [];
  List<GroupModel> groups = [];
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController _controllerName = TextEditingController(text: '');
  CommandModel? command;

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _controllerName.text = widget.schedule!.name;
      command = widget.schedule!.command;
      command!.pir = true;
      command!.type = 'apply';
      CrontabModel pta = widget.schedule!.periodicTaskAssigned.crontab;
      CrontabModel ptaOff = widget.schedule!.periodicTaskOffAssigned.crontab;
      startDate = DateTime(
        2020,
        1,
        1,
        int.parse(pta.hour),
        int.parse(pta.minute),
      );
      endDate = DateTime(
        2020,
        1,
        1,
        int.parse(ptaOff.hour),
        int.parse(ptaOff.minute),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: BlocListener<ScheduleBloc, ScheduleState>(
          listener: (BuildContext context, ScheduleState state) {
            if (state.createScheduleListStatus is BaseLoading ||
                state.putScheduleByIdStatus is BaseLoading ||
                state.deleteScheduleByIdStatus is BaseLoading) {
              EasyLoading.show();
            } else if (state.createScheduleListStatus is BaseSuccess ||
                state.putScheduleByIdStatus is BaseSuccess ||
                state.deleteScheduleByIdStatus is BaseSuccess) {
              EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
              Navigator.pop(context);
            } else if (state.createScheduleListStatus is BaseError) {
              ErrorHelper.getBaseError(state.createScheduleListStatus, context);
            } else if (state.deleteScheduleByIdStatus is BaseError) {
              ErrorHelper.getBaseError(state.deleteScheduleByIdStatus, context);
            } else if (state.putScheduleByIdStatus is BaseError) {
              ErrorHelper.getBaseError(state.putScheduleByIdStatus, context);
            }
          },
          child: Column(
            children: [
              TopBar(
                title: al.planning,
                iconRight: ArrowBack(),
                onTapRight: () {
                  Navigator.pop(context);
                },
                iconLeft: InkWell(
                  onTap: () {
                    List<int> lamps = [];
                    for (var e in groups) {
                      for (var element in e.lamps) {
                        lamps.add(element.id);
                      }
                    }

                    if (startDate == null ||
                        endDate == null ||
                        _controllerName.text.isEmpty ||
                        dayOffWeek.isEmpty ||
                        groups.isEmpty) {
                      EasyLoading.showToast(al.errorInformation);
                      return;
                    }
                    if (command == null) {
                      EasyLoading.showToast(al.lightSettingMessage);
                      return;
                    }
                    command!.lamps = lamps;
                    if (widget.schedule != null) {
                      BlocProvider.of<ScheduleBloc>(context).add(
                        PutScheduleByIdEvent(
                          UpdateScheduleParams(
                            id: widget.schedule!.id,
                            periodicTaskAssigned: PeriodicTaskAssignedParams(
                                crontab: CrontabModel(
                                    minute: startDate == null
                                        ? ''
                                        : startDate!.minute.toString(),
                                    hour: startDate == null
                                        ? ''
                                        : startDate!.hour.toString(),
                                    dayOfWeek: '*',
                                    dayOfMonth: '*',
                                    monthOfYear: '*')),
                            periodicTaskOffAssigned: PeriodicTaskAssignedParams(
                                crontab: CrontabModel(
                                    minute: endDate == null
                                        ? ''
                                        : endDate!.minute.toString(),
                                    hour: endDate == null
                                        ? ''
                                        : endDate!.hour.toString(),
                                    dayOfWeek: '*',
                                    dayOfMonth: '*',
                                    monthOfYear: '*')),
                            name: _controllerName.text,
                            command: command!,
                            groupAssigned: groups.map((e) => e.id).toList(),
                            enabled: true,
                          ),
                        ),
                      );
                    } else {
                      BlocProvider.of<ScheduleBloc>(context).add(
                        CreateScheduleEvent(
                          CreateScheduleParams(
                            periodicTaskAssigned: PeriodicTaskAssignedParams(
                                crontab: CrontabModel(
                                    minute: startDate == null
                                        ? ''
                                        : startDate!.minute.toString(),
                                    hour: startDate == null
                                        ? ''
                                        : startDate!.hour.toString(),
                                    dayOfWeek: '*',
                                    dayOfMonth: '*',
                                    monthOfYear: '*')),
                            periodicTaskOffAssigned: PeriodicTaskAssignedParams(
                                crontab: CrontabModel(
                                    minute: endDate == null
                                        ? ''
                                        : endDate!.minute.toString(),
                                    hour: endDate == null
                                        ? ''
                                        : endDate!.hour.toString(),
                                    dayOfWeek: '*',
                                    dayOfMonth: '*',
                                    monthOfYear: '*')),
                            name: _controllerName.text,
                            command: command!,
                            groupAssigned: groups.map((e) => e.id).toList(),
                            enabled: true,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    al.save,
                    style:
                        DemiBoldStyle.normal.copyWith(color: MyColors.primary),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: MySpaces.s40,
                    horizontal: MySpaces.s24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BorderTextField(
                        title: al.title,
                        optional: false,
                        controller: _controllerName,
                      ),
                      const SizedBox(
                        height: MySpaces.s16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputDate(
                              prevDate: startDate,
                              optional: false,
                              title: al.startHour,
                              onNewDateSelected: (DateTime newDate) {
                                startDate = newDate;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: MySpaces.s12,
                          ),
                          Expanded(
                            child: InputDate(
                              title: al.finishHour,
                              prevDate: endDate,
                              optional: false,
                              onNewDateSelected: (DateTime newDate) {
                                endDate = newDate;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: MySpaces.s16,
                      ),
                      Text(
                        al.again,
                        style: DemiBoldStyle.normal
                            .copyWith(color: MyColors.secondary.shade300),
                      ),
                      const SizedBox(
                        height: MySpaces.s16,
                      ),
                      Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          getCircleDate(al.saturday, 0),
                          getCircleDate(al.sunday, 1),
                          getCircleDate(al.monday, 2),
                          getCircleDate(al.tuesday, 3),
                          getCircleDate(al.wednesday, 4),
                          getCircleDate(al.thursday, 5),
                          getCircleDate(al.friday, 6),
                        ],
                      ),
                      const SizedBox(
                        height: MySpaces.s40,
                      ),
                      ClickableContainer(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              builder: (context) {
                                double c = Constants.defaultC;
                                double y = 0;
                                double w = 0;
                                double v = 50;
                                double s = 100;
                                Color rgb = Colors.white;
                                bool isColor = false;
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return CustomBottomSheet(
                                    title: al.lightSetting,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .contrast,
                                              style: Light300Style.sm.copyWith(
                                                  color: MyColors.secondary),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${s.toInt()}%',
                                              style: Light300Style.sm.copyWith(
                                                  color: MyColors.secondary),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s8,
                                        ),
                                        SliderTheme(
                                          data: SliderThemeData(
                                              trackHeight: 6.0,
                                              // Adjust the track height here
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                enabledThumbRadius: 8.0,
                                              ),
                                              activeTrackColor: Colors.white,
                                              overlayShape: SliderComponentShape
                                                  .noOverlay,
                                              inactiveTrackColor:
                                                  MyColors.black.shade300,
                                              disabledThumbColor:
                                                  MyColors.white,
                                              activeTickMarkColor: Colors.white,
                                              thumbColor: Colors.white),
                                          child: Slider(
                                            value: s,
                                            onChanged: (newValue) {
                                              setState(() {
                                                s = newValue;
                                              });
                                            },
                                            min: 0.0,
                                            // Minimum value
                                            max: 100.0,
                                            // Maximum value
                                          ),
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s8,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .yellowAndWhite,
                                            style: Light300Style.sm.copyWith(
                                                color: MyColors.secondary),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s8,
                                        ),
                                        Opacity(
                                          opacity: isColor ? 0.5 : 1,
                                          child: SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 6.0,
                                                // Adjust the track height here
                                                thumbShape:
                                                    const RoundSliderThumbShape(
                                                  enabledThumbRadius: 8.0,
                                                ),
                                                overlayShape:
                                                    SliderComponentShape
                                                        .noOverlay,
                                                activeTrackColor: Colors.white,
                                                inactiveTrackColor:
                                                    const Color(0xffFFDA55),
                                                disabledThumbColor:
                                                    MyColors.white,
                                                activeTickMarkColor:
                                                    Colors.white,
                                                thumbColor: Colors.white),
                                            child: SizedBox(
                                              child: Slider(
                                                value: v,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    isColor = false;
                                                    v = newValue;
                                                  });

                                                  if (v < 50) {
                                                    y = 99 - v;
                                                    w = 100 - y;
                                                  } else {
                                                    w = v;
                                                    y = 100 - w;
                                                  }
                                                  print("w : $w and y : $y");
                                                },
                                                min: 0.0,
                                                // Minimum value
                                                max: 100.0,
                                                // Maximum value
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s12,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .speedLight,
                                              style: Light300Style.sm.copyWith(
                                                  color: MyColors.secondary),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${c.toInt()}',
                                              style: Light300Style.sm.copyWith(
                                                  color: MyColors.secondary),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s8,
                                        ),
                                        SliderTheme(
                                          data: SliderThemeData(
                                              trackHeight: 6.0,
                                              // Adjust the track height here
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                enabledThumbRadius: 8.0,
                                              ),
                                              activeTrackColor: Colors.white,
                                              overlayShape: SliderComponentShape
                                                  .noOverlay,
                                              inactiveTrackColor:
                                                  MyColors.black.shade300,
                                              disabledThumbColor:
                                                  MyColors.white,
                                              activeTickMarkColor: Colors.white,
                                              thumbColor: Colors.white),
                                          child: Slider(
                                            value: c,
                                            onChanged: (newValue) {
                                              setState(() {
                                                c = newValue;
                                              });
                                            },
                                            min: Constants.defaultMinC,
                                            // Minimum value
                                            max: Constants.defaultMaxC,
                                            // Maximum value
                                          ),
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s12,
                                        ),
                                        Opacity(
                                          opacity: isColor ? 1 : 0.5,
                                          child: getCard(
                                            al.selectColor,
                                            Iconsax.color_swatch,
                                            left: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: rgb,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Color currentColor =
                                                        Colors.white;
                                                    return AlertDialog(
                                                      title:
                                                          Text(al.selectColor),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerColor: rgb,
                                                          onColorChanged: (c) {
                                                            currentColor = c;
                                                          },
                                                        ),
                                                        // Use Material color picker:
                                                        //
                                                        // child: MaterialPicker(
                                                        //   pickerColor: pickerColor,
                                                        //   onColorChanged: changeColor,
                                                        //   showLabel: true, // only on portrait mode
                                                        // ),
                                                        //
                                                        // Use Block color picker:
                                                        //
                                                        // child: BlockPicker(
                                                        //   pickerColor: currentColor,
                                                        //   onColorChanged: changeColor,
                                                        // ),
                                                        //
                                                        // child: MultipleChoiceBlockPicker(
                                                        //   pickerColors: currentColors,
                                                        //   onColorsChanged: changeColors,
                                                        // ),
                                                      ),
                                                      actions: <Widget>[
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: PrimaryButton(
                                                            text: al.done,
                                                            onPress: () {
                                                              setState(() {
                                                                isColor = true;
                                                                rgb =
                                                                    currentColor;
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: MySpaces.s40,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            bottom: MySpaces.s12,
                                          ),
                                          width: double.infinity,
                                          child: PrimaryButton(
                                            text: al.save,
                                            onPress: () {
                                              this.setState(() {
                                                command = CommandModel(
                                                  lamps: [],
                                                  w: isColor ? 0 : w.toInt(),
                                                  y: isColor ? 0 : y.toInt(),
                                                  r: !isColor ? 0 : rgb!.red,
                                                  g: !isColor ? 0 : rgb!.green,
                                                  b: !isColor ? 0 : rgb!.blue,
                                                  c: c.toInt(),
                                                  pir: true,
                                                  type: 'apply',
                                                  gid: null,
                                                );
                                              });
                                              Navigator.pop(
                                                context,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                              });
                        },
                        width: double.infinity,
                        color: MyColors.black.shade600,
                        borderRadius: MyRadius.base,
                        padding: const EdgeInsets.all(MySpaces.s24),
                        child: Row(
                          children: [
                            Text(
                              al.lightSetting,
                              style: DemiBoldStyle.normal
                                  .copyWith(color: MyColors.white),
                            ),
                            const Spacer(),
                            const Icon(
                              Iconsax.setting_2,
                              color: MyColors.white,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: MySpaces.s40,
                      ),
                      Row(
                        children: [
                          Text(
                            al.groupsList,
                            style: DemiBoldStyle.normal
                                .copyWith(color: MyColors.secondary.shade300),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              List<GroupModel> select =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelectGroupPage(groups)),
                              );
                              setState(() {
                                groups = select;
                              });
                            },
                            borderRadius: MyRadius.sm,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: MyColors.primary,
                                  size: 20,
                                ),
                                Text(
                                  al.addGroup,
                                  style: DemiBoldStyle.sm.copyWith(
                                    color: MyColors.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: MySpaces.s16,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          GroupModel group = groups[index];
                          return ClickableContainer(
                            padding: const EdgeInsets.only(
                              left: MySpaces.s24,
                              right: MySpaces.s24,
                              top: MySpaces.s12,
                              bottom: MySpaces.s12,
                            ),
                            onTap: () {},
                            borderRadius: MyRadius.base,
                            color: MyColors.black.shade600,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      group.name,
                                      style: DemiBoldStyle.lg
                                          .copyWith(color: MyColors.white),
                                    ),
                                    const SizedBox(
                                      height: MySpaces.s6,
                                    ),
                                    Text(
                                      al.lamp(al
                                          .lamp(group.lamps.length.toString())),
                                      style: DemiBoldStyle.sm.copyWith(
                                          color: MyColors.black.shade100),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: MyColors.secondary.shade200,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      groups.remove(group);
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: groups.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: MySpaces.s16,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              if (widget.schedule != null)
                Container(
                  margin: const EdgeInsets.only(
                    left: MySpaces.s24,
                    right: MySpaces.s24,
                    bottom: MySpaces.s12,
                  ),
                  width: double.infinity,
                  child: PrimaryButton(
                    text: al.deleteSchedule,
                    bg: MyColors.secondary,
                    textColor: MyColors.error.shade700,
                    onPress: () {
                      BlocProvider.of<ScheduleBloc>(context).add(
                          DeleteScheduleByIdEvent(widget.schedule!.id ?? 0));
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  getEmptyPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MySpaces.s40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/cuate_lamp.png",
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            Text(
              AppLocalizations.of(context)!.addYourGroup,
              style: Light300Style.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                text: 'افزودن گروه',
                right: const Icon(
                  Icons.add,
                  color: MyColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCircleDate(String t, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (dayOffWeek.contains(index)) {
            dayOffWeek.remove(index);
          } else {
            dayOffWeek.add(index);
          }
        });
      },
      borderRadius: MyRadius.xl,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 35.0,
          minWidth: 35.0,
          maxHeight: 45.0,
          maxWidth: 45.0,
        ),
        margin: const EdgeInsets.all(3),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: dayOffWeek.contains(index)
              ? MyColors.primary
              : MyColors.black.shade600,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            t,
            style: DemiBoldStyle.normal.copyWith(
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }

  getCard(String text, IconData icon, Function()? onTab, {Widget? left}) {
    return ClickableContainer(
      onTap: onTab,
      margin: const EdgeInsets.only(top: MySpaces.s24),
      width: double.infinity,
      color: MyColors.black.shade500,
      borderRadius: MyRadius.base,
      padding: const EdgeInsets.symmetric(
        horizontal: MySpaces.s12,
        vertical: MySpaces.s16,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color: MyColors.white,
          ),
          const SizedBox(
            width: MySpaces.s4,
          ),
          Text(
            text,
            style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
          ),
          const Spacer(),
          left ?? ArrowList(),
        ],
      ),
    );
  }
}
