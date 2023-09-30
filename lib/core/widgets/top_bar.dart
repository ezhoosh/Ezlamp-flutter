import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends StatelessWidget {
  String? title;
  GestureTapCallback? onTapRight;
  GestureTapCallback? onTapLeft;
  Widget? iconRight;
  Widget? iconLeft;

  TopBar(
      {super.key,
      this.title,
      this.iconRight,
      this.onTapRight,
      this.onTapLeft,
      this.iconLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          if (iconRight != null)
            InkWell(
                borderRadius: MyRadius.sm, onTap: onTapRight, child: iconRight),
          Expanded(
            child: Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: TitleStyle.t4.copyWith(
                color: MyColors.white,
              ),
            ),
          ),
          if (iconLeft != null)
            InkWell(
                borderRadius: MyRadius.sm, onTap: onTapLeft, child: iconLeft),
        ],
      ),
    );
  }
}
