import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  Widget? right, left;
  String? text;
  VoidCallback? onPress;
  Color bg;
  Color textColor;
  double h;

  PrimaryButton(
      {Key? key,
      this.right,
      this.left,
      this.text,
      this.onPress,
      this.bg = MyColors.primary,
      this.textColor = MyColors.white,
      this.h = 35})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
      child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bg),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: MyRadius.sm,
                    side: BorderSide(
                      color: bg,
                    ))),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (right != null) right!,
              if (right != null)
                const SizedBox(
                  width: MySpaces.s12,
                ),
              Text(
                text ?? '',
                style: Light400Style.normal.copyWith(color: textColor),
              ),
              if (left != null)
                const SizedBox(
                  width: MySpaces.s12,
                ),
              if (left != null) left!,
            ],
          )),
    );
  }
}
