import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LampPage extends StatefulWidget {
  int groupId;

  LampPage(this.groupId, {Key? key}) : super(key: key);

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/arrow_right.svg"),
                  Expanded(
                    child: Text(
                      al.lampList,
                      textAlign: TextAlign.center,
                      style: TitleStyle.t4.copyWith(
                        color: MyColors.white,
                      ),
                    ),
                  ),
                  InkWell(
                      borderRadius: MyRadius.sm,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AddLampPage(
                                    groupId: widget.groupId,
                                  )),
                        );
                      },
                      child: SvgPicture.asset("assets/icons/add_circle.svg")),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<LampBloc, LampState>(
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
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: MySpaces.s32),
                      itemBuilder: (context, index) {
                        LampModel lamp = lamps[index];
                        return Container(
                          margin: const EdgeInsets.only(
                              left: MySpaces.s24,
                              right: MySpaces.s24,
                              bottom: MySpaces.s16),
                          decoration: BoxDecoration(
                              borderRadius: MyRadius.base,
                              color: MyColors.black.shade600),
                          padding: const EdgeInsets.all(15),
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
                                        return EditGroupBottomSheet();
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
                                    lamp.name,
                                    style: DemiBoldStyle.lg
                                        .copyWith(color: MyColors.white),
                                  ),
                                  Text(
                                    lamp.description,
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
                      itemCount: lamps.length,
                    );
                  } else if (state.getLampListStatus is BaseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.getLampListStatus is BaseError) {
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
}
