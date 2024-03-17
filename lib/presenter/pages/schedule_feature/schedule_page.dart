import 'package:easy_lamp/core/params/update_schedule_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/empty_page.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/crontab_model.dart';
import 'package:easy_lamp/data/model/schudule_model.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:easy_lamp/presenter/pages/schedule_feature/schedule_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScheduleBloc>(context).add(GetScheduleListEvent());
    BlocProvider.of<AuthBloc>(context).add(GetConnectionTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            bool isBlue = state.connectionType == ConnectionType.Bluetooth;
            if (isBlue) {
              EasyLoading.showToast(al.needInternetError);
            }
          },
          child: Column(
            children: [
              TopBar(
                title: al.planning,
                iconLeft: const Icon(
                  Icons.add,
                  color: MyColors.primary,
                  size: 30,
                ),
                onTapLeft: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ScheduleDetailPage()),
                  );
                },
              ),
              Expanded(
                child: BlocConsumer<ScheduleBloc, ScheduleState>(
                  builder: (context, state) {
                    if (state.getScheduleListStatus is BaseSuccess) {
                      List<ScheduleModel> items =
                          (state.getScheduleListStatus as BaseSuccess).entity;
                      if (items.isEmpty) {
                        return EmptyPage(
                          al.emptyScheduleMessage,
                          btnText: al.addSchedule,
                          imagePath: 'assets/images/cuate_schedule.png',
                          onTab: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ScheduleDetailPage()),
                            );
                          },
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: MySpaces.s32),
                        itemBuilder: (context, index) {
                          ScheduleModel item = items[index];
                          return ClickableContainer(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ScheduleDetailPage(
                                          schedule: item,
                                        )),
                              );
                            },
                            margin: const EdgeInsets.only(
                              left: MySpaces.s24,
                              right: MySpaces.s24,
                              bottom: MySpaces.s24,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            borderRadius: MyRadius.base,
                            color: MyColors.black.shade600,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                          "assets/icons/clock.svg",
                                          width: 20,
                                          height: 20,
                                        )),
                                    const SizedBox(
                                      width: MySpaces.s6,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Builder(builder: (context) {
                                          CrontabModel c =
                                              item.periodicTaskAssigned.crontab;
                                          return Text(
                                            '${c.hour.toString()}:${c.minute.toString()}',
                                            style: DemiBoldStyle.lg.copyWith(
                                                color: MyColors.white),
                                          );
                                        }),
                                        const SizedBox(
                                          height: MySpaces.s4,
                                        ),
                                        Text(
                                          item.name,
                                          style: DemiBoldStyle.sm.copyWith(
                                              color: MyColors.black.shade100),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    CupertinoSwitch(
                                      value: item.enabled,
                                      onChanged: (t) {
                                        BlocProvider.of<ScheduleBloc>(context)
                                            .add(PatchScheduleByIdEvent(
                                                UpdateScheduleParams(
                                                    id: item.id, enabled: t)));
                                      },
                                      activeColor: MyColors.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: items.length,
                      );
                    } else if (state.getScheduleListStatus is BaseLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primary,
                        ),
                      );
                    } else if (state.getScheduleListStatus is BaseError) {
                      return Center(
                        child: Text(ErrorHelper.getErrorMessage(
                            state.getScheduleListStatus, context)),
                      );
                    }
                    return const SizedBox();
                  },
                  listenWhen: (prev, curr) {
                    if (prev.patchScheduleByIdStatus is BaseSuccess &&
                        curr.patchScheduleByIdStatus is BaseNoAction) {
                      return false;
                    }
                    return true;
                  },
                  listener: (BuildContext context, ScheduleState state) {
                    if (state.patchScheduleByIdStatus is BaseSuccess) {
                      EasyLoading.showSuccess("SUCCESS");
                    } else if (state.patchScheduleByIdStatus is BaseLoading) {
                      EasyLoading.show();
                    } else if (state.patchScheduleByIdStatus is BaseError) {
                      ErrorHelper.getBaseError(
                          state.patchScheduleByIdStatus, context);
                    }
                  },
                ),
              )
            ],
          ),
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
              "assets/images/cuate_lamp.png",
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
                text: al.addGroup,
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
