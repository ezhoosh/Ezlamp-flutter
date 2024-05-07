import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/core/widgets/hue_picker/hue_picker.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/edit_lamp_name_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class MoreLampBottomSheet extends StatelessWidget {
  int lampId;

  MoreLampBottomSheet(this.lampId, {super.key});

  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return BlocListener<LampBloc, LampState>(
      listenWhen: (prev, curr) {
        if ((prev.deleteLampStatus is BaseSuccess &&
            curr.deleteLampStatus is BaseNoAction)) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.deleteLampStatus is BaseSuccess) {
          EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
        } else if (state.deleteLampStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.deleteLampStatus is BaseError) {
          ErrorHelper.getBaseError(state.deleteLampStatus, context);
        }
      },
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: MyColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: MyRadius.sm,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            )),
                            context: context,
                            builder: (context) {
                              return EditLampNameBottomSheet(lampId);
                            });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icons/edit_line.svg'),
                          const SizedBox(
                            width: MySpaces.s4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.editLampName,
                            style: DemiBoldStyle.normal
                                .copyWith(color: MyColors.white),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: MyColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: MyRadius.sm,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<LampBloc>(context)
                            .add(DeleteLampEvent(lampId));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icons/trash.svg'),
                          const SizedBox(
                            width: MySpaces.s4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.beDelete,
                            style: DemiBoldStyle.normal
                                .copyWith(color: MyColors.error),
                          ),
                        ],
                      ),
                    )),
                const Divider(),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: MyColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: MyRadius.sm,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.cancel,
                            style: DemiBoldStyle.normal
                                .copyWith(color: MyColors.white),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getButton(String informationData, String icon) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.black.shade400, borderRadius: MyRadius.sm),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            width: MySpaces.s8,
          ),
          Expanded(
              child: Text(informationData,
                  style: DemiBoldStyle.lg.copyWith(
                    color: MyColors.white,
                  )))
        ],
      ),
    ));
  }
}
