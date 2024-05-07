import 'package:easy_lamp/core/widgets/error_helper.dart';
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

class EditGroupNameBottomSheet extends StatefulWidget {
  int groupId;

  EditGroupNameBottomSheet(this.groupId, {super.key});

  @override
  State<EditGroupNameBottomSheet> createState() =>
      _EditGroupNameBottomSheetState();
}

class _EditGroupNameBottomSheetState extends State<EditGroupNameBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return CustomBottomSheet(
      title: AppLocalizations.of(context)!.editGroupName,
      child: Column(
        children: [
          BorderTextField(
            hintText: al.title,
            controller: _controller,
          ),
          const SizedBox(
            height: MySpaces.s12,
          ),
          BlocListener<GroupBloc, GroupState>(
            listenWhen: (prev, curr) {
              if ((prev.updateGroupNameStatus is BaseError &&
                      curr.updateGroupNameStatus is BaseSuccess) ||
                  (prev.updateGroupNameStatus is BaseError &&
                      curr.updateGroupNameStatus is BaseNoAction)) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state.updateGroupNameStatus is BaseSuccess) {
                Navigator.pop(context);
                EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
              } else if (state.updateGroupNameStatus is BaseLoading) {
                EasyLoading.show();
              } else if (state.updateGroupNameStatus is BaseError) {
                ErrorHelper.getBaseError(state.updateGroupNameStatus, context);
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GroupBloc>(context).add(
                    UpdateGroupNameEvent(
                      EditGroupNameParams(
                        _controller.text,
                        widget.groupId,
                      ),
                    ),
                  );
                },
                child: Text(
                  al.save,
                  style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
                ),
              ),
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
