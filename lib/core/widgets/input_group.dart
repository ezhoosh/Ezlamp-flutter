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
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;

class InputGroupSelect extends StatefulWidget {
  final String? title;
  List<LampModel>? prevValue;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;

  final Function(List<LampModel> newValue) onNewDateSelected;

  InputGroupSelect({
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

  @override
  State<InputGroupSelect> createState() => _InputGroupSelectState();
}

class _InputGroupSelectState extends State<InputGroupSelect> {
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
                    (widget.prevValue == null
                            ? widget.hint
                            : AppLocalizations.of(context)!
                                .lamp(widget.prevValue!.length.toString())) ??
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
    List<LampModel> select = await showModalBottomSheet(
      context: _buildContext,
      isScrollControlled: true,
      barrierColor: MyColors.noColor,
      builder: (context) {
        List<LampModel> lamps = [];
        return CustomBottomSheet(
          title: AppLocalizations.of(context)!.selectGroup,
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              children: [
                BlocBuilder<GroupBloc, GroupState>(
                  builder: (context, state) {
                    if (state.getGroupListStatus is BaseSuccess) {
                      List<GroupModel> groups =
                          (state.getGroupListStatus as BaseSuccess).entity;
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          GroupModel group = groups[index];
                          bool groupSelect = false;
                          for (var element in group.lamps) {
                            for (var element2 in lamps) {
                              if (element == element2) {
                                groupSelect = true;
                              }
                            }
                          }
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: groupSelect,
                                    onChanged: (t) {
                                      for (var element in group.lamps) {
                                        if (t!) {
                                          if (!lamps.contains(element)) {
                                            lamps.add(element);
                                          }
                                        } else {
                                          if (lamps.contains(element)) {
                                            lamps.remove(element);
                                          }
                                        }
                                      }
                                      setState(() {});
                                    },
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
                                            : Icons
                                                .keyboard_arrow_down_outlined,
                                        color: MyColors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              if (group.open)
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: group.lamps.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      LampModel lamp = group.lamps[i];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(children: [
                                          Checkbox(
                                            value: lamps.contains(lamp),
                                            onChanged: (t) {
                                              if (t!) {
                                                lamps.add(lamp);
                                              } else {
                                                lamps.remove(lamp);
                                              }
                                              setState(() {});
                                            },
                                            fillColor:
                                                MaterialStateProperty.all(
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
                const SizedBox(
                  height: MySpaces.s24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    text: AppLocalizations.of(context)!.save,
                    onPress: () {
                      Navigator.pop(context, lamps);
                    },
                  ),
                ),
                const SizedBox(
                  height: MySpaces.s16,
                )
              ],
            );
          }),
        );
      },
    );
    widget.prevValue = select;
    widget.onNewDateSelected(select);
    setState(() {});
  }
}
