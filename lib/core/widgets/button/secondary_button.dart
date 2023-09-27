import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  Widget? right, left;
  String? text;
  VoidCallback? onPress;

  SecondaryButton({
    Key? key,
    this.right,
    this.left,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(MyColors.secondary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: MyRadius.sm,
                  side: const BorderSide(
                    color: MyColors.secondary,
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
              style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              width: MySpaces.s12,
            ),
            if (left != null) left!,
          ],
        ));
  }
}
