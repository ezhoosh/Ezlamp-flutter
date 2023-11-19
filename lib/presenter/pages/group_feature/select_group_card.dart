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
import 'package:iconsax/iconsax.dart';

class SelectGroupCard extends StatelessWidget {
  GroupModel group;
  bool select;
  final Function()? onTap;

  SelectGroupCard(this.group, {super.key, this.select = false, this.onTap});

  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return ClickableContainer(
      margin: const EdgeInsets.all(MySpaces.s12),
      padding: const EdgeInsets.all(
        MySpaces.s24,
      ),
      onTap: onTap,
      borderRadius: MyRadius.lg,
      color: MyColors.black.shade600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  group.name,
                  style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
                  maxLines: 1,
                ),
              ),
              if (select)
                const Icon(
                  Iconsax.tick_circle,
                  color: MyColors.success,
                  size: 20,
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColors.black.shade100,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: MySpaces.s6,
          ),
          Text(
            al.lamp(group.lamps.length.toString()),
            style: DemiBoldStyle.sm.copyWith(color: MyColors.black.shade100),
          ),
        ],
      ),
    );
  }
}
