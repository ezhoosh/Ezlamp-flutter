import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
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
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
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
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: MySpaces.s32),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: MySpaces.s24,
                        right: MySpaces.s24,
                        bottom: MySpaces.s12),
                    decoration: BoxDecoration(
                        borderRadius: MyRadius.base,
                        color: MyColors.black.shade600),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return  EditGroupBottomSheet();
                                      });
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/edit.svg",
                                  width: 20,
                                  height: 20,
                                )),
                            const SizedBox(
                              width: MySpaces.s6,
                            ),
                            Text(
                              "lamp A",
                              style: DemiBoldStyle.lg
                                  .copyWith(color: MyColors.white),
                            ),
                            const Spacer(),
                            Icon(Icons.settings,
                                color: MyColors.secondary.shade200)
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 26),
                            child: Text(
                              "۴ لامپ",
                              style: DemiBoldStyle.sm
                                  .copyWith(color: MyColors.black.shade100),
                            ),
                          ),
                        ),
                        const Divider(
                          height: MySpaces.s24,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "روشن",
                                style: DemiBoldStyle.sm
                                    .copyWith(color: MyColors.black.shade100),
                              ),
                              CupertinoSwitch(
                                onChanged: (bool value) {},
                                value: true,
                                activeColor: MyColors.primary,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
