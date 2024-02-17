import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/custom_bottom_sheet.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/internet_box_bloc/internet_box_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';

class AddInternetBoxBottomSheet extends StatefulWidget {
  String uuid;
  int? groupId;

  AddInternetBoxBottomSheet(this.uuid, {super.key, this.groupId}) {}

  @override
  State<AddInternetBoxBottomSheet> createState() =>
      _AddInternetBoxBottomSheetState();
}

class _AddInternetBoxBottomSheetState extends State<AddInternetBoxBottomSheet> {
  late AppLocalizations al;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return CustomBottomSheet(
      title: AppLocalizations.of(context)!.addInternetLamp,
      child: Column(
        children: [
          BorderTextField(
            hintText: al.title,
            controller: _controllerName,
          ),
          const SizedBox(
            height: MySpaces.s12,
          ),
          BorderTextField(
            hintText: al.desc,
            controller: _controllerDesc,
            maxLines: 7,
          ),
          const SizedBox(
            height: MySpaces.s12,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (widget.uuid
                    .startsWith('internetbox/update-internetbox-owner/')) {
                  BlocProvider.of<InternetBoxBloc>(context).add(
                    UpdateInternetBoxOwnerEvent(
                      UpdateGroupOwnerParams(
                        widget.uuid,
                        _controllerName.text,
                        _controllerDesc.text,
                      ),
                    ),
                  );
                } else {
                  EasyLoading.showToast(al.notValidBarcode);
                }
                // else {
                // BlocProvider.of<LampBloc>(context).add(
                //   UpdateLampOwnerEvent(
                //     UpdateLampOwnerParams(
                //       widget.groupId!,
                //       _controllerName.text,
                //       _controllerDesc.text,
                //       widget.uuid,
                //     ),
                //   ),
                // );
                // }
              },
              child: Text(
                al.save,
                style: DemiBoldStyle.normal.copyWith(color: MyColors.white),
              ),
            ),
          ),
          const SizedBox(
            height: MySpaces.s24,
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
