import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/presenter/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class MemberTab extends StatelessWidget {
  const MemberTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    return BlocBuilder<InvitationBloc, InvitationState>(
      // buildWhen: (prev, curr) {
      //   if (prev.getInvitationListStatus is BaseSuccess &&
      //       curr.getInvitationListStatus is BaseNoAction) {
      //     return false;
      //   }
      //   return true;
      // },
      builder: (context, state) {
        if (state.getInvitationListStatus is BaseSuccess) {
          List<InvitationModel> items =
              (state.getInvitationListStatus as BaseSuccess).entity;
          return ListView.builder(
            itemBuilder: (context, index) {
              InvitationModel item = items[index];
              return ClickableContainer(
                margin: const EdgeInsets.only(
                  top: MySpaces.s24,
                ),
                padding: const EdgeInsets.all(MySpaces.s24),
                onTap: () {},
                borderRadius: MyRadius.base,
                color: MyColors.black.shade600,
                child: Column(
                  children: [
                    Row(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.message,
                                style: DemiBoldStyle.lg
                                    .copyWith(color: MyColors.white),
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: MySpaces.s4,
                              ),
                              Text(
                                item.phoneNumber,
                                style: DemiBoldStyle.sm
                                    .copyWith(color: MyColors.black.shade100),
                              ),
                            ],
                          ),
                        ),
                        ClickableContainer(
                          onTap: () {
                            BlocProvider.of<InvitationBloc>(context)
                                .add(DeleteInvitationEvent(items[index].id));
                          },
                          color: MyColors.black.shade400,
                          borderRadius: MyRadius.xs,
                          padding: const EdgeInsets.all(MySpaces.s8),
                          child: const Icon(
                            Iconsax.trash,
                            color: MyColors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: items.length,
          );
        } else if (state.getInvitationListStatus is BaseLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.primary,
            ),
          );
        } else if (state.getInvitationListStatus is BaseError) {
          return const Center(
            child: Text("ERROR"),
          );
        }
        return SizedBox();
      },
    );
  }
}
