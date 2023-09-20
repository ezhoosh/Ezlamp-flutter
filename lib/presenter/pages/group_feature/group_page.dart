import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late AppLocalizations al;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(MySpaces.s16),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/arrow_right.svg"),
                  Expanded(
                    child: Text(
                      al.groupsList,
                      textAlign: TextAlign.center,
                      style: TitleStyle.t4.copyWith(
                        color: MyColors.white,
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/icons/add_circle.svg"),
                ],
              ),
              const SizedBox(
                height: MySpaces.s40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
