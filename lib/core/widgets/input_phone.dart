import 'dart:io';

import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';

class InputPhone extends StatelessWidget {
  InputPhone(
      {Key? key,
      required this.title,
      required this.textEditingController,
      this.isOptional = true,
      this.validator,
      this.lines,
      this.hint,
      this.textDirection,
      this.textInputFormatters,
      this.maxLength,
      this.isDisabled,
      this.description,
      this.focusNode,
      this.isSpacer = true,
      this.textAlign = TextAlign.left})
      : super(key: key);

  final TextAlign textAlign;

  final int? lines;
  final String? hint;
  final int? maxLength;
  final String title;
  final TextDirection? textDirection;
  final TextEditingController textEditingController;
  final String? description;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? textInputFormatters;
  final bool? isDisabled;
  final bool isSpacer;
  final bool isOptional;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return textDirection == null
        ? _buildChild(context)
        : Directionality(
            textDirection: textDirection!, child: _buildChild(context));
  }

  static const double inputCornerRadius = 12;
  static var borderRadiusInput = BorderRadius.circular(inputCornerRadius);

  Widget _buildChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          const SizedBox(width: MySpaces.s4),
          Text(
            title,
            style:
                Light300Style.sm.copyWith(color: MyColors.secondary.shade300),
          ),
          if (!isOptional)
            Text(
              "*",
              style: Light400Style.normal.copyWith(color: MyColors.error),
            ),
          if (isSpacer)
            const Spacer()
          else
            const SizedBox(
              width: 5,
            ),
          if (description != null)
            Text(
              description!,
              style:
                  Light400Style.xs.copyWith(color: MyColors.secondary.shade400),
              maxLines: 1,
            ),
          const SizedBox(width: MySpaces.s4),
        ]),
        const SizedBox(height: MySpaces.s4),
        Container(
          decoration: BoxDecoration(
            color: MyColors.black.shade500,
            borderRadius: MyRadius.sm,
          ),
          padding: const EdgeInsets.symmetric(horizontal: MySpaces.s12),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  enabled: (isDisabled == null || !isDisabled!),
                  readOnly: (isDisabled != null && isDisabled!),
                  textInputAction: TextInputAction.done,
                  validator: validator,
                  minLines: lines,
                  maxLength: maxLength,
                  maxLines: lines,
                  textAlign: TextAlign.left,
                  inputFormatters: textInputFormatters,
                  controller: textEditingController,
                  style: Light400Style.sm.copyWith(color: MyColors.white),
                  decoration: InputDecoration(
                      hintText: hint,
                      border: InputBorder.none,
                      fillColor: MyColors.noColor,
                      hintStyle: Light400Style.sm
                          .copyWith(color: MyColors.secondary.shade300)),
                ),
              ),
              const SizedBox(
                width: MySpaces.s6,
              ),
              Text('98+',
                  style: Light400Style.sm
                      .copyWith(color: MyColors.secondary.shade800)),
              const SizedBox(
                width: MySpaces.s6,
              ),
              SvgPicture.asset('assets/icons/flag_iran.svg'),
            ],
          ),
        ),
      ],
    );
  }
}
