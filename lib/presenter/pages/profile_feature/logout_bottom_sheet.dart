import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogOutBottomSheet extends StatelessWidget {
  String name;

  LogOutBottomSheet(this.name, {super.key});

  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      )),
      padding: const EdgeInsets.symmetric(horizontal: MySpaces.s24),
      child: Wrap(
        children: [
          Column(
            children: [
              const SizedBox(
                height: MySpaces.s12,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: MyColors.secondary.shade800,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(
                height: MySpaces.s24,
              ),
              Text(
                al.logoutTitle(name),
                style: TitleStyle.t4.copyWith(color: MyColors.error.shade700),
              ),
              const SizedBox(
                height: MySpaces.s12,
              ),
              Text(
                al.logoutDesc,
                style: Light400Style.normal
                    .copyWith(color: MyColors.secondary.shade400),
              ),
              const SizedBox(
                height: MySpaces.s40,
              ),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onPress: () => Navigator.pop(context),
                      text: al.cancel,
                      bg: MyColors.black.shade300,
                    ),
                  ),
                  const SizedBox(
                    width: MySpaces.s12,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      onPress: () =>
                          BlocProvider.of<AuthBloc>(context).add(LogOutEvent()),
                      text: al.exit,
                      bg: MyColors.error.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: MySpaces.s24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
