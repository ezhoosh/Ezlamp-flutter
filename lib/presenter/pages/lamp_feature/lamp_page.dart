import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_back.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/empty_page.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_group_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/detail_lamp_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';

class LampPage extends StatefulWidget {
  int groupId;

  LampPage(this.groupId, {Key? key}) : super(key: key);

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {
  bool isSelect = false;
  List<LampModel> selectedLamps = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LampBloc>(context)
        .add(GetLampListEvent(GetLampListParams(groupId: widget.groupId)));
  }

  late AppLocalizations al;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TopBar(
                    title: al.lampList,
                    onTapRight: () {
                      Navigator.pop(context);
                    },
                    iconRight: const ArrowBack(),
                    iconLeft: isEmpty
                        ? null
                        : Container(
                            decoration: BoxDecoration(
                                color: MyColors.black.shade500,
                                borderRadius: MyRadius.xs),
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              isSelect ? al.unselectButton : al.selectButton,
                              style: Light400Style.sm
                                  .copyWith(color: MyColors.primary),
                            ),
                          ),
                    onTapLeft: () {
                      setState(() {
                        isSelect = !isSelect;
                      });
                    },
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                  BlocConsumer<LampBloc, LampState>(
                    // buildWhen: (prev, curr) {
                    //   if (prev.getLampListStatus is BaseSuccess &&
                    //       curr.getLampListStatus is BaseNoAction) {
                    //     return false;
                    //   }
                    //   return true;
                    // },
                    builder: (context, state) {
                      if (state.getLampListStatus is BaseSuccess) {
                        List<LampModel> lamps =
                            (state.getLampListStatus as BaseSuccess).entity;
                        if (lamps.isEmpty) {
                          return Expanded(
                            child: EmptyPage(
                              al.addYourLamp,
                              onTab: _addClick,
                              btnText: al.addLamps,
                            ),
                          );
                        }
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.only(top: MySpaces.s32),
                                  itemBuilder: (context, index) {
                                    LampModel lamp = lamps[index];
                                    return LampCard(lamp, isSelect,
                                        selectedLamps.contains(lamp), (t) {
                                      if (t as bool) {
                                        setState(() {
                                          selectedLamps.add(lamp);
                                        });
                                      } else {
                                        setState(() {
                                          selectedLamps.remove(lamp);
                                        });
                                      }
                                    }, widget.groupId);
                                  },
                                  itemCount: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: MySpaces.s24),
                                  width: double.infinity,
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                    bool isBlue = state.connectionType ==
                                        ConnectionType.Bluetooth;
                                    return Opacity(
                                        opacity: isBlue ? 0.5 : 1,
                                        child: PrimaryButton(
                                          text: al.addLamps,
                                          onPress:
                                              isBlue ? _addClickBlue : _addClick,
                                        ));
                                  }),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (state.getLampListStatus is BaseLoading) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primary,
                            ),
                          ),
                        );
                      } else if (state.getLampListStatus is BaseError) {
                        return const Center(
                          child: Text('ERROR'),
                        );
                      }
                      return const SizedBox();
                    },
                    listener: (BuildContext context, LampState state) {
                      if (state.getLampListStatus is BaseSuccess) {
                        List<LampModel> lamps =
                            (state.getLampListStatus as BaseSuccess).entity;
                        setState(() {
                          isEmpty = lamps.isEmpty;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                ],
              ),
            ),
            if (isSelect)
              Container(
                color: MyColors.black,
                width: double.infinity,
                padding: EdgeInsets.all(MySpaces.s12),
                child: Row(
                  children: [
                    Text(
                      al.numberSelectLamp(
                        selectedLamps.length.toString(),
                      ),
                      style: Light400Style.normal
                          .copyWith(color: MyColors.secondary.shade300),
                    ),
                    const Spacer(),
                    Opacity(
                      opacity: selectedLamps.isNotEmpty ? 1 : 0.5,
                      child: PrimaryButton(
                        onPress: selectedLamps.isNotEmpty
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailLampPage(
                                      selectedLamps,
                                      widget.groupId,
                                    ),
                                  ),
                                );
                              }
                            : () {
                                EasyLoading.showToast(al.errorNotSelected);
                              },
                        text: al.settings,
                        right: const Icon(
                          Iconsax.setting_2,
                          color: MyColors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  void _addClick() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddLampInternetBoxPage(
          groupId: widget.groupId,
          isInternetBox: false,
        ),
      ),
    );
  }

  void _addClickBlue() {
    EasyLoading.showToast(al.needInternetError);
  }
}
