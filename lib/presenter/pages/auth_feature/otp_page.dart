import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/data/model/auth_status.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/password_page.dart';
import 'package:easy_lamp/presenter/pages/home_feature/home_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  AuthStatus status;
  String phoneNumber;

  OtpPage(this.phoneNumber, this.status, {Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late AppLocalizations al;
  String code = '';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.registerVerifyStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.registerVerifyStatus is BaseSuccess) {
            if (widget.status == AuthStatus.REGISTER) {
              RegisterVerifyModel model =
                  (state.registerVerifyStatus as BaseSuccess).entity;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PasswordPage(
                        widget.phoneNumber,
                        widget.status,
                        otp: model.token.toString(),
                      )));
            }
            EasyLoading.showSuccess("success");
          } else if (state.registerVerifyStatus is BaseError) {
            EasyLoading.showError("error");
          }
          if (state.loginStatus is BaseLoading ||
              state.registerStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.loginStatus is BaseSuccess ||
              state.registerStatus is BaseSuccess) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
            EasyLoading.showSuccess("success");
          } else if (state.loginStatus is BaseError ||
              state.registerStatus is BaseError) {
            EasyLoading.showError("error");
          }
        },
        child: Container(
          color: MyColors.black.shade700,
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_lamp.png"),
                alignment: Alignment.bottomLeft,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                al.otpCode,
                style: SectionStyle.s1.copyWith(color: MyColors.primary),
              ),
              const SizedBox(height: MySpaces.s6),
              Text(
                al.sendOtpToNumber.replaceAll("*number*", widget.phoneNumber),
                style: Light400Style.sm
                    .copyWith(color: MyColors.secondary.shade200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MySpaces.s40),
              Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  fieldWidth: 40,
                  numberOfFields: 4,
                  textStyle: DemiBoldStyle.normal.copyWith(
                    color: MyColors.white,
                  ),
                  borderWidth: 1,
                  borderColor: MyColors.primary,
                  enabledBorderColor: MyColors.white,
                  disabledBorderColor: MyColors.white,
                  focusedBorderColor: MyColors.primary,
                  showFieldAsBox: true,
                  borderRadius: MyRadius.sm,
                  onCodeChanged: (String code) => this.code += code,
                  onSubmit: (String code) {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Verification Code"),
                    //         content: Text('Code entered is '),
                    //       );
                    //     });
                    submitRegister(code);
                  }, // end onSubmit
                ),
              ),
              const SizedBox(height: MySpaces.s24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    submitRegister(code);
                  },
                  child: Text(
                    al.login,
                    style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
                  ),
                ),
              ),
              const SizedBox(height: MySpaces.s24),
              const RulesTextView(),
            ]),
          ),
        ),
      ),
    );
  }

  submitRegister(String code) {
    if (widget.status == AuthStatus.LOGIN) {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginEvent(widget.phoneNumber, code, ''));
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(RegisterVerifyEvent(widget.phoneNumber, code));
    }
  }
}
