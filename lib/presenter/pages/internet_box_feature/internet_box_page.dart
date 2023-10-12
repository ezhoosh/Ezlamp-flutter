import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/presenter/bloc/internet_box_bloc/internet_box_bloc.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_group_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InternetBoxPage extends StatefulWidget {
  const InternetBoxPage({Key? key}) : super(key: key);

  @override
  State<InternetBoxPage> createState() => _InternetBoxPageState();
}

class _InternetBoxPageState extends State<InternetBoxPage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InternetBoxBloc>(context).add(GetInternetBoxListEvent());
  }

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
            TopBar(
              title: al.internetLamp,
              onTapLeft: _addClick,
              iconLeft: SvgPicture.asset("assets/icons/add_circle.svg"),
              onTapRight: () {
                Navigator.pop(context);
              },
              iconRight: SvgPicture.asset("assets/icons/arrow_right.svg"),
            ),
            Expanded(
              child: BlocBuilder<InternetBoxBloc, InternetBoxState>(
                buildWhen: (prev, curr) {
                  if (prev.getInternetBoxListStatus is BaseSuccess &&
                      curr.getInternetBoxListStatus is BaseNoAction) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state.getInternetBoxListStatus is BaseSuccess) {
                    List<InternetBoxModel> list =
                        (state.getInternetBoxListStatus as BaseSuccess).entity;
                    if (list.isEmpty) {
                      return getEmptyPage();
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: MySpaces.s32),
                      itemBuilder: (context, index) {
                        InternetBoxModel item = list[index];
                        return ClickableContainer(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(
                              left: MySpaces.s24,
                              right: MySpaces.s24,
                              bottom: MySpaces.s16),
                          borderRadius: MyRadius.base,
                          color: MyColors.black.shade600,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return EditInternetBoxBottomSheet();
                                      },
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/icons/lamp_on.svg",
                                    width: 30,
                                    height: 30,
                                  )),
                              const SizedBox(
                                width: MySpaces.s6,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: DemiBoldStyle.lg
                                        .copyWith(color: MyColors.white),
                                  ),
                                  Text(
                                    item.description,
                                    style: DemiBoldStyle.sm.copyWith(
                                        color: MyColors.black.shade100),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: SvgPicture.asset(
                                  "assets/icons/arrow_right.svg",
                                  color: MyColors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: list.length,
                    );
                  } else if (state.getInternetBoxListStatus is BaseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.getInternetBoxListStatus is BaseError) {
                    return const Center(
                      child: Text('ERROR'),
                    );
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getEmptyPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MySpaces.s40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/cuate.png",
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            Text(
              AppLocalizations.of(context)!.addInternetLamp,
              style: Light300Style.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                onPress: _addClick,
                text: al.addInternetLamp,
                right: const Icon(
                  Icons.add,
                  color: MyColors.white,
                ),
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
                isInternetBox: true,
              )),
    );
  }
}
