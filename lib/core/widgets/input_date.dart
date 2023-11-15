import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:easy_lamp/core/widgets/jalali_date_picker/jalali_table_calendar.dart';

class InputDate extends StatefulWidget {
  InputDate({
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
  DateTime? prevDate;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;
  final Function(DateTime newDate) onNewDateSelected;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
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
                    _formatDate(widget.prevDate),
                    textAlign: TextAlign.start,
                    style: widget.prevDate == null
                        ? Light300Style.sm
                            .copyWith(color: MyColors.secondary.shade300)
                        : Light300Style.sm
                            .copyWith(color: MyColors.secondary.shade500),
                  ),
                ),
                const SizedBox(width: MySpaces.s8),
                Icon(
                  widget.isDate ? Iconsax.calendar : Iconsax.clock,
                  size: 24,
                  color: Colors.white,
                ),
              ])),
        )
      ],
    );
  }

  void _handleClickOnSelectDate() async {
    if (widget.isDate) {
      await showModalBottomSheet(
        context: _buildContext,
        builder: (BuildContext context) {
          return CustomBottomSheet(
            title: AppLocalizations.of(context)!.selectDate,
            child: Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: JalaliTableCalendar(
                        context: context,
                        events: {},
                        onDaySelected: (value) {
                          setState(() {
                            widget.prevDate = value;
                          });
                          widget.onNewDateSelected(value);
                        }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      h: 60,
                      text: AppLocalizations.of(context)!.save,
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: MySpaces.s16,
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
          context: _buildContext,
          isScrollControlled: true,
          barrierColor: MyColors.noColor,
          builder: (context) => BottomSheetSelectDate(
                title: AppLocalizations.of(context)!.selectDate,
                isDate: widget.isDate,
                onSubmit: (value) {
                  setState(() {
                    widget.prevDate = value;
                  });
                  widget.onNewDateSelected(value);
                },
              ));
    }
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return widget.hint ?? AppLocalizations.of(context)!.select("");
    }
    if (widget.isDate) {
      Jalali j = Jalali.fromDateTime(dateTime);
      return "${j.year}-${j.month}-${j.day}";
    } else {
      return '${dateTime.hour}:${dateTime.minute}';
    }
  }
}
