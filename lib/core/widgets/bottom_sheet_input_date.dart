import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_picker/bottom_picker.dart';
import 'package:easy_lamp/core/widgets/bottom_picker/resources/arrays.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/navigation_service.dart';
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
    return BottomPicker.time(
        dismissable: true,
        backgroundColor: MyColors.black.shade600,
        initialDateTime: initialDateTime,
        height: 300,
        buttonText: AppLocalizations.of(context)!.save,
        buttonSingleColor: MyColors.primary,
        onSubmit: onSubmit,
        displayButtonIcon: false,
        buttonTextStyle: DemiBoldStyle.normal.copyWith(color: MyColors.white, fontFamily: 'sans'),
        maxDateTime: maxDateTime,
        minDateTime: minDateTime,
        pickerTextStyle: Light400Style.xl.copyWith(color: MyColors.white, fontFamily: LocalizationService.isLocalPersian ? "sans" : null),
        titleStyle: DemiBoldStyle.normal.copyWith(color: MyColors.white, fontFamily: LocalizationService.isLocalPersian ? "sans" : null),
        title: AppLocalizations.of(NavigationService.navigatorKey.currentState!.context)!.selectHour,
        closeIconColor: Colors.white,
        use24hFormat: true,
        // buttonPadding: 5,
        // buttonWidth: 10,
        closeIconSize: 20,
        titlePadding: EdgeInsets.zero,
        layoutOrientation: LocalizationService.isLocalPersian ? LayoutOrientation.rtl : LayoutOrientation.ltr,
      );
  }
}
