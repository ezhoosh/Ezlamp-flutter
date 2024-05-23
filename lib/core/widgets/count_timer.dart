import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountTimer extends StatelessWidget {
  final Function? onFinished;

  CountTimer(this.onFinished, {super.key});
  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;

    return Countdown(
      seconds: 60,
      build: (BuildContext context, double time) => Text(
        "${time.toString().split(".")[0]} ${al.second}",
        style: Light400Style.sm,
      ),
      interval: const Duration(milliseconds: 1000),
      onFinished: onFinished,
    );
  }
}
