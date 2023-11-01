import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_back.dart';
import 'package:easy_lamp/core/widgets/arrow_list.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/empty_page.dart';
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
              iconRight: ArrowBack(),
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
                      return EmptyPage(
                        al.addInternetLamp,
                        onTab: _addClick,
                      );
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
                              SvgPicture.asset(
                                "assets/icons/lamp_on.svg",
                                width: 30,
                                height: 30,
                              ),
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
                              ArrowList()
                            ],
                          ),
                        );
                      },
                      itemCount: list.length,
                    );
                  } else if (state.getInternetBoxListStatus is BaseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primary,
                      ),
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

  void _addClick() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => AddLampInternetBoxPage(
                isInternetBox: true,
              )),
    );
  }
}
