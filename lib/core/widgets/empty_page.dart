import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyPage extends StatelessWidget {
  String text;
  String? btnText;
  String imagePath;
  Function()? onTab;

  EmptyPage(this.text,
      {super.key,
      this.onTab,
      this.btnText,
      this.imagePath = "assets/images/cuate_lamp.png"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MySpaces.s40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            Text(
              text ?? AppLocalizations.of(context)!.addYourLamp,
              style: Light300Style.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                onPress: onTab,
                text: btnText,
                right: const Icon(
                  Icons.add,
                  color: MyColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
