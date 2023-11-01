import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_back.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/internet_box_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_member_lamp_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/more_lamp_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconsax/iconsax.dart';

class DetailLampPage extends StatefulWidget {
  List<LampModel> lamps;
  int groupId;

  DetailLampPage(this.lamps, this.groupId, {super.key});

  @override
  State<DetailLampPage> createState() => _DetailLampPageState();
}

class _DetailLampPageState extends State<DetailLampPage> {
  late AppLocalizations al;
  Color? rgb;
  double c = 0;
  double y = 0;
  double w = 0;
  double v = 0;
  bool isColor = true;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return BlocListener<LampBloc, LampState>(
      listenWhen: (prev, curr) {
        if (prev.patchLampStatus is BaseSuccess &&
            curr.patchLampStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.patchLampStatus is BaseSuccess) {
          LampModel lamp = (state.patchLampStatus as BaseSuccess).entity;
          setState(() {
            widget.lamps.first = lamp;
          });
          EasyLoading.showSuccess("SUCCESS");
        } else if (state.patchLampStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.patchLampStatus is BaseError) {
          EasyLoading.showError("ERROR");
        }
      },
      child: Scaffold(
          backgroundColor: MyColors.black,
          body: SafeArea(
            child: Column(
              children: [
                TopBar(
                  title: widget.lamps.first.name,
                  onTapRight: () {
                    Navigator.pop(context);
                  },
                  iconRight: ArrowBack(),
                  iconLeft: Text(
                    al.save,
                    style:
                        Light400Style.normal.copyWith(color: MyColors.primary),
                  ),
                  onTapLeft: () {
                    BlocProvider.of<CommandBloc>(context)
                        .add(SendCommandEvent(CommandParams(
                      lamps: widget.lamps.map((e) => e.id).toList(),
                      w: isColor ? 0 : w.toInt(),
                      y: isColor ? 0 : y.toInt(),
                      r: !isColor ? 0 : (rgb == null ? 0 : rgb!.red),
                      g: !isColor ? 0 : (rgb == null ? 0 : rgb!.green),
                      b: !isColor ? 0 : (rgb == null ? 0 : rgb!.blue),
                      c: c.toInt(),
                      pir: true,
                      type: 'apply',
                    )));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MySpaces.s24),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: MySpaces.s24,
                      ),
                      if (widget.lamps.length == 1)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: MyColors.black.shade500,
                              borderRadius: MyRadius.base),
                          padding: const EdgeInsets.symmetric(
                            horizontal: MySpaces.s12,
                            vertical: MySpaces.s16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
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
                                            return MoreLampBottomSheet(
                                                widget.lamps.first.id);
                                          },
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/edit.svg",
                                        width: 30,
                                        height: 30,
                                      )),
                                  const SizedBox(
                                    width: MySpaces.s4,
                                  ),
                                  Text(
                                    widget.lamps.first.name,
                                    style: DemiBoldStyle.lg
                                        .copyWith(color: MyColors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: MySpaces.s12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      onPress: () {
                                        BlocProvider.of<CommandBloc>(context)
                                            .add(SendCommandEvent(CommandParams(
                                                w: 0,
                                                y: 0,
                                                r: 0,
                                                g: 0,
                                                b: 0,
                                                c: 0,
                                                pir: true,
                                                type: 'apply',
                                                lamps: widget.lamps
                                                    .map((e) => e.id)
                                                    .toList())));
                                      },
                                      text: al.off,
                                      right: const Icon(
                                        Icons.power_settings_new_outlined,
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: MySpaces.s8,
                                  ),
                                  Expanded(
                                    child: SecondaryButton(
                                      onPress: () {
                                        BlocProvider.of<CommandBloc>(context)
                                            .add(SendCommandEvent(CommandParams(
                                                w: 100,
                                                y: 50,
                                                r: 0,
                                                g: 0,
                                                b: 0,
                                                c: 0,
                                                pir: true,
                                                type: 'apply',
                                                lamps: widget.lamps
                                                    .map((e) => e.id)
                                                    .toList())));
                                      },
                                      text: al.on,
                                      right: const Icon(
                                        Icons.power_settings_new_outlined,
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: MySpaces.s32,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColors.black.shade500,
                            borderRadius: MyRadius.base),
                        padding: const EdgeInsets.symmetric(
                          horizontal: MySpaces.s12,
                          vertical: MySpaces.s24,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.contrast,
                                  style: Light300Style.sm
                                      .copyWith(color: MyColors.secondary),
                                ),
                                const Spacer(),
                                Text(
                                  '${c.toInt()}',
                                  style: Light300Style.sm
                                      .copyWith(color: MyColors.secondary),
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
                                min: 0.0,
                                // Minimum value
                                max: 20.0,
                                // Maximum value
                                divisions: 100,
                                // Number of divisions
                              ),
                            ),
                            const SizedBox(
                              height: MySpaces.s12,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                AppLocalizations.of(context)!.coloring,
                                style: Light300Style.sm
                                    .copyWith(color: MyColors.secondary),
                              ),
                            ),
                            const SizedBox(
                              height: MySpaces.s8,
                            ),
                            Opacity(
                              opacity: isColor ? 1 : 0.5,
                              child: HuePicker(
                                initialColor:
                                    HSVColor.fromColor(rgb ?? Colors.white),
                                onChanged: (color) {
                                  setState(() {
                                    isColor = true;
                                    rgb = color;
                                  });
                                },
                                trackHeight: 6,
                                thumbShape: HueSliderThumbShape(
                                  color: Colors.white,
                                  borderColor: Colors.white.withOpacity(0.3),
                                  filled: true,
                                  showBorder: true,
                                  borderWidth: 3,
                                ),
                                hueColors: const [
                                  Colors.red,
                                  Colors.blue,
                                  Colors.yellow,
                                  Colors.green,
                                  Colors.pink,
                                  Colors.orange,
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: MySpaces.s32,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                AppLocalizations.of(context)!.yellowAndWhite,
                                style: Light300Style.sm
                                    .copyWith(color: MyColors.secondary),
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
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 8.0,
                                    ),
                                    overlayShape:
                                        SliderComponentShape.noOverlay,
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
                                        w = 0;
                                        y = 100 - v;
                                      } else {
                                        y = 0;
                                        w = v;
                                      }
                                      print("w : $w and y : $y");
                                    },
                                    min: 0.0,
                                    // Minimum value
                                    max: 100.0,
                                    // Maximum value
                                    divisions: 100,
                                    // Number of divisions
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      getCard(
                        al.addMember,
                        Iconsax.profile_2user,
                        () {
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
                              return AddMemberLampBottomSheet(
                                  widget.groupId, widget.lamps);
                            },
                          );
                        },
                      ),
                      getCard(al.internetLamp, Iconsax.global, () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => InternetBoxPage(),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getCard(String text, IconData icon, Function()? onTab) {
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
          IconButton(
              onPressed: () {
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
                    return MoreLampBottomSheet(widget.lamps.first.id);
                  },
                );
              },
              icon: Icon(
                icon,
                size: 25,
                color: MyColors.white,
              )),
          const SizedBox(
            width: MySpaces.s4,
          ),
          Text(
            text,
            style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
          ),
          const Spacer(),
          ArrowList(),
        ],
      ),
    );
  }
}
