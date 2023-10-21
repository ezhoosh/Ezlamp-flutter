import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;

class InputExportType extends StatefulWidget {
  InputExportType({
    Key? key,
    required this.title,
    required this.onNewDateSelected,
    this.description,
    this.isDisabled,
    this.hint,
    this.prevDate,
    this.optional = true,
    this.isDate = false,
  }) : super(key: key);

  final String? title;
  String? prevDate;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;

  final Function(String newDate) onNewDateSelected;

  @override
  State<InputExportType> createState() => _InputExportTypeState();
}

class _InputExportTypeState extends State<InputExportType> {
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Column(
      children: [
        if (widget.title != null)
          Padding(
            padding:
                const EdgeInsets.only(bottom: MySpaces.s12, right: MySpaces.s4),
            child: Row(
              children: [
                Text(
                  widget.title ?? '',
                  style: Light300Style.sm
                      .copyWith(color: MyColors.secondary.shade300),
                ),
                if (!widget.optional)
                  Text(
                    '*',
                    style: Light300Style.sm.copyWith(color: MyColors.error),
                  ),
              ],
            ),
          ),
        SizedBox(
          height: 54,
          child: ClickableContainer(
              onTap: () {
                if (widget.isDisabled != null && widget.isDisabled!) return;

                _handleClickOnSelectDate();
              },
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: (widget.isDisabled != null && widget.isDisabled!)
                  ? MyColors.primary
                  : MyColors.black.shade500,
              borderRadius: MyRadius.sm,
              border: Border.all(color: MyColors.black.shade500, width: 1),
              child: Row(children: [
                Expanded(
                  child: Text(
                    widget.prevDate ??
                        widget.hint ??
                        AppLocalizations.of(context)!.select(""),
                    textAlign: widget.prevDate == null
                        ? TextAlign.start
                        : TextAlign.end,
                    style: widget.prevDate == null
                        ? Light300Style.sm
                            .copyWith(color: MyColors.secondary.shade300)
                        : Light300Style.sm
                            .copyWith(color: MyColors.secondary.shade500),
                  ),
                ),
                const SizedBox(width: MySpaces.s8),
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 24,
                  color: Colors.white,
                ),
              ])),
        )
      ],
    );
  }

  void _handleClickOnSelectDate() {
    List<String> items = [
      'مصرف بر حسب وات',
      'دما رطوبت',
      'سنسور حرکتی',
      'سنسور نور'
    ];
    String current = '';
    showModalBottomSheet(
      context: _buildContext,
      isScrollControlled: true,
      barrierColor: MyColors.noColor,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
              color: MyColors.black.shade500,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child: Wrap(
            children: [
              Column(
                children: [
                  ClickableContainer(
                      height: 54,
                      margin: const EdgeInsets.symmetric(
                        horizontal: MySpaces.s12,
                        vertical: MySpaces.s8,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      color: (widget.isDisabled != null && widget.isDisabled!)
                          ? MyColors.primary
                          : MyColors.black.shade500,
                      borderRadius: MyRadius.sm,
                      border: Border.all(
                          color: MyColors.secondary.shade300, width: 1),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            widget.prevDate ??
                                widget.hint ??
                                AppLocalizations.of(context)!.select(""),
                            textAlign: TextAlign.end,
                            style: Light300Style.sm
                                .copyWith(color: MyColors.secondary.shade300),
                          ),
                        ),
                        const SizedBox(width: MySpaces.s8),
                        const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 24,
                          color: Colors.white,
                        ),
                      ])),
                  ...items
                      .map((e) => Row(
                            children: [
                              Radio(
                                fillColor:
                                    MaterialStateProperty.all(MyColors.primary),
                                activeColor: MyColors.primary,
                                value: e,
                                groupValue: current,
                                onChanged: (t) {
                                  this.setState(() {
                                    widget.prevDate = t;
                                  });
                                },
                              ),
                              Text(
                                e,
                                style: Light300Style.normal.copyWith(
                                    color: MyColors.secondary.shade300),
                              ),
                            ],
                          ))
                      .toList()
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
