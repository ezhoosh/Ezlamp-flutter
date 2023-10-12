import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomSheet extends StatelessWidget {
  String? title;
  Widget? child;

  CustomBottomSheet({super.key, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        )),
        padding: const EdgeInsets.symmetric(horizontal: MySpaces.s24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: MySpaces.s8,
          ),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: MyColors.secondary.shade800, borderRadius: MyRadius.lg),
          ),
          const SizedBox(
            height: MySpaces.s24,
          ),
          Stack(
            children: [
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
              Center(
                child: Text(
                  title ?? '',
                  style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
                ),
              )
            ],
          ),
          Divider(
            color: MyColors.secondary.shade800,
            height: MySpaces.s40,
          ),
          if (child != null) child!
        ]),
      ),
    );
  }
}
