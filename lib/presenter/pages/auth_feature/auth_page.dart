import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/auth_status.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/password_page.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AppLocalizations al;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    context.read<AuthBloc>().add(GetVersionAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Material(
      child: Container(
        color: MyColors.black.shade700,
        padding: const EdgeInsets.all(20),
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) {
            if (previous.sendPhoneStatus is BaseSuccess &&
                current.sendPhoneStatus is BaseNoAction) {
              return false;
            }
            return true;
          },
          listener: (context, state) {
            if (state.sendPhoneStatus is BaseLoading) {
              EasyLoading.show();
            } else if (state.sendPhoneStatus is BaseSuccess) {
              // EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
              EasyLoading.dismiss();
              SendNumberModel model =
                  (state.sendPhoneStatus as BaseSuccess).entity;
              if (model.exist) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          PasswordPage(model.phoneNumber, AuthStatus.LOGIN)),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          OtpPage(model.phoneNumber, AuthStatus.REGISTER)),
                );
              }
            } else if (state.sendPhoneStatus is BaseError) {
              ErrorHelper.getBaseError(state.sendPhoneStatus, context);
            }
          },
          child: Stack(
            children: [
              Container(
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
                    al.registerOrLogin,
                    style: SectionStyle.s1.copyWith(color: MyColors.primary),
                  ),
                  const SizedBox(height: MySpaces.s6),
                  Text(
                    al.descRegisterOrLogin,
                    style: Light400Style.sm
                        .copyWith(color: MyColors.secondary.shade200),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: MySpaces.s40),
                  BorderTextField(
                    hintText: al.phone,
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    isPersianNumber: LocalizationService.isLocalPersian,
                  ),
                  const SizedBox(height: MySpaces.s24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        String value = _controller.text.toEnglishDigit();
                        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = RegExp(pattern);
                        if (value.isEmpty || !regExp.hasMatch(value)) {
                          EasyLoading.showToast(al.errorPhoneNumber);
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context)
                            .add(SendPhoneNumberEvent(value));
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if(state.getVersion is BaseSuccess){
                    String version = (state.getVersion as BaseSuccess).entity;
                    return Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(LocalizationService.isLocalPersian? "v ${version.toPersianDigit()}" : "v $version", style: DemiBoldStyle.sm.copyWith(color: MyColors.white),));
                  }else{
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
