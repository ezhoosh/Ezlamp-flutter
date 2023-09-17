import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Material(
        child: Container(
            color: MyColors.black.shade700,
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/bg_lamp.png"),
                alignment: Alignment.bottomLeft,
              )),
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "ورود / ثبت‌نام",
                  style: SectionStyle.s1.copyWith(color: MyColors.primary),
                ),
                SizedBox(height: MySpaces.s6),
                Text(
                  "سلام!\nلطفا شماره موبایل یا ایمیل خود را وارد کنید",
                  style: Light400Style.sm
                      .copyWith(color: MyColors.secondary.shade200),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MySpaces.s40),
                BorderTextField(hintText: 'شماره تماس'),
                SizedBox(height: MySpaces.s24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "ورود",
                        style: DemiBoldStyle.normal
                            .copyWith(color: MyColors.white),
                      )),
                ),
                SizedBox(height: MySpaces.s24),
                RichText(
                  text: TextSpan(
                    style: Light400Style.sm,
                    children: <TextSpan>[
                      TextSpan(text: 'ورود شما به معنای'),
                      TextSpan(
                        text: ' پذیرش شرایط',
                        style: Light400Style.sm.copyWith(color: MyColors.info),
                      ),
                      TextSpan(text: ' قوانین'),
                      TextSpan(
                        text: ' حریم‌خصوصی',
                        style: Light400Style.sm.copyWith(color: MyColors.info),
                      ),
                      TextSpan(text: ' است'),
                    ],
                  ),
                )
              ]),
            )));
  }

  @override
  void initState() {}
}
