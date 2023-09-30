import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';

class BorderTextField extends StatelessWidget {
  String? hintText;
  ValueChanged<String>? onChange;
  TextEditingController? controller;
  int maxLines;
  String? title;
  bool optional;

  BorderTextField(
      {Key? key,
      this.hintText,
      this.onChange,
      this.controller,
      this.title,
      this.maxLines = 1,
      this.optional = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(
                  bottom: MySpaces.s12, right: MySpaces.s4),
              child: Row(
                children: [
                  Text(
                    title ?? '',
                    style: Light300Style.sm
                        .copyWith(color: MyColors.secondary.shade300),
                  ),
                  if (!optional)
                    Text(
                      '*',
                      style: Light300Style.sm.copyWith(color: MyColors.error),
                    ),
                ],
              ),
            ),
          TextField(
            controller: controller,
            onChanged: onChange,
            style: Light400Style.normal.copyWith(color: MyColors.white),
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintStyle: Light400Style.normal.copyWith(color: MyColors.white),
              hintText: hintText,
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
                borderSide: const BorderSide(
                  width: 1,
                ),
                borderRadius: MyRadius.sm,
              ),
              errorStyle: Light300Style.sm.copyWith(color: MyColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
