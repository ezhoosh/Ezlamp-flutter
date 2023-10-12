import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/more_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_group_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:easy_lamp/presenter/pages/schedule_feature/schedule_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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
              iconLeft: const Icon(
                Icons.add,
                color: MyColors.primary,
                size: 30,
              ),
              onTapLeft: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddLampGroupPage()),
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: MySpaces.s32),
                itemBuilder: (context, index) {
                  return ClickableContainer(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ScheduleDetailPage()),
                      );
                    },
                    margin: const EdgeInsets.only(
                      left: MySpaces.s24,
                      right: MySpaces.s24,
                      bottom: MySpaces.s24,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    borderRadius: MyRadius.base,
                    color: MyColors.black.shade600,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/icons/clock.svg",
                                  width: 20,
                                  height: 20,
                                )),
                            const SizedBox(
                              width: MySpaces.s6,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " 9:31 AM ",
                                  style: DemiBoldStyle.lg
                                      .copyWith(color: MyColors.white),
                                ),
                                const SizedBox(
                                  height: MySpaces.s4,
                                ),
                                Text(
                                  "برای خارج شدن از خانه",
                                  style: DemiBoldStyle.sm
                                      .copyWith(color: MyColors.black.shade100),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                              value: true,
                              onChanged: (t) {},
                              activeColor: MyColors.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 100,
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
              "assets/images/cuate.png",
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
            )
          ],
        ),
      ),
    );
  }
}
