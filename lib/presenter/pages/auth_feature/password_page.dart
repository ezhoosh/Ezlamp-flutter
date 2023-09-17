import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
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
              al.enterYourPassword,
              style: SectionStyle.s1.copyWith(color: MyColors.primary),
            ),
            SizedBox(height: MySpaces.s40),
            BorderTextField(hintText: al.password),
            SizedBox(height: MySpaces.s12),
            Row(
              children: [
                Text(
                  al.loginWithOtpCode,
                  style: Light400Style.sm.copyWith(color: MyColors.primary),
                ),
                SizedBox(
                  width: MySpaces.s2,
                ),
                Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: MyColors.primary,
                )
              ],
            ),
            SizedBox(height: MySpaces.s12),
            Row(
              children: [
                Text(
                  al.forgetPassword,
                  style: Light400Style.sm.copyWith(color: MyColors.primary),
                ),
                SizedBox(
                  width: MySpaces.s2,
                ),
                Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: MyColors.primary,
                )
              ],
            ),
            SizedBox(height: MySpaces.s24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
