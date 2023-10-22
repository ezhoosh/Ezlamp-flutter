import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/input_date.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/more_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_group_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ScheduleDetailPage extends StatefulWidget {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              title: al.planning,
              iconRight: SvgPicture.asset(
                "assets/icons/arrow_right.svg",
                color: MyColors.primary,
              ),
              onTapRight: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: MySpaces.s40,
                  horizontal: MySpaces.s24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BorderTextField(
                      title: al.title,
                      optional: false,
                    ),
                    const SizedBox(
                      height: MySpaces.s16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InputDate(
                            optional: false,
                            title: al.startDate,
                            onNewDateSelected: (DateTime newDate) {},
                          ),
                        ),
                        const SizedBox(
                          width: MySpaces.s12,
                        ),
                        Expanded(
                          child: InputDate(
                            title: al.finishDate,
                            optional: false,
                            onNewDateSelected: (DateTime newDate) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MySpaces.s16,
                    ),
                    Text(
                      al.again,
                      style: DemiBoldStyle.normal
                          .copyWith(color: MyColors.secondary.shade300),
                    ),
                    const SizedBox(
                      height: MySpaces.s16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getCircleDate('ش', true),
                        getCircleDate('ی', true),
                        getCircleDate('د', true),
                        getCircleDate('س', true),
                        getCircleDate('چ', true),
                        getCircleDate('پ', true),
                        getCircleDate('ج', true),
                      ],
                    ),
                    const Divider(
                      height: MySpaces.s40,
                    ),
                    Row(
                      children: [
                        Text(
                          al.groupsList,
                          style: DemiBoldStyle.normal
                              .copyWith(color: MyColors.secondary.shade300),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.add,
                          color: MyColors.primary,
                          size: 20,
                        ),
                        Text(
                          al.addGroup,
                          style: DemiBoldStyle.sm.copyWith(
                            color: MyColors.primary,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: MySpaces.s16,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ClickableContainer(
                          padding: const EdgeInsets.only(
                            left: MySpaces.s24,
                            right: MySpaces.s24,
                            top: MySpaces.s12,
                            bottom: MySpaces.s12,
                          ),
                          onTap: () {},
                          borderRadius: MyRadius.base,
                          color: MyColors.black.shade600,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "group.name",
                                    style: DemiBoldStyle.lg
                                        .copyWith(color: MyColors.white),
                                  ),
                                  Text(
                                    al.lamp("A1"),
                                    style: DemiBoldStyle.sm.copyWith(
                                        color: MyColors.black.shade100),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: MyColors.secondary.shade200,
                                  size: 30,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      )),
                                      context: context,
                                      builder: (context) {
                                        return EditInternetBoxBottomSheet();
                                      });
                                },
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: MySpaces.s16,
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getEmptyPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MySpaces.s40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/cuate_lamp.png",
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            Text(
              AppLocalizations.of(context)!.addYourGroup,
              style: Light300Style.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                text: 'افزودن گروه',
                right: const Icon(
                  Icons.add,
                  color: MyColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCircleDate(String t, bool enable) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 40.0,
      ),
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: enable ? MyColors.primary : MyColors.black.shade600,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          t,
          style: DemiBoldStyle.normal.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
