import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
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

class AddLampGroupBottomSheet extends StatelessWidget {
  late AppLocalizations al;
  late TextEditingController _controllerName;
  late TextEditingController _controllerDesc;
  String uuid;
  int? lampId;

  AddLampGroupBottomSheet(this.uuid, {super.key, this.lampId});

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    _controllerName = TextEditingController();
    _controllerDesc = TextEditingController();
    return BlocListener<GroupBloc, GroupState>(
      listenWhen: (prev, curr) {
        if (prev.updateGroupNameStatus is BaseSuccess &&
            curr.updateGroupNameStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.updateGroupNameStatus is BaseSuccess) {
          EasyLoading.showSuccess("SUCCESS");
        } else if (state.updateGroupNameStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.updateGroupNameStatus is BaseError) {
          EasyLoading.showError("ERROR");
        }
      },
      child: CustomBottomSheet(
        title: AppLocalizations.of(context)!.editGroupName,
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
              controller: _controllerName,
              maxLines: 7,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (uuid.startsWith('GROUP')) {
                    uuid = uuid.replaceAll("GROUP", '');
                    BlocProvider.of<LampBloc>(context).add(
                      UpdateLampOwnerEvent(
                        UpdateLampOwnerParams(
                          lampId!,
                          _controllerName.text,
                          _controllerDesc.text,
                          uuid,
                        ),
                      ),
                    );
                  } else {
                    uuid = uuid.replaceAll("LAMP", '');
                    BlocProvider.of<GroupBloc>(context).add(
                      UpdateGroupOwnerEvent(
                        UpdateGroupOwnerParams(
                          uuid,
                          _controllerName.text,
                          _controllerDesc.text,
                        ),
                      ),
                    );
                  }
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
