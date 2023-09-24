import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class AddGroupBottomSheet extends StatelessWidget {
  late AppLocalizations al;
  late TextEditingController _controller;

  AddGroupBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    _controller = TextEditingController();
    return CustomBottomSheet(
      title: AppLocalizations.of(context)!.editGroupName,
      child: Column(
        children: [
          BorderTextField(
            hintText: al.title,
            controller: _controller,
          ),
          SizedBox(
            height: MySpaces.s12,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                al.save,
                style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
              ),
            ),
          ),
          SizedBox(
            height: MySpaces.s24,
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
