import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/data/model/result_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;

class InputExportType extends StatefulWidget {
  InputExportType(
    this.data, {
    Key? key,
    required this.title,
    required this.onNewDateSelected,
    this.description,
    this.isDisabled,
    this.hint,
    this.prevValue,
    this.optional = true,
    this.isDate = false,
  }) : super(key: key);

  final String? title;
  ResultTypeModel? prevValue;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;
  List<ResultTypeModel> data;

  final Function(ResultTypeModel newDate) onNewDateSelected;

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
                    widget.prevValue!.name ??
                        widget.hint ??
                        AppLocalizations.of(context)!.select(""),
                    textAlign: TextAlign.start,
                    style: widget.prevValue == null
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

  Future<void> _handleClickOnSelectDate() async {
    String current = '';
    ResultTypeModel? type = await showModalBottomSheet(
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
            ),
          ),
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
                            widget.prevValue!.name ??
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
                  ...widget.data
                      .map((e) => GestureDetector(
                    onTap: () => Navigator.pop(context, e),
                        child: Row(
                              children: [
                                Radio(
                                  fillColor:
                                      MaterialStateProperty.all(MyColors.primary),
                                  activeColor: MyColors.primary,
                                  value: e,
                                  groupValue: current,
                                  onChanged: (t) {
                                    Navigator.pop(context, t);
                                  },
                                ),
                                Text(
                                  e.name,
                                  style: Light300Style.normal.copyWith(
                                      color: MyColors.secondary.shade300),
                                ),
                              ],
                            ),
                      ))
                      .toList()
                ],
              ),
            ],
          ),
        );
      }),
    );
    if (type != null) {
      setState(() {
        widget.prevValue = type;
      });
      widget.onNewDateSelected(type);
    }
  }
}
