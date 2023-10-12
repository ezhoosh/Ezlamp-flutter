import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/command_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/more_group_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupCard extends StatelessWidget {
  GroupLampModel group;

  GroupCard(this.group, {super.key});

  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return ClickableContainer(
      margin: const EdgeInsets.only(
          right: MySpaces.s24, left: MySpaces.s24, bottom: MySpaces.s24),
      padding: const EdgeInsets.only(
        left: MySpaces.s24,
        right: MySpaces.s24,
        bottom: MySpaces.s12,
      ),
      // onTap: () {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (context) => LampPage(group.id)));
      // },
      borderRadius: MyRadius.base,
      color: MyColors.black.shade600,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      builder: (context) {
                        return MoreGroupBottomSheet(group.id);
                      },
                    );
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
                group.name,
                style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.settings,
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
                      isScrollControlled: true,
                      builder: (context) {
                        return CommandBottomSheet(groupId: group.id);
                      });
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 26),
              child: Text(
                al.lamp(group.lamps.length.toString()),
                style:
                    DemiBoldStyle.sm.copyWith(color: MyColors.black.shade100),
              ),
            ),
          ),
          const SizedBox(
            height: MySpaces.s12,
          ),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  onPress: () {
                    BlocProvider.of<CommandBloc>(context)
                        .add(SendCommandEvent(CommandParams(
                      w: 0,
                      y: 0,
                      r: 0,
                      g: 0,
                      b: 0,
                      c: 0,
                      pir: true,
                      type: 'apply',
                      gid: group.id,
                    )));
                  },
                  text: al.off,
                  right: const Icon(
                    Icons.power_settings_new_outlined,
                    color: MyColors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: MySpaces.s8,
              ),
              Expanded(
                child: SecondaryButton(
                  onPress: () {
                    BlocProvider.of<CommandBloc>(context)
                        .add(SendCommandEvent(CommandParams(
                      w: 100,
                      y: 50,
                      r: 0,
                      g: 0,
                      b: 0,
                      c: 0,
                      pir: true,
                      type: 'apply',
                      gid: group.id,
                    )));
                  },
                  text: al.on,
                  right: const Icon(
                    Icons.power_settings_new_outlined,
                    color: MyColors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
