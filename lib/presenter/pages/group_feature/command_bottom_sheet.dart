import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/add_member_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

class CommandBottomSheet extends StatefulWidget {
  List<LampModel>? lampIds;
  GroupModel? groupId;

  CommandBottomSheet({super.key, this.lampIds, this.groupId});

  @override
  State<CommandBottomSheet> createState() => _CommandBottomSheetState();
}

class _CommandBottomSheetState extends State<CommandBottomSheet> {
  late AppLocalizations al;
  Color rgb = Colors.white;
  double c = Constants.defaultC;
  double y = 0;
  double w = 0;
  double v = 0;
  double s = 100;
  bool isColor = true;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return CustomBottomSheet(
      title: AppLocalizations.of(context)!.settings,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.contrast,
                style: Light300Style.sm.copyWith(color: MyColors.secondary),
              ),
              const Spacer(),
              Text(
                '${s.toInt()}%',
                style: Light300Style.sm.copyWith(color: MyColors.secondary),
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
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 8.0,
                ),
                activeTrackColor: Colors.white,
                overlayShape: SliderComponentShape.noOverlay,
                inactiveTrackColor: MyColors.black.shade300,
                disabledThumbColor: MyColors.white,
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
            height: MySpaces.s12,
          ),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.yellowAndWhite,
                style: Light300Style.sm.copyWith(color: MyColors.secondary),
              ),
              Spacer()
            ],
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
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8.0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: const Color(0xffFFDA55),
                  disabledThumbColor: MyColors.white,
                  activeTickMarkColor: Colors.white,
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
                ),
              ),
            ),
          ),
          const SizedBox(
            height: MySpaces.s8,
          ),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.speedLight,
                style: Light300Style.sm.copyWith(color: MyColors.secondary),
              ),
              const Spacer(),
              Text(
                '${c.toInt()}',
                style: Light300Style.sm.copyWith(color: MyColors.secondary),
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
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 8.0,
                ),
                activeTrackColor: Colors.white,
                overlayShape: SliderComponentShape.noOverlay,
                inactiveTrackColor: MyColors.black.shade300,
                disabledThumbColor: MyColors.white,
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
          Divider(
            color: MyColors.secondary.shade800,
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
                  return AddMemberGroupBottomSheet();
                },
              );
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: MyColors.secondary, shape: BoxShape.circle),
                  child: SvgPicture.asset("assets/icons/profile_user.svg"),
                ),
                Text(
                  AppLocalizations.of(context)!.addMember,
                  style: Light400Style.lg.copyWith(color: MyColors.secondary),
                ),
                const Spacer(),
                const ArrowList()
              ],
            ),
          ),
          Divider(
            color: MyColors.secondary.shade800,
            height: MySpaces.s40,
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
                      Color currentColor = Colors.white;
                      return AlertDialog(
                        title: Text(al.selectColor),
                        content: SingleChildScrollView(
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
                            width: double.infinity,
                            child: PrimaryButton(
                              text: al.done,
                              onPress: () {
                                setState(() {
                                  isColor = true;
                                  rgb = currentColor;
                                });
                                Navigator.of(context).pop();
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
            height: MySpaces.s16,
          ),
          Row(
            children: [
              if (widget.groupId != null)
                getButton(al.lampList, 'assets/icons/lamp_on.svg', onTab: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LampPage(widget.groupId?.id ?? 0)));
                }),
              const SizedBox(
                width: 20,
              ),
              getButton(al.informationData, 'assets/icons/favorite_chart.svg',
                  onTab: () {
                BlocProvider.of<StateBloc>(context)
                    .add(GetChartInformation(widget.groupId!.lamps));
                Navigator.pop(context);
              }),
            ],
          ),
          const SizedBox(
            height: MySpaces.s32,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: al.save,
              onPress: () {
                BlocProvider.of<CommandBloc>(context)
                    .add(SendCommandEvent(CommandParams(
                  lamps: widget.groupId?.lamps.map((e) => e.id).toList(),
                  w: isColor ? 0 : w.toInt(),
                  y: isColor ? 0 : y.toInt(),
                  r: !isColor ? 0 : rgb.red,
                  g: !isColor ? 0 : rgb.green,
                  b: !isColor ? 0 : rgb.blue,
                  s: s.toInt(),
                  c: c.toInt(),
                  pir: true,
                  type: 'apply',
                  gid: widget.groupId?.id,
                )));
              },
            ),
          ),
          const SizedBox(
            height: MySpaces.s24,
          )
        ],
      ),
    );
  }

  getButton(String informationData, String icon, {Function()? onTab}) {
    return Expanded(
        child: ClickableContainer(
      onTap: onTab,
      padding: const EdgeInsets.all(10),
      color: MyColors.black.shade400,
      borderRadius: MyRadius.sm,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            width: MySpaces.s8,
          ),
          Expanded(
              child: Text(
            informationData,
            style: DemiBoldStyle.lg.copyWith(
              color: MyColors.white,
            ),
            maxLines: 1,
          ))
        ],
      ),
    ));
  }

  getCard(String text, IconData icon, Function()? onTab, {Widget? left}) {
    return ClickableContainer(
      onTap: onTab,
      margin: const EdgeInsets.only(top: MySpaces.s24),
      width: double.infinity,
      color: MyColors.black.shade400,
      borderRadius: MyRadius.sm,
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
