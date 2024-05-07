import 'package:easy_lamp/core/params/create_invitation_group_params.dart';
import 'package:easy_lamp/core/params/create_invitation_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/core/widgets/input_group.dart';
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

class AddMemberGroupBottomSheet extends StatefulWidget {
  AddMemberGroupBottomSheet({super.key});

  @override
  State<AddMemberGroupBottomSheet> createState() =>
      _AddMemberGroupBottomSheetState();
}

class _AddMemberGroupBottomSheetState extends State<AddMemberGroupBottomSheet> {
  late AppLocalizations al;
  List<LampModel> lamps = [];
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();

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
          EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
          Navigator.pop(context);
        } else if (state.createInvitationStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.createInvitationStatus is BaseError) {
          ErrorHelper.getBaseError(state.createInvitationStatus, context);
        }
      },
      child: CustomBottomSheet(
        title: al.addMember,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputPhone(
                title: al.phone,
                hint: "9123456789",
                textEditingController: _controllerPhone,
                isOptional: false,
              ),
              const SizedBox(
                height: MySpaces.s12,
              ),
              InputGroupSelect(
                title: al.selectGroup,
                isDate: true,
                prevValue: lamps,
                onNewDateSelected: (List<LampModel> newValue) {
                  lamps = newValue;
                },
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
                    Map<int, List<int>> data = {};
                    for (LampModel lamp in lamps) {
                      if (data.containsKey(lamp.groupLamp)) {
                        data[lamp.groupLamp]?.add(lamp.id);
                      } else {
                        data[lamp.groupLamp] = [lamp.id];
                      }
                    }

                    String phone = _controllerPhone.text;
                    if (!phone.startsWith('0')) {
                      phone = '0$phone';
                    }
                    BlocProvider.of<InvitationBloc>(context).add(
                        CreateInvitationGroupEvent(CreateInvitationGroupParams(
                      phoneNumber: phone,
                      message: _controllerMessage.text,
                      lamps: data,
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
      ),
    );
  }
}
