import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:easy_lamp/core/widgets/jalali_date_picker/jalali_table_calendar.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

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
    this.isEnabled = true,
  }) : super(key: key);

  final String? title;
  DateTime? prevDate;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;
  final bool isEnabled;
  final Function(DateTime newDate) onNewDateSelected;
  String currentDate = LocalizationService.isLocalPersian
      ? DateTime.now().toJalali().formatCompactDate()
      : intl.DateFormat('yyyy/MM/dd').format(DateTime.now());
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
              onTap: widget.isEnabled ? () {
                if (widget.isDisabled != null && widget.isDisabled!) return;
                _handleClickOnSelectDate();
              } : null,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: (widget.isDisabled != null && widget.isDisabled!)
                  ? MyColors.primary
                  : MyColors.black.shade500,
              borderRadius: MyRadius.sm,
              border: Border.all(color: MyColors.black.shade500, width: 1),
              child: Row(children: [
                Icon(
                  widget.isDate ? Iconsax.calendar_edit : Iconsax.clock,
                  size: 24,
                  color: MyColors.primary,
                ),
                const SizedBox(width: MySpaces.s8),
                Expanded(
                  child: Text(
                    LocalizationService.isLocalPersian
                        ? _formatDate(widget.prevDate).toString().toPersianDigit()
                        : _formatDate(widget.prevDate),
                    textAlign: TextAlign.end,
                    style: widget.prevDate == null
                        ? Light300Style.normal
                            .copyWith(color: MyColors.secondary.shade300)
                        : Light300Style.normal
                            .copyWith(color: MyColors.secondary.shade500),
                  ),
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
                  Expanded(child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: LinearDatePicker(
                          startDate: LocalizationService.isLocalPersian
                              ? DateTime.now()
                                  .subtract(const Duration(days: 3650))
                                  .toJalali()
                                  .formatCompactDate()
                              : intl.DateFormat('yyyy/MM/dd').format(DateTime.now()
                                  .subtract(const Duration(days: 3650))
                                  .toJalali()
                                  .toDateTime()),
                          endDate: LocalizationService.isLocalPersian
                              ? DateTime.now()
                                  .add(const Duration(days: 365))
                                  .toJalali()
                                  .formatCompactDate()
                              : intl.DateFormat('yyyy/MM/dd').format(DateTime.now()
                                  .add(const Duration(days: 365))
                                  .toJalali()
                                  .toDateTime()),
                          initialDate: LocalizationService.isLocalPersian
                              ? DateTime.now().toJalali().formatCompactDate()
                              : intl.DateFormat('yyyy/MM/dd').format(DateTime.now()),
                          addLeadingZero: true,
                        dateChangeListener: (String selectedDate) {
                          widget.currentDate = selectedDate;
                          },
                        showDay: true,
                        labelStyle:   TextStyle(
                          fontFamily: LocalizationService.isLocalPersian ? "sans" : null,
                          fontSize: 14.0,
                          color: MyColors.primary,
                        ),
                        selectedRowStyle:   TextStyle(
                          fontFamily: LocalizationService.isLocalPersian ? "sans" : null,
                          fontSize: 18.0,
                          color: MyColors.primary,
                        ),
                        unselectedRowStyle:   TextStyle(
                          fontFamily: LocalizationService.isLocalPersian ? "sans" : null,
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                        yearText: AppLocalizations.of(context)!.year,
                        monthText: AppLocalizations.of(context)!.month,
                        dayText: AppLocalizations.of(context)!.day,
                        showLabels: true,
                        columnWidth: 100,
                        showMonthName: true,
                        isJalaali: LocalizationService.isLocalPersian  // false -> Gregorian
                    ),
                  ),),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      // h: 60,
                      text: AppLocalizations.of(context)!.save,
                      onPress: () {
                        Navigator.pop(context);

                        setState(() {
                          widget.prevDate = LocalizationService.isLocalPersian
                              ? Jalali(
                              int.parse(widget.currentDate.split("/")[0]),
                              int.parse(widget.currentDate.split("/")[1]),
                              int.parse(widget.currentDate.split("/")[2]))
                              .toGregorian()
                              .toDateTime()
                              : DateTime.tryParse(widget.currentDate);
                        });
                        widget.onNewDateSelected(widget.prevDate!);

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
      if(LocalizationService.isLocalPersian){
        return dateTime.toPersianDate();
      }else{
        return intl.DateFormat('yyyy/MM/dd').parse(dateTime.toString()).toString();
      }

    } else {
      return intl.DateFormat.Hm().format(dateTime).toString();
    }
  }
}
