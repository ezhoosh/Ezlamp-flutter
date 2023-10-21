import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/data/isar_model/isar_command.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;

class InputGroupSelect extends StatelessWidget {
  InputGroupSelect({
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
    showModalBottomSheet(
      context: _buildContext,
      isScrollControlled: true,
      barrierColor: MyColors.noColor,
      builder: (context) => CustomBottomSheet(
        title: AppLocalizations.of(context)!.selectGroup,
        child: StatefulBuilder(builder: (context, setState) {
          return Column(
            children: [
              BlocBuilder<GroupBloc, GroupState>(
                builder: (context, state) {
                  if (state.getGroupListStatus is BaseSuccess) {
                    List<GroupLampModel> groups =
                        (state.getGroupListStatus as BaseSuccess).entity;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        GroupLampModel group = groups[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (t) {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  fillColor: MaterialStateProperty.all(
                                      MyColors.primary),
                                  checkColor: MyColors.white,
                                ),
                                Text(group.name),
                                const Spacer(),
                                Text(
                                  AppLocalizations.of(context)!
                                      .lamp(group.lamps.length.toString()),
                                  style: DemiBoldStyle.xs.copyWith(
                                      color: MyColors.secondary.shade600),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Opacity(
                                  opacity: group.lamps.isNotEmpty ? 1 : 0.3,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        group.open = !group.open;
                                      });
                                    },
                                    icon: Icon(
                                      group.open
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down_outlined,
                                      color: MyColors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if (group.open)
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: group.lamps.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (t) {},
                                          fillColor: MaterialStateProperty.all(
                                              MyColors.primary),
                                          checkColor: MyColors.white,
                                        ),
                                        Text(group.lamps[i].name),
                                      ]),
                                    );
                                  }),
                            if (index < groups.length - 1)
                              const Divider(
                                height: 40,
                              ),
                          ],
                        );
                      },
                      itemCount: groups.length,
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: AppLocalizations.of(context)!.save,
                ),
              ),
              const SizedBox(
                height: MySpaces.s16,
              )
            ],
          );
        }),
      ),
    );
  }

  String _formatDate(String delimiter, DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return intl.DateFormat("yyyy${delimiter}MM${delimiter}dd").format(dateTime);
  }
}
