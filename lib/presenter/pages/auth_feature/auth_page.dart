import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/password_page.dart';
import 'package:easy_lamp/core/widgets/rules_text_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Material(
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
              al.registerOrLogin,
              style: SectionStyle.s1.copyWith(color: MyColors.primary),
            ),
            const SizedBox(height: MySpaces.s6),
            Text(
              al.descRegisterOrLogin,
              style:
                  Light400Style.sm.copyWith(color: MyColors.secondary.shade200),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MySpaces.s40),
            BorderTextField(hintText: al.phone),
            const SizedBox(height: MySpaces.s24),
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
            const SizedBox(height: MySpaces.s24),
            const RulesTextView(),
          ]),
        ),
      ),
    );
  }
}
