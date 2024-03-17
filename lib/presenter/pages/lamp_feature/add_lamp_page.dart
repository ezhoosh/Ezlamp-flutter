import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/border_text_field.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/internet_box_bloc/internet_box_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';

class AddLampPage extends StatefulWidget {
  int? groupId;
  String uuid;

  AddLampPage(this.uuid, this.groupId, {super.key});

  @override
  State<AddLampPage> createState() => _AddLampPageState();
}

class _AddLampPageState extends State<AddLampPage> {
  late AppLocalizations al;
  late TextEditingController _controllerName;
  late TextEditingController _controllerDesc;
  int? internetBoxId;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerDesc = TextEditingController();
    BlocProvider.of<InternetBoxBloc>(context).add(GetInternetBoxListEvent());
  }

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return BlocListener<LampBloc, LampState>(
      listenWhen: (prev, curr) {
        if (prev.updateLampOwnerStatus is BaseSuccess &&
            curr.updateLampOwnerStatus is BaseNoAction) {
          return false;
        }
        return true;
      },
      listener: (context, state) {
        if (state.updateLampOwnerStatus is BaseSuccess) {
          EasyLoading.showSuccess("SUCCESS");
        } else if (state.updateLampOwnerStatus is BaseLoading) {
          EasyLoading.show();
        } else if (state.updateLampOwnerStatus is BaseError) {
          ErrorHelper.getBaseError(state.updateLampOwnerStatus, context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(MySpaces.s24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(
                    title: al.addLamps,
                  ),
                  const SizedBox(
                    height: MySpaces.s12,
                  ),
                  BorderTextField(
                    title: al.name,
                    controller: _controllerName,
                    optional: false,
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: MySpaces.s12, right: MySpaces.s4),
                    child: Row(
                      children: [
                        Text(
                          al.select(al.internetLamp) ?? '',
                          style: Light300Style.sm
                              .copyWith(color: MyColors.secondary.shade300),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<InternetBoxBloc, InternetBoxState>(
                    buildWhen: (prev, curr) {
                      if (prev.getInternetBoxListStatus is BaseSuccess &&
                          curr.getInternetBoxListStatus is BaseNoAction) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state.getInternetBoxListStatus is BaseSuccess) {
                        List<InternetBoxModel> items =
                            (state.getInternetBoxListStatus as BaseSuccess)
                                .entity;
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyColors.black.shade500,
                            borderRadius: MyRadius.sm,
                          ),
                          padding: const EdgeInsets.all(
                            MySpaces.s24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    al.select(''),
                                    style: Light300Style.normal.copyWith(
                                        color: MyColors.secondary.shade500),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_down_sharp),
                                ],
                              ),
                              const Divider(
                                height: MySpaces.s40,
                              ),
                              ...items
                                  .map((e) => Row(
                                        children: [
                                          Radio(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    MyColors.primary),
                                            activeColor: MyColors.primary,
                                            value: e.id,
                                            groupValue: internetBoxId ?? 0,
                                            onChanged: (t) {
                                              setState(() {
                                                internetBoxId = e.id;
                                              });
                                            },
                                          ),
                                          Text(
                                            e.name,
                                            style: Light300Style.normal
                                                .copyWith(
                                                    color: MyColors
                                                        .secondary.shade500),
                                          ),
                                        ],
                                      ))
                                  .toList()
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                  BorderTextField(
                    title: al.desc,
                    maxLines: 6,
                    hintText: al.defaultText,
                    controller: _controllerDesc,
                    optional: false,
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      onPress: () {
                        BlocProvider.of<LampBloc>(context).add(
                          UpdateLampOwnerEvent(
                            UpdateLampOwnerParams(
                                widget.groupId ?? 0,
                                _controllerName.text,
                                _controllerDesc.text,
                                widget.uuid,
                                internetBox: internetBoxId),
                          ),
                        );
                      },
                      text: al.save,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
