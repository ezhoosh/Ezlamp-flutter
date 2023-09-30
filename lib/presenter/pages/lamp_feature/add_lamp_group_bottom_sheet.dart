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

class AddLampGroupBottomSheet extends StatefulWidget {
  String uuid;
  int? groupId;

  AddLampGroupBottomSheet(this.uuid, {super.key, this.groupId}) {}

  @override
  State<AddLampGroupBottomSheet> createState() =>
      _AddLampGroupBottomSheetState();
}

class _AddLampGroupBottomSheetState extends State<AddLampGroupBottomSheet> {
  late AppLocalizations al;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return BlocListener<LampBloc, LampState>(
      listenWhen: (prev, curr) {
        if (prev.updateLampOwnerStatus is BaseSuccess &&
            curr.updateLampOwnerStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.updateLampOwnerStatus is BaseSuccess) {
          Navigator.pop(context);
          EasyLoading.showSuccess("SUCCESS");
        } else if (state.updateLampOwnerStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.updateLampOwnerStatus is BaseError) {
          EasyLoading.showError("ERROR");
        }
      },
      child: BlocListener<GroupBloc, GroupState>(
        listenWhen: (prev, curr) {
          if (prev.updateGroupOwnerStatus is BaseSuccess &&
              curr.updateGroupOwnerStatus is BaseNoAction) {
            return false;
          }
          return true;
        },
        listener: (context, state) {
          if (state.updateGroupOwnerStatus is BaseSuccess) {
            Navigator.pop(context);
            EasyLoading.showSuccess("SUCCESS");
          } else if (state.updateGroupOwnerStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.updateGroupOwnerStatus is BaseError) {
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
                controller: _controllerDesc,
                maxLines: 7,
              ),
              const SizedBox(
                height: MySpaces.s12,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.uuid
                        .startsWith('group-lamp/update-group-owner/')) {
                      BlocProvider.of<GroupBloc>(context).add(
                        UpdateGroupOwnerEvent(
                          UpdateGroupOwnerParams(
                            widget.uuid,
                            _controllerName.text,
                            _controllerDesc.text,
                          ),
                        ),
                      );
                    } else {
                      BlocProvider.of<LampBloc>(context).add(
                        UpdateLampOwnerEvent(
                          UpdateLampOwnerParams(
                            widget.groupId!,
                            _controllerName.text,
                            _controllerDesc.text,
                            widget.uuid,
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
