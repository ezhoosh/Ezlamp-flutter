import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class AddGroupBottomSheet extends StatelessWidget {
  late AppLocalizations al;
  late TextEditingController _controllerName;
  late TextEditingController _controllerDesc;

  AddGroupBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    _controllerName = TextEditingController();
    _controllerDesc = TextEditingController();
    return BlocListener<GroupBloc, GroupState>(
      listenWhen: (prev, curr) {
        if (prev.createGroupStatus is BaseSuccess &&
            curr.createGroupStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.createGroupStatus is BaseSuccess) {
          Navigator.pop(context);
          EasyLoading.showSuccess("SUCCESS");
        } else if (state.createGroupStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.createGroupStatus is BaseError) {
          EasyLoading.showError("ERROR");
        }
      },
      child: CustomBottomSheet(
        title: AppLocalizations.of(context)!.addGroup,
        child: Column(
          children: [
            BorderTextField(
              hintText: al.title,
              controller: _controllerName,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            BorderTextField(
              hintText: al.desc,
              controller: _controllerDesc,
              maxLines: 4,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GroupBloc>(context).add(CreateGroupEvent(
                      _controllerName.text, _controllerDesc.text));
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
