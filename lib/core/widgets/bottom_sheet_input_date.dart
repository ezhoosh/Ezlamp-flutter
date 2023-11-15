import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetSelectDate extends StatelessWidget {
  const BottomSheetSelectDate(
      {Key? key,
      required this.title,
      this.initialDateTime,
      this.maxDateTime,
      this.minDateTime,
      this.isDate = false,
      this.onSubmit})
      : super(key: key);
  final bool isDate;
  final String title;
  final DateTime? minDateTime;
  final DateTime? initialDateTime;
  final DateTime? maxDateTime;
  final Function(dynamic)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BottomPicker.time(
        dismissable: true,
        backgroundColor: MyColors.black.shade600,
        initialDateTime: initialDateTime,
        height: 300,
        buttonText: "          ${AppLocalizations.of(context)!.save}          ",
        buttonSingleColor: MyColors.primary,
        onSubmit: onSubmit,
        displayButtonIcon: false,
        buttonTextStyle: DemiBoldStyle.normal.copyWith(color: MyColors.white),
        maxDateTime: maxDateTime,
        minDateTime: minDateTime,
        pickerTextStyle: Light400Style.xl.copyWith(color: MyColors.white),
        titleStyle: DemiBoldStyle.sm,
        title: 'ساعت را انتخاب کنید',
        closeIconColor: Colors.white,
      ),
    );
  }
}
