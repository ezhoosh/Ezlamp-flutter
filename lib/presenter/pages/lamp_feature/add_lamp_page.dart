import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLampPage extends StatefulWidget {
  const AddLampPage({super.key});

  @override
  State<AddLampPage> createState() => _AddLampPageState();
}

class _AddLampPageState extends State<AddLampPage> {
  late AppLocalizations al;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
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
              controller: _controller,
            ),
            const SizedBox(
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
            const SizedBox(
              height: MySpaces.s24,
            ),
          ],
        ),
      ),
    );
  }
}
