import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/detail_lamp_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LampCard extends StatelessWidget {
  bool isSelect;
  LampModel lamp;
  bool selected;
  int groupId;
  ValueChanged<bool?>? onCheckSelect;

  LampCard(
      this.lamp, this.isSelect, this.selected, this.onCheckSelect, this.groupId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ClickableContainer(
      onTap: isSelect
          ? null
          : () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailLampPage([lamp], groupId),
                ),
              );
            },
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(
          left: MySpaces.s24, right: MySpaces.s24, bottom: MySpaces.s16),
      borderRadius: MyRadius.base,
      color: MyColors.black.shade600,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/lamp_on.svg",
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: MySpaces.s6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lamp.name,
                  style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
                ),
                Text(
                  lamp.description,
                  style:
                      DemiBoldStyle.sm.copyWith(color: MyColors.black.shade100),
                ),
              ],
            ),
          ),
          if (isSelect)
            Checkbox(
              value: selected,
              onChanged: onCheckSelect,
              fillColor: MaterialStateProperty.all(MyColors.primary),
              checkColor: MyColors.white,
            )
          else
            ArrowList()
        ],
      ),
    );
  }
}
