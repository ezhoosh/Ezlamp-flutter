import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: AlwaysStoppedAnimation(
            Localizations.localeOf(context).toString() == 'en'
                ? (180 / 360)
                : 0),
        child: SvgPicture.asset("assets/icons/arrow_right.svg"));
  }
}
