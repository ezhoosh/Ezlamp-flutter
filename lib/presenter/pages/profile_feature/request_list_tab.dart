import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class RequestListTab extends StatelessWidget {
  const RequestListTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ClickableContainer(
          margin: const EdgeInsets.only(
            top: MySpaces.s24,
          ),
          padding: const EdgeInsets.all(MySpaces.s24),
          onTap: () {},
          borderRadius: MyRadius.base,
          color: MyColors.black.shade600,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: MyColors.black.shade500,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.user,
                  size: 20,
                  color: MyColors.primary,
                ),
              ),
              const SizedBox(
                width: MySpaces.s12,
              ),
              Text(
                "فرناز ",
                style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
              ),
              const SizedBox(
                height: MySpaces.s4,
              ),
              const Spacer(),
              PrimaryButton(
                text: al.acceptRequest,
              ),
              const SizedBox(
                width: MySpaces.s4,
              ),
              PrimaryButton(
                text: al.delete,
                bg: MyColors.black.shade300,
              ),
            ],
          ),
        );
      },
      itemCount: 10,
    );
  }
}