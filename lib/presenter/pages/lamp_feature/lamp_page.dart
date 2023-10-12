import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/empty_page.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_group_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/detail_lamp_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(
                      title: al.lampList,
                      onTapRight: () {
                        Navigator.pop(context);
                      },
                      iconRight:
                          SvgPicture.asset("assets/icons/arrow_right.svg"),
                      iconLeft: Container(
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
                    BlocBuilder<LampBloc, LampState>(
                      buildWhen: (prev, curr) {
                        if (prev.getLampListStatus is BaseSuccess &&
                            curr.getLampListStatus is BaseNoAction) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state.getLampListStatus is BaseSuccess) {
                          List<LampModel> lamps =
                              (state.getLampListStatus as BaseSuccess).entity;
                          if (lamps.isEmpty) {
                            return EmptyPage(
                              al.addLamps,
                              onTab: _addClick,
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: MySpaces.s32),
                            itemBuilder: (context, index) {
                              LampModel lamp = lamps[index];
                              return LampCard(
                                  lamp, isSelect, selectedLamps.contains(lamp),
                                  (t) {
                                if (t as bool) {
                                  setState(() {
                                    selectedLamps.add(lamp);
                                  });
                                } else {
                                  setState(() {
                                    selectedLamps.remove(lamp);
                                  });
                                }
                              });
                            },
                            itemCount: lamps.length,
                          );
                        } else if (state.getLampListStatus is BaseLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primary,
                            ),
                          );
                        } else if (state.getLampListStatus is BaseError) {
                          return const Center(
                            child: Text('ERROR'),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: MySpaces.s24),
                      width: double.infinity,
                      child: PrimaryButton(
                        text: al.addLamps,
                        onPress: _addClick,
                      ),
                    )
                  ],
                ),
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
                    PrimaryButton(
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailLampPage(
                              selectedLamps,
                            ),
                          ),
                        );
                      },
                      text: al.settings,
                      right: const Icon(
                        Iconsax.setting_2,
                        color: MyColors.white,
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
}
