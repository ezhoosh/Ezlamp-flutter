import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart';
import 'package:flutter_svg/svg.dart';

class EditInternetBoxBottomSheet extends StatelessWidget {
  EditInternetBoxBottomSheet({super.key});

  late AppLocalizations al;

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
                '40%',
                style: Light300Style.sm.copyWith(color: MyColors.secondary),
              ),
            ],
          ),
          const SizedBox(
            height: MySpaces.s8,
          ),
          Slider(
            value: 0,
            onChanged: (newValue) {},
            min: 0.0,
            // Minimum value
            max: 100.0,
            // Maximum value
          ),
          const SizedBox(
            height: MySpaces.s32,
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
          HuePicker(
            initialColor: HSVColor.fromColor(Colors.white),
            onChanged: (color) {},
            thumbShape: const HueSliderThumbShape(
              color: Colors.white,
              borderColor: Colors.black,
              filled: false,
              showBorder: true,
            ),
            hueColors: const [
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.lightBlueAccent,
              Colors.blueAccent,
              Colors.blue,
              Colors.pink,
              Colors.red,
            ],
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
          HuePicker(
            initialColor: HSVColor.fromColor(Colors.white),
            onChanged: (color) {},
            thumbShape: const HueSliderThumbShape(
              color: Colors.white,
              borderColor: Colors.black,
              filled: false,
              showBorder: true,
            ),
            hueColors: const [Colors.yellow, Colors.white],
          ),
          Divider(
            color: MyColors.secondary.shade800,
            height: MySpaces.s40,
          ),
          Row(
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
          Divider(
            color: MyColors.secondary.shade800,
            height: MySpaces.s40,
          ),
          Row(
            children: [
              getButton(al.lampList, 'assets/icons/lamp_on.svg'),
              const SizedBox(
                width: 20,
              ),
              getButton(al.informationData, 'assets/icons/favorite_chart.svg'),
            ],
          ),
          const SizedBox(
            height: MySpaces.s16,
          ),
        ],
      ),
    );
  }

  getButton(String informationData, String icon) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.black.shade400, borderRadius: MyRadius.sm),
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
