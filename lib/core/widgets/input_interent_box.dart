import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/bottom_sheet_input_date.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/data/isar_model/isar_command.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/internet_box_bloc/internet_box_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;

class InputInternetBoxSelect extends StatefulWidget {
  final String? title;
  List<InternetBoxModel>? prevValue;
  final Widget? description;
  final bool? isDisabled;
  final String? hint;
  final bool optional;
  final bool isDate;

  final Function(List<InternetBoxModel> newValue) onNewDateSelected;

  InputInternetBoxSelect({
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
  State<InputInternetBoxSelect> createState() => _InputInternetBoxSelectState();
}

class _InputInternetBoxSelectState extends State<InputInternetBoxSelect> {
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
    List<InternetBoxModel> select = await showModalBottomSheet(
      context: _buildContext,
      isScrollControlled: true,
      barrierColor: MyColors.noColor,
      builder: (context) {
        List<InternetBoxModel> internetBox = [];
        BlocProvider.of<InternetBoxBloc>(context).add(GetInternetBoxListEvent());
        return CustomBottomSheet(
          title: AppLocalizations.of(context)!.selectGroup,
          child: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<InternetBoxBloc, InternetBoxState>(
                    builder: (context, state) {
                      if (state.getInternetBoxListStatus is BaseSuccess) {
                        List<InternetBoxModel> internetBoxes =
                            (state.getInternetBoxListStatus as BaseSuccess).entity;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // GroupModel group = groups[index];
                            bool groupSelect = false;
                              for (var element2 in internetBox) {
                                if (internetBoxes[index] == element2) {
                                  groupSelect = true;
                                }
                            }
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: groupSelect,
                                      onChanged: (t) {
                                          if(t!){
                                            if(!internetBox.contains(internetBoxes[index])){
                                              internetBox.add(internetBoxes[index]);
                                            }
                                          }else{
                                            if(internetBox.contains(internetBoxes[index])){
                                              internetBox.remove(internetBoxes[index]);
                                            }
                                          }
                                        setState(() {});
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                      checkColor: MyColors.white,
                                      activeColor: MyColors.primary,
                                    ),
                                    Text(internetBoxes[index].name.toString(), style: Light300Style.normal.copyWith(
                                      color: MyColors.secondary.shade500
                                    )),
                                  ],
                                )
                              ],
                            );
                          },
                          itemCount: internetBoxes.length,
                        );
                      }else if (state.getInternetBoxListStatus is BaseError) {
                        return Center(
                          child: Text(
                            (state.getInternetBoxListStatus as BaseError).error ?? "Error",
                            style: Light300Style.sm
                                .copyWith(color: MyColors.error),
                          ),
                        );
                      }else if(state.getInternetBoxListStatus is BaseLoading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const SizedBox.shrink();
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
                        Navigator.pop(context, internetBox);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: MySpaces.s16,
                  )
                ],
              ),
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
