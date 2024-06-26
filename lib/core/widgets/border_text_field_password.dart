import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';

class BorderTextFieldPassword extends StatefulWidget {
  String? hintText;
  ValueChanged<String>? onChange;
  TextEditingController? controller;
  int maxLines;
  String? title;
  bool optional;

  BorderTextFieldPassword(
      {Key? key,
      this.hintText,
      this.onChange,
      this.controller,
      this.title,
      this.maxLines = 1,
      this.optional = true})
      : super(key: key);

  @override
  State<BorderTextFieldPassword> createState() =>
      _BorderTextFieldPasswordState();
}

class _BorderTextFieldPasswordState extends State<BorderTextFieldPassword> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(
                  bottom: MySpaces.s12, right: MySpaces.s4),
              child: Row(
                children: [
                  Text(
                    widget.title ?? '',
                    style: Light400Style.sm
                        .copyWith(color: MyColors.secondary.shade300),
                  ),
                  if (!widget.optional)
                    Text(
                      '*',
                      style: Light400Style.sm.copyWith(color: MyColors.error),
                    ),
                ],
              ),
            ),
          TextField(
            obscureText: passwordVisible,
            controller: widget.controller,
            onChanged: widget.onChange,
            style: Light400Style.normal.copyWith(color: MyColors.white),
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.white,
                  size: 17,
                ),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintStyle: Light400Style.normal.copyWith(color: MyColors.white),
              hintText: widget.hintText,
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
