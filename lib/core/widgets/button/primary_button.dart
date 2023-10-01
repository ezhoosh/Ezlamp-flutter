import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  Widget? right, left;
  String? text;
  VoidCallback? onPress;
  Color bg;

  PrimaryButton(
      {Key? key,
      this.right,
      this.left,
      this.text,
      this.onPress,
      this.bg = MyColors.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
            const SizedBox(
              width: MySpaces.s12,
            ),
            Text(
              text ?? '',
              style: Light400Style.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              width: MySpaces.s12,
            ),
            if (left != null) left!,
          ],
        ));
  }
}
