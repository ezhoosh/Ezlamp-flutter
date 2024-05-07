import 'package:easy_lamp/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BorderTextField extends StatelessWidget {
  String? hintText;
  ValueChanged<String>? onChange;
  TextEditingController? controller;
  int maxLines;
  String? title;
  bool optional;
  TextInputType? keyboardType;
  bool isPersianNumber;
  BorderTextField(
      {Key? key,
      this.hintText,
      this.onChange,
      this.controller,
      this.title,
      this.maxLines = 1,
      this.optional = true,
      this.keyboardType,
      this.isPersianNumber = false})
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
            onChanged: isPersianNumber == false ? onChange : (value) {
              if (LocalizationService.isLocalPersian) {
                value = value.toPersianDigit();
              }
              controller!.value =
                  TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(
                        offset: value.length),
                  );
            },
            style: Light400Style.normal.copyWith(color: MyColors.white),
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.secondary.shade500),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintStyle: Light400Style.normal.copyWith(
                color: MyColors.white.shade500,
              ),
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
