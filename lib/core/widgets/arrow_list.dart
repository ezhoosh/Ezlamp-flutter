import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowList extends StatelessWidget {
  const ArrowList({super.key});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: AlwaysStoppedAnimation(
            Localizations.localeOf(context).toString() == 'en'
                ? 0
                : (180 / 360)),
        child: SvgPicture.asset(
          "assets/icons/arrow_right.svg",
          color: MyColors.white,
        ));
  }
}
