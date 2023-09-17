import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/password_page.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  String phoneNumber;

  OtpPage(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Material(
      child: Container(
        color: MyColors.black.shade700,
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_lamp.png"),
              alignment: Alignment.bottomLeft,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              al.otpCode,
              style: SectionStyle.s1.copyWith(color: MyColors.primary),
            ),
            SizedBox(height: MySpaces.s6),
            Text(
              al.sendOtpToNumber.replaceAll("*number*", widget.phoneNumber),
              style:
                  Light400Style.sm.copyWith(color: MyColors.secondary.shade200),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MySpaces.s40),
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
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //       );
                  //     });
                }, // end onSubmit
              ),
            ),
            SizedBox(height: MySpaces.s24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PasswordPage()),
                  );
                },
                child: Text(
                  al.login,
                  style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
                ),
              ),
            ),
            SizedBox(height: MySpaces.s24),
            RulesTextView(),
          ]),
        ),
      ),
    );
  }
}
