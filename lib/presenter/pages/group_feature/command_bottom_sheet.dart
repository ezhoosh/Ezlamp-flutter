import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/add_member_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart';
import 'package:flutter_svg/svg.dart';

class CommandBottomSheet extends StatefulWidget {
  List<int>? lampIds;
  int? groupId;

  CommandBottomSheet({super.key, this.lampIds, this.groupId});

  @override
  State<CommandBottomSheet> createState() => _CommandBottomSheetState();
}

class _CommandBottomSheetState extends State<CommandBottomSheet> {
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
              style: Light300Style.sm.copyWith(color: MyColors.secondary),
            ),
          ),
          const SizedBox(
            height: MySpaces.s8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Opacity(
              opacity: isColor ? 1 : 0.5,
              child: HuePicker(
                initialColor: HSVColor.fromColor(rgb ?? Colors.white),
                onChanged: (color) {
                  setState(() {
                    isColor = true;
                    rgb = color;
                  });
                  print(color.value);
                },
                thumbShape: HueSliderThumbShape(
                  color: Colors.white,
                  borderColor: Colors.white.withOpacity(0.3),
                  filled: true,
                  showBorder: true,
                  borderWidth: 3,
                ),
                trackHeight: 6,
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
          ),
          const SizedBox(
            height: MySpaces.s32,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              AppLocalizations.of(context)!.yellowAndWhite,
              style: Light300Style.sm.copyWith(color: MyColors.secondary),
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
                ArrowList()
              ],
            ),
          ),
          Divider(
            color: MyColors.secondary.shade800,
            height: MySpaces.s40,
          ),
          Row(
            children: [
              if (widget.groupId != null)
                getButton(al.lampList, 'assets/icons/lamp_on.svg', onTab: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LampPage(widget.groupId ?? 0)));
                }),
              const SizedBox(
                width: 20,
              ),
              getButton(al.informationData, 'assets/icons/favorite_chart.svg'),
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
                  lamps: widget.lampIds,
                  w: isColor ? 0 : w.toInt(),
                  y: isColor ? 0 : y.toInt(),
                  r: !isColor ? 0 : rgb!.red,
                  g: !isColor ? 0 : rgb!.green,
                  b: !isColor ? 0 : rgb!.blue,
                  c: c.toInt(),
                  pir: true,
                  type: 'apply',
                  gid: widget.groupId,
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
              child: Text(informationData,
                  style: DemiBoldStyle.lg.copyWith(
                    color: MyColors.white,
                  )))
        ],
      ),
    ));
  }
}
