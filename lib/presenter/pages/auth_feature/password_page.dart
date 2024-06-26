import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/widgets/border_text_field_password.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/auth_status.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/otp_page.dart';
import 'package:easy_lamp/presenter/pages/home_feature/home_page.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/connection_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';

class PasswordPage extends StatefulWidget {
  String phoneNumber;
  String otp;
  AuthStatus status;

  PasswordPage(this.phoneNumber, this.status, {Key? key, this.otp = ''})
      : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late AppLocalizations al;
  late TextEditingController _controller;
  bool v1 = false, v2 = false, v3 = false, v4 = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
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

          if (state.sendLoginOtpStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.sendLoginOtpStatus is BaseSuccess) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    OtpPage(widget.phoneNumber, widget.status)));
            // EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
            EasyLoading.dismiss();
          } else if (state.sendLoginOtpStatus is BaseError) {
            ErrorHelper.getBaseError(state.sendLoginOtpStatus, context);
          }
          if (state.sendResetOtpStatus is BaseLoading) {
            EasyLoading.show();
          } else if (state.sendResetOtpStatus is BaseSuccess) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    OtpPage(widget.phoneNumber, AuthStatus.RESET)));
            // EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
            EasyLoading.dismiss();
          } else if (state.sendResetOtpStatus is BaseError) {
            ErrorHelper.getBaseError(state.sendResetOtpStatus, context);
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
                al.enterYourPassword,
                style: SectionStyle.s1.copyWith(color: MyColors.primary),
              ),
              const SizedBox(height: MySpaces.s40),
              BorderTextFieldPassword(
                onChange: (t) {
                  v1 = RegExp(r'\b\w{8,}\b').hasMatch(t);
                  v2 = RegExp(r'[A-Z]+').hasMatch(t);
                  v3 = RegExp(r'[a-z]+').hasMatch(t);
                  v4 = RegExp(r'[0-9]+').hasMatch(t);
                  setState(() {});
                },
                hintText: al.password,
                controller: _controller,
              ),
              const SizedBox(
                height: MySpaces.s16,
              ),
              if (widget.status == AuthStatus.LOGIN)
                InkWell(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SendLoginOtpEvent(widget.phoneNumber));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(MySpaces.s8),
                    child: Row(
                      children: [
                        Text(
                          al.loginWithOtpCode,
                          style:
                              Light400Style.sm.copyWith(color: MyColors.primary),
                        ),
                        const SizedBox(
                          width: MySpaces.s2,
                        ),
                        Icon(
                          LocalizationService.isLocalPersian ?  Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded,
                          color: MyColors.primary,
                        )
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: MySpaces.s12),
              if (widget.status == AuthStatus.LOGIN)
                InkWell(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SendResetOtpEvent(widget.phoneNumber));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(MySpaces.s8),
                    child: Row(
                      children: [
                        Text(
                          al.forgetPassword,
                          style:
                              Light400Style.sm.copyWith(color: MyColors.primary),
                        ),
                        const SizedBox(
                          width: MySpaces.s2,
                        ),
                        Icon(
                          LocalizationService.isLocalPersian ?  Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded,
                          color: MyColors.primary,
                        )
                      ],
                    ),
                  ),
                ),
              if (widget.status == AuthStatus.REGISTER)
                Column(
                  children: [
                    getValidate(AppLocalizations.of(context)!.minimum8Characters, v1),
                    getValidate(AppLocalizations.of(context)!.minimum1Uppercase, v2),
                    getValidate(AppLocalizations.of(context)!.minimum1Lowercase, v3),
                    getValidate(AppLocalizations.of(context)!.minimum1Number, v4),
                  ],
                ),
              const SizedBox(height: MySpaces.s24),
              Opacity(
                opacity: widget.status == AuthStatus.REGISTER &&
                        (!v1 || !v2 || !v3 || !v4)
                    ? 0.3
                    : 1,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.status == AuthStatus.LOGIN) {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            widget.phoneNumber, '', _controller.text));
                      } else {
                        BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                            widget.phoneNumber, widget.otp, _controller.text));
                      }
                    },
                    child: Text(
                      al.login,
                      style:
                          DemiBoldStyle.normal.copyWith(color: MyColors.white),
                    ),
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
