import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/more_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
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
    BlocProvider.of<GroupBloc>(context).add(GetGroupListEvent());
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
                onTapLeft: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddLampPage()),
                  );
                },
                iconLeft: SvgPicture.asset("assets/icons/add_circle.svg")),
            Expanded(
              child: BlocBuilder<GroupBloc, GroupState>(
                buildWhen: (prev, curr) {
                  if (prev.getGroupListStatus is BaseSuccess &&
                      curr.getGroupListStatus is BaseNoAction) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state.getGroupListStatus is BaseSuccess) {
                    List<InternetBoxModel> groups =
                        (state.getGroupListStatus as BaseSuccess).entity;
                    if (groups.isEmpty) {
                      return getEmptyPage();
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: MySpaces.s32),
                      itemBuilder: (context, index) {
                        InternetBoxModel group = groups[index];
                        return ClickableContainer(
                          margin: const EdgeInsets.only(
                            right: MySpaces.s24,
                            left: MySpaces.s24,
                          ),
                          padding: const EdgeInsets.only(
                            left: MySpaces.s24,
                            right: MySpaces.s24,
                            bottom: MySpaces.s12,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LampPage(group.id)));
                          },
                          borderRadius: MyRadius.base,
                          color: MyColors.black.shade600,
                          child: Column(
                            children: [
                              Row(
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
                                            return MoreInternetBoxBottomSheet(
                                                group.id);
                                          },
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/edit.svg",
                                        width: 20,
                                        height: 20,
                                      )),
                                  const SizedBox(
                                    width: MySpaces.s6,
                                  ),
                                  Text(
                                    group.name,
                                    style: DemiBoldStyle.lg
                                        .copyWith(color: MyColors.white),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      color: MyColors.secondary.shade200,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24),
                                          )),
                                          context: context,
                                          builder: (context) {
                                            return EditInternetBoxBottomSheet();
                                          });
                                    },
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 26),
                                  child: Text(
                                    al.lamp(group.lamps.length.toString()),
                                    style: DemiBoldStyle.sm.copyWith(
                                        color: MyColors.black.shade100),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: MySpaces.s12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SecondaryButton(
                                      text: al.off,
                                      right: const Icon(
                                        Icons.power_settings_new_outlined,
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: MySpaces.s8,
                                  ),
                                  Expanded(
                                    child: SecondaryButton(
                                      text: al.on,
                                      right: const Icon(
                                        Icons.power_settings_new_outlined,
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: groups.length,
                    );
                  } else if (state.getGroupListStatus is BaseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.getGroupListStatus is BaseError) {
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
              AppLocalizations.of(context)!.addYourGroup,
              style: Light300Style.normal.copyWith(color: MyColors.white),
            ),
            const SizedBox(
              height: MySpaces.s16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                text: 'افزودن گروه',
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
}
