import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class AddMemberNameBottomSheet extends StatelessWidget {
  late AppLocalizations al;
  final TextEditingController _controllerPhone = TextEditingController();

  AddMemberNameBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return CustomBottomSheet(
      title: al.addMember,
      child: Column(
        children: [
          BorderTextField(
            title: al.phone,
            controller: _controllerPhone,
            optional: false,
            hintText: "+98",
          ),
          const SizedBox(
            height: MySpaces.s12,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPress: () {},
              text: al.save,
            ),
          ),
          const SizedBox(
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
