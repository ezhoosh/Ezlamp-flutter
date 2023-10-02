import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/user_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/user_bloc/user_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/more_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/change_language_page.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/change_password_page.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/edit_profile_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/member_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
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
              title: al.profile,
            ),
            const SizedBox(
              height: MySpaces.s32,
            ),
            ...getProfileRow(),
            const SizedBox(
              height: MySpaces.s40,
            ),
            getRow(
              target: const MemberPage(),
              text: al.member,
              icon: const Icon(
                Iconsax.lock,
                color: MyColors.white,
                size: 30,
              ),
            ),
            getRow(
              target: const ChangePasswordPage(),
              text: al.changePassword,
              icon: const Icon(
                Iconsax.profile_2user,
                color: MyColors.white,
                size: 30,
              ),
            ),
            getRow(
              target: const ChangeLanguagePage(),
              text: al.changeLanguage,
              icon: const Icon(
                Iconsax.global,
                color: MyColors.white,
                size: 30,
              ),
            ),
            getRowExit()
          ],
        ),
      ),
    );
  }

  getRow({Widget? icon, String text = "", Widget? target}) {
    return ClickableContainer(
      margin: const EdgeInsets.only(
          right: MySpaces.s24, left: MySpaces.s24, bottom: MySpaces.s16),
      padding: const EdgeInsets.all(MySpaces.s24),
      onTap: () {
        if (target != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => target),
          );
        }
      },
      borderRadius: MyRadius.base,
      color: MyColors.black.shade600,
      child: Row(
        children: [
          if (icon != null) icon,
          const SizedBox(
            width: MySpaces.s12,
          ),
          Text(
            text,
            style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
          ),
          const Spacer(),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(180 / 360),
            child: SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              color: MyColors.white,
            ),
          )
        ],
      ),
    );
  }

  getRowExit() {
    return ClickableContainer(
      margin: const EdgeInsets.only(
          right: MySpaces.s24, left: MySpaces.s24, bottom: MySpaces.s16),
      padding: const EdgeInsets.all(MySpaces.s24),
      onTap: () {},
      borderRadius: MyRadius.base,
      color: MyColors.black.shade600,
      child: Row(
        children: [
          const Icon(
            Iconsax.logout,
            color: MyColors.error,
            size: 30,
          ),
          const SizedBox(
            width: MySpaces.s12,
          ),
          Text(
            al.logout,
            style: DemiBoldStyle.lg.copyWith(color: MyColors.error),
          ),
          const Spacer(),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(180 / 360),
            child: SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              color: MyColors.error,
            ),
          )
        ],
      ),
    );
  }

  getProfileRow() {
    return [
      Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: MyColors.black.shade500,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Iconsax.user,
          size: 40,
          color: MyColors.primary,
        ),
      ),
      const SizedBox(
        height: MySpaces.s12,
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<UserBloc, UserState>(
            buildWhen: (prev, curr) {
              if (prev.getUserStatus is BaseSuccess &&
                  curr.getUserStatus is BaseNoAction) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state.getUserStatus is BaseSuccess) {
                UserModel user = (state.getUserStatus as BaseSuccess).entity;
                return Text(
                  '${user.firstName} ${user.lastName}',
                  style: Light400Style.normal.copyWith(color: MyColors.white),
                );
              }
              return const SizedBox();
            },
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  barrierColor: MyColors.noColor,
                  builder: (context) => EditProfileBottomSheet());
            },
            icon: Icon(
              Iconsax.edit_2,
              color: MyColors.secondary.shade200,
              size: 20,
            ),
          )
        ],
      )
    ];
  }
}
