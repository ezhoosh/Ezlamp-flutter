import 'dart:io';

import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/main.dart';
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
import 'package:iconsax/iconsax.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupBloc>(context).add(GetGroupListEvent());
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MySpaces.s24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                title: al.changeLanguage,
                iconRight: SvgPicture.asset("assets/icons/arrow_right.svg"),
                onTapRight: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: MySpaces.s32,
              ),
              Text(
                al.selectYourLanguage,
                style: DemiBoldStyle.normal
                    .copyWith(color: MyColors.secondary.shade300),
              ),
              const SizedBox(
                height: MySpaces.s32,
              ),
              Container(
                decoration: BoxDecoration(
                    color: MyColors.black.shade600, borderRadius: MyRadius.sm),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ClickableContainer(
                      onTap: () {
                        MyApp.of(context)?.setLocale(const Locale('en', ''));
                      },
                      borderRadius: MyRadius.sm,
                      child: ClickableContainer(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  al.english,
                                  style: DemiBoldStyle.lg.copyWith(
                                      color: MyColors.secondary.shade300),
                                ),
                                const SizedBox(
                                  height: MySpaces.s8,
                                ),
                                Text(
                                  al.english,
                                  style: DemiBoldStyle.sm.copyWith(
                                      color: MyColors.secondary.shade300),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (Localizations.localeOf(context).toString() ==
                                'en')
                              const Icon(
                                Iconsax.tick_circle,
                                color: MyColors.info,
                                size: 30,
                              )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: MySpaces.s40,
                    ),
                    ClickableContainer(
                      borderRadius: MyRadius.sm,
                      onTap: () {
                        MyApp.of(context)?.setLocale(const Locale('fa', ''));
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Persian",
                                style: DemiBoldStyle.lg.copyWith(
                                    color: MyColors.secondary.shade300),
                              ),
                              const SizedBox(
                                height: MySpaces.s8,
                              ),
                              Text(
                                al.persian,
                                style: DemiBoldStyle.sm.copyWith(
                                    color: MyColors.secondary.shade300),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (Localizations.localeOf(context).toString() ==
                              'fa')
                            const Icon(
                              Iconsax.tick_circle,
                              color: MyColors.info,
                              size: 30,
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
