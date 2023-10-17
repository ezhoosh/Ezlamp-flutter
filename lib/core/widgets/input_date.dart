import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class InputDate extends StatelessWidget {
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
  final String? prevDate;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;
  final Function(String newDate) onNewDateSelected;

  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Column(
      children: [
        if (title != null)
          Padding(
            padding:
                const EdgeInsets.only(bottom: MySpaces.s12, right: MySpaces.s4),
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
        SizedBox(
          height: 54,
          child: ClickableContainer(
              onTap: () {
                if (isDisabled != null && isDisabled!) return;
                FocusManager.instance.primaryFocus?.unfocus();
                _handleClickOnSelectDate();
              },
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: (isDisabled != null && isDisabled!)
                  ? MyColors.primary
                  : MyColors.black.shade500,
              borderRadius: MyRadius.sm,
              border: Border.all(color: MyColors.black.shade500, width: 1),
              child: Row(children: [
                Expanded(
                  child: Text(
                    prevDate ??
                        hint ??
                        AppLocalizations.of(context)!.select(""),
                    textAlign:
                        prevDate == null ? TextAlign.start : TextAlign.end,
                    style: prevDate == null
                        ? Light300Style.sm
                            .copyWith(color: MyColors.secondary.shade300)
                        : Light300Style.sm
                            .copyWith(color: MyColors.secondary.shade500),
                  ),
                ),
                const SizedBox(width: MySpaces.s8),
                Icon(
                  isDate ? Iconsax.calendar : Iconsax.clock,
                  size: 24,
                  color: Colors.white,
                ),
              ])),
        )
      ],
    );
  }

  Future<void> _handleClickOnSelectDate() async {
    if (isDate) {
      var picked = await showModalBottomSheet(
        context: _buildContext,
        builder: (BuildContext context) {
          return Container();
        },
      );
    } else {
      showModalBottomSheet(
          context: _buildContext,
          isScrollControlled: true,
          barrierColor: MyColors.noColor,
          builder: (context) => BottomSheetSelectDate(
                title: AppLocalizations.of(context)!.selectDate,
                isDate: isDate,
                onSubmit: (value) => onNewDateSelected(_formatDate("-", value)),
              ));
    }
  }

  String _formatDate(String delimiter, DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return intl.DateFormat("yyyy${delimiter}MM${delimiter}dd").format(dateTime);
  }
}
