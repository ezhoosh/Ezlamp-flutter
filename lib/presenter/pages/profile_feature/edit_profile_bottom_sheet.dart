import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class EditProfileBottomSheet extends StatelessWidget {
  late AppLocalizations al;
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return BlocListener<UserBloc, UserState>(
      listenWhen: (prev, curr) {
        if (prev.updateUserStatus is BaseSuccess &&
            curr.updateUserStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.updateUserStatus is BaseSuccess) {
          EasyLoading.showSuccess("SUCCESS");
        } else if (state.updateUserStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.updateUserStatus is BaseError) {
          EasyLoading.showError("ERROR");
        }
      },
      child: CustomBottomSheet(
        title: AppLocalizations.of(context)!.editGroupName,
        child: Column(
          children: [
            BorderTextField(
              hintText: al.firstName,
              controller: _controllerFirstName,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            BorderTextField(
              hintText: al.lastName,
              controller: _controllerLastName,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            BorderTextField(
              hintText: al.email,
              controller: _controllerEmail,
            ),
            const SizedBox(
              height: MySpaces.s24,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(UpdateUserEvent(
                    _controllerLastName.text,
                    _controllerFirstName.text,
                    _controllerEmail.text,
                  ));
                },
                child: Text(
                  al.save,
                  style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
                ),
              ),
            ),
            const SizedBox(
              height: MySpaces.s24,
            ),
          ],
        ),
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