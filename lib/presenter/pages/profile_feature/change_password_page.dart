import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_back.dart';
import 'package:easy_lamp/core/widgets/border_text_field_password.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late AppLocalizations al;
  late TextEditingController _controllerNew;
  late TextEditingController _controllerCurrent;
  bool v1 = false, v2 = false, v3 = false, v4 = false;

  @override
  void initState() {
    super.initState();
    _controllerNew = TextEditingController();
    _controllerCurrent = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) {
          if (prev.changePasswordStatus is BaseSuccess &&
              curr.changePasswordStatus is BaseNoAction) {
            return false;
          }
          return true;
        },
        listener: (context, state) {
          if (state.changePasswordStatus is BaseSuccess) {
            Navigator.pop(context);
            EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
          } else if (state.changePasswordStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.changePasswordStatus is BaseError) {
            ErrorHelper.getBaseError(state.changePasswordStatus, context);
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              TopBar(
                title: al.changePassword,
                iconRight: ArrowBack(),
                onTapRight: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: MySpaces.s32,
              ),
              BorderTextFieldPassword(
                optional: false,
                title: al.currentPassword,
                onChange: (t) {},
                hintText: al.password,
                controller: _controllerCurrent,
              ),
              const SizedBox(height: MySpaces.s24),
              BorderTextFieldPassword(
                optional: false,
                title: al.newPassword,
                onChange: (t) {
                  v1 = RegExp(r'\b\w{8,}\b').hasMatch(t);
                  v2 = RegExp(r'[A-Z]+').hasMatch(t);
                  v3 = RegExp(r'[a-z]+').hasMatch(t);
                  v4 = RegExp(r'[0-9]+').hasMatch(t);
                  setState(() {});
                },
                hintText: al.password,
                controller: _controllerNew,
              ),
              const SizedBox(height: MySpaces.s12),
              Column(
                children: [
                  getValidate(al.at_least_8_characters, v1),
                  getValidate(al.at_least_1_capital_letter, v2),
                  getValidate(al.at_least_1_lower_letter, v3),
                  getValidate(al.at_least_1_number, v4),
                ],
              ),
              const SizedBox(height: MySpaces.s24),
              Opacity(
                opacity: (!v1 || !v2 || !v3 || !v4) ? 0.3 : 1,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (!v1 || !v2 || !v3 || !v4)
                        ? null
                        : () {
                            BlocProvider.of<AuthBloc>(context).add(
                                ChangePasswordEvent(_controllerCurrent.text,
                                    _controllerNew.text));
                          },
                    child: Text(
                      al.save,
                      style:
                          DemiBoldStyle.normal.copyWith(color: MyColors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  getValidate(String s, bool b) {
    return Container(
      margin: const EdgeInsets.only(top: MySpaces.s4),
      child: Row(
        children: [
          Icon(
            b ? Icons.check : Icons.close,
            color: b ? MyColors.success : MyColors.error,
          ),
          Text(
            s,
            style: Light300Style.xs.copyWith(
              color: MyColors.secondary.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
