import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/count_timer.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/auth_status.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/password_page.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/reset_password_page.dart';
import 'package:easy_lamp/presenter/pages/home_feature/home_page.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/change_password_page.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/connection_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  AuthStatus status;
  String phoneNumber;

  OtpPage(this.phoneNumber, this.status, {Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late AppLocalizations al;
  bool isFinish = false;
  final TextEditingController _otp_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state.resetPasswordStatus is BaseLoading){
            EasyLoading.show();
          }else if(state.resetPasswordStatus is BaseSuccess){
            if (widget.status == AuthStatus.RESET) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ResetPasswordPage(phone: widget.phoneNumber)));
              EasyLoading.dismiss();
            }
          }
          if (state.registerVerifyStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.registerVerifyStatus is BaseSuccess) {
            if (widget.status == AuthStatus.REGISTER) {
              RegisterVerifyModel model =
                  (state.registerVerifyStatus as BaseSuccess).entity;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PasswordPage(
                        widget.phoneNumber,
                        AuthStatus.REGISTER,
                        otp: model.token.toString(),
                      )));
            }
            // EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
            EasyLoading.dismiss();
          } else if (state.registerVerifyStatus is BaseError) {
            ErrorHelper.getBaseError(state.registerVerifyStatus, context);
          }
          if (state.loginStatus is BaseLoading ||
              state.registerStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.loginStatus is BaseSuccess ||
              state.registerStatus is BaseSuccess) {
            // if (kIsWeb) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  ModalRoute.withName("/"));
            // } else {
            //   Navigator.of(context).pushAndRemoveUntil(
            //       MaterialPageRoute(
            //           builder: (context) => const ConnectionPage()),
            //       ModalRoute.withName("/"));
            // }
            // EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
            EasyLoading.dismiss();
          } else if (state.loginStatus is BaseError) {
            ErrorHelper.getBaseError(state.loginStatus, context);
          } else if (state.registerStatus is BaseError) {
            ErrorHelper.getBaseError(state.registerStatus, context);
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
                LocalizationService.isLocalPersian
                    ? al.sendOtpToNumber.replaceAll("*number*", widget.phoneNumber).toPersianDigit()
                    : al.sendOtpToNumber.replaceAll("*number*", widget.phoneNumber.toString()),
                style: Light400Style.sm
                    .copyWith(color: MyColors.secondary.shade200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MySpaces.s6),
              if (isFinish)
                ClickableContainer(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    al.checkPhone,
                    style: Light400Style.sm.copyWith(color: MyColors.primary),
                  ),
                )
              else
                CountTimer(() {
                  setState(() {
                    isFinish = true;
                  });
                }),
              const SizedBox(height: MySpaces.s40),
              Directionality(
                textDirection: TextDirection.ltr,
                child:
                Pinput(
                  onCompleted: (pin) {
                    submitRegister(_otp_controller.text.toString());
                  },
                  // onChanged: (value)  {
                  //   if (LocalizationService.isLocalPersian) {
                  //     value = value.toPersianDigit();
                  //   }
                  //   _otp_controller.value =
                  //       TextEditingValue(
                  //         text: value,
                  //         selection: TextSelection.collapsed(
                  //             offset: value.length),
                  //       );
                  // },
                  defaultPinTheme: PinTheme(
                    width: 40,
                    height: 40,
                    textStyle: DemiBoldStyle.normal.copyWith(
                      color: MyColors.white,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.noColor,
                      borderRadius: MyRadius.sm ,
                      border: Border.all(color: MyColors.white, width: 1),
                    ),
                  ),
                  focusedPinTheme:  PinTheme(
                    width: 40,
                    height: 40,
                    textStyle: DemiBoldStyle.normal.copyWith(
                      color: MyColors.white,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.noColor,
                      borderRadius: MyRadius.sm ,
                      border: Border.all(color: MyColors.primary,width: 1),
                    ),
                  ),
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                  controller: _otp_controller,
                ),
              ),
              const SizedBox(height: MySpaces.s24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    submitRegister(_otp_controller.text.toString());
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
    code = code.toEnglishDigit();
    if (widget.status == AuthStatus.LOGIN) {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginEvent(widget.phoneNumber, code, ''));
    } else if (widget.status == AuthStatus.RESET) {
      BlocProvider.of<AuthBloc>(context)
          .add(ResetPasswordOtpEvent(widget.phoneNumber, code));
      // BlocProvider.of<AuthBloc>(context)
      //     .add(RegisterVerifyEvent(widget.phoneNumber, code));
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(RegisterVerifyEvent(widget.phoneNumber, code));
    }
  }
}
