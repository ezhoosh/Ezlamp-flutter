import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class RequestListTab extends StatelessWidget {
  const RequestListTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations al = AppLocalizations.of(context)!;
    return BlocBuilder<InvitationBloc, InvitationState>(
      // buildWhen: (prev, curr) {
      //   if (prev.getMyInvitationAssignmentListStatus is BaseSuccess &&
      //       curr.getMyInvitationAssignmentListStatus is BaseNoAction) {
      //     return false;
      //   }
      //   return true;
      // },
      builder: (context, state) {
        if (state.getMyInvitationAssignmentListStatus is BaseSuccess) {
          List<InvitationModel> items =
              (state.getMyInvitationAssignmentListStatus as BaseSuccess).entity;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ClickableContainer(
                margin: const EdgeInsets.only(
                  top: MySpaces.s24,
                ),
                padding: const EdgeInsets.all(MySpaces.s24),
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
                    Flexible(
                      child: Text(
                        items[index].phoneNumber,
                        style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: MySpaces.s4,
                    ),
                    const Spacer(),
                    PrimaryButton(
                      text: al.acceptRequest,
                      onPress: () {
                        BlocProvider.of<InvitationBloc>(context)
                            .add(AcceptInviteEvent(items[index].id));
                      },
                    ),
                    const SizedBox(
                      width: MySpaces.s4,
                    ),
                    PrimaryButton(
                      text: al.delete,
                      bg: MyColors.black.shade300,
                      onPress: () {
                        BlocProvider.of<InvitationBloc>(context)
                            .add(DeclineInviteEvent(items[index].id));
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: items.length,
          );
        } else if (state.getMyInvitationAssignmentListStatus is BaseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.getMyInvitationAssignmentListStatus is BaseError) {
          return const Center(
            child: Text("ERROR"),
          );
        }
        return const SizedBox();
      },
    );
  }
}
