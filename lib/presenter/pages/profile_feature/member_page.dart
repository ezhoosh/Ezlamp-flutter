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
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/member_tab.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/request_list_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  late AppLocalizations al;
  int _currentTab = 0;

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
          padding: const EdgeInsets.symmetric(horizontal: MySpaces.s24),
          child: Column(
            children: [
              TopBar(
                title: al.addMember,
                iconRight: SvgPicture.asset("assets/icons/arrow_right.svg"),
                onTapRight: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: MySpaces.s32,
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.black.shade600,
                  borderRadius: MyRadius.sm,
                ),
                padding: const EdgeInsets.all(MySpaces.s4),
                child: Row(
                  children: [
                    getTab(al.myMember, 0),
                    getTab(al.requestList, 1),
                  ],
                ),
              ),
              Expanded(
                  child: _currentTab == 0
                      ? const MemberTab()
                      : const RequestListTab())
            ],
          ),
        ),
      ),
    );
  }

  getTab(String tabImportantDates, int i) {
    bool c = i == _currentTab;
    return Expanded(
        child: ClickableContainer(
      onTap: () {
        setState(() {
          _currentTab = i;
        });
      },
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: c ? MyColors.black.shade300 : MyColors.noColor,
      borderRadius: MyRadius.sm,
      child: Text(
        tabImportantDates,
        style: DemiBoldStyle.sm.copyWith(color: MyColors.white),
        textAlign: TextAlign.center,
      ),
    ));
  }
}
