import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';

class BorderTextField extends StatelessWidget {
  String? hintText;
  ValueChanged<String>? onChange;

  BorderTextField({Key? key, this.hintText, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        onChanged: onChange,
        style: Light400Style.normal.copyWith(color: MyColors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintStyle: Light400Style.normal.copyWith(color: MyColors.white),
          hintText: this.hintText,
          fillColor: MyColors.black.shade500,
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.0),
              borderRadius: MyRadius.sm),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.0),
              borderRadius: MyRadius.sm),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.0),
              borderRadius: MyRadius.sm),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
            ),
            borderRadius: MyRadius.sm,
          ),
          errorStyle: Light300Style.sm.copyWith(color: MyColors.error),
        ),
      ),
    );
  }
}