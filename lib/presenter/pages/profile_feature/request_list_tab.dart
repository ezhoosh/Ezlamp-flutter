import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/presenter/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/delete_request_bottom_sheet.dart';
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
import 'package:persian_number_utility/persian_number_utility.dart';

class RequestListTab extends StatefulWidget {
  const RequestListTab({super.key});

  @override
  State<RequestListTab> createState() => _RequestListTabState();
}

class _RequestListTabState extends State<RequestListTab> {
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
              InvitationModel item = items[index];
              return ClickableContainer(
                margin: const EdgeInsets.only(
                  top: MySpaces.s24,
                ),
                padding: const EdgeInsets.only(
                  right: MySpaces.s24,
                  top: MySpaces.s24,
                  bottom: MySpaces.s24,
                ),
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
                                items[index].assignee == null
                                    ? AppLocalizations.of(context)!.no_name
                                    : "${item.assignee!.firstName} ${item.assignee!.lastName}",
                                style: DemiBoldStyle.lg
                                    .copyWith(color: MyColors.white),
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: MySpaces.s4,
                              ),
                              Text(
                                LocalizationService.isLocalPersian
                                    ? item.assignee!.phoneNumber.toPersianDigit()
                                    : item.assignee!.phoneNumber,
                                style: DemiBoldStyle.lg
                                    .copyWith(color: MyColors.black.shade100),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: MySpaces.s4,
                        ),
                        IconButton(
                          icon: Icon(item.isOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down_rounded),
                          onPressed: () {
                            setState(() {
                              item.isOpen = !item.isOpen;
                            });
                          },
                        )
                      ],
                    ),
                    if (item.isOpen)
                      Padding(
                        padding: const EdgeInsets.only(left: MySpaces.s24),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: MySpaces.s24,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: item.lamps?.length,
                                itemBuilder: (context, index) {
                                  Lamp lamp = item.lamps![index];
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lamp.name,
                                          style: Light400Style.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          lamp.groupLamp.toString(),
                                          style: Light400Style.normal,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: MySpaces.s24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    text: al.acceptRequest,
                                    onPress: () {
                                      BlocProvider.of<InvitationBloc>(context)
                                          .add(AcceptInviteEvent(
                                              items[index].id));
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: PrimaryButton(
                                    text: al.delete,
                                    bg: MyColors.black.shade300,
                                    onPress: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24),
                                                topRight: Radius.circular(24),
                                              )),
                                          context: context,
                                          builder: (context) {
                                            return DeleteRequestBottomSheet(items[index].id);
                                          });

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              );
            },
            itemCount: items.length,
          );
        } else if (state.getMyInvitationAssignmentListStatus is BaseLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.primary,
            ),
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
