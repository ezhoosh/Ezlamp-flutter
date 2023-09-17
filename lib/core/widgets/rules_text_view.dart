import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';

import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';

class RulesTextView extends StatelessWidget {
  const RulesTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: al.rol1,
              style: Light400Style.sm.copyWith(color: MyColors.white)),
          TextSpan(
            text: al.rol2,
            style: Light400Style.sm.copyWith(color: MyColors.info),
          ),
          TextSpan(
              text: al.rol3,
              style: Light400Style.sm.copyWith(color: MyColors.white)),
          TextSpan(
            text: al.rol4,
            style: Light400Style.sm.copyWith(color: MyColors.info),
          ),
          TextSpan(
              text: al.rol5,
              style: Light400Style.sm.copyWith(color: MyColors.white)),
        ],
      ),
    );
  }
}
