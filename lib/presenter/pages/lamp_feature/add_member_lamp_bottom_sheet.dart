import 'package:easy_lamp/core/params/create_invitation_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/input_phone.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class AddMemberLampBottomSheet extends StatelessWidget {
  late AppLocalizations al;
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  List<LampModel> lamps;
  int groupId;

  AddMemberLampBottomSheet(this.groupId, this.lamps, {super.key});

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return BlocListener<InvitationBloc, InvitationState>(
      listenWhen: (prev, curr) {
        if (prev.createInvitationStatus is BaseSuccess &&
            curr.createInvitationStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.createInvitationStatus is BaseSuccess) {
          EasyLoading.showSuccess("SUCCESS");
          Navigator.pop(context);
        } else if (state.createInvitationStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.createInvitationStatus is BaseError) {
          EasyLoading.showError("ERROR");
        }
      },
      child: CustomBottomSheet(
        title: al.addMember,
        child: Column(
          children: [
            InputPhone(
              title: al.phone,
              hint: "000 000",
              textEditingController: _controllerPhone,
              isOptional: false,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            BorderTextField(
              title: al.message,
              controller: _controllerMessage,
              optional: false,
              hintText: al.message,
              maxLines: 4,
            ),
            const SizedBox(
              height: MySpaces.s24,
            ),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPress: () {
                  BlocProvider.of<InvitationBloc>(context)
                      .add(CreateInvitationEvent(CreateInvitationParams(
                    phoneNumber: _controllerPhone.text,
                    message: _controllerMessage.text,
                    groupLamp: groupId,
                    lamps: lamps.map((e) => e.id).toList(),
                  )));
                },
                text: al.save,
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