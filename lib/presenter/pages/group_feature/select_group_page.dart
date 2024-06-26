import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/secondary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/core/widgets/empty_page.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/add_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/command_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/group_card.dart';
import 'package:easy_lamp/presenter/pages/group_feature/more_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/select_group_card.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/more_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_group_page.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/lamp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectGroupPage extends StatefulWidget {
  List<GroupModel> selectGroups = [];

  SelectGroupPage(this.selectGroups, {Key? key}) : super(key: key);

  @override
  State<SelectGroupPage> createState() => _SelectGroupPageState();
}

class _SelectGroupPageState extends State<SelectGroupPage> {
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
        child: BlocListener<CommandBloc, CommandState>(
          listenWhen: (prev, curr) {
            if (prev.sendCommandStatus is BaseSuccess &&
                curr.sendCommandStatus is BaseNoAction) {
              return false;
            }
            return true;
          },
          listener: (context, state) {
            if (state.sendCommandStatus is BaseSuccess) {
              EasyLoading.showSuccess(AppLocalizations.of(context)!.success.toString());
            } else if (state.sendCommandStatus is BaseLoading) {
              EasyLoading.show();
            } else if (state.sendCommandStatus is BaseError) {
              ErrorHelper.getBaseError(state.sendCommandStatus, context);
            }
          },
          child: Column(
            children: [
              TopBar(
                  title: al.addGroup,
                  onTapLeft: _saveClick,
                  iconLeft: Text(
                    al.save,
                    style:
                        DemiBoldStyle.normal.copyWith(color: MyColors.primary),
                  )),
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
                      List<GroupModel> groups =
                          (state.getGroupListStatus as BaseSuccess).entity;
                      if (groups.isEmpty) {
                        return EmptyPage(
                          al.addYourGroup,
                          onTab: _saveClick,
                          btnText: al.addGroup,
                        );
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.only(top: MySpaces.s32),
                        itemBuilder: (context, index) {
                          GroupModel group = groups[index];
                          return SelectGroupCard(
                            group,
                            select: widget.selectGroups
                                .where((element) => element.id == group.id)
                                .isNotEmpty,
                            onTap: () {
                              setState(() {
                                if (widget.selectGroups
                                    .where((element) => element.id == group.id)
                                    .isNotEmpty) {
                                  widget.selectGroups.remove(group);
                                } else {
                                  widget.selectGroups.add(group);
                                }
                              });
                            },
                          );
                        },
                        itemCount: groups.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1.7),
                      );
                    } else if (state.getGroupListStatus is BaseLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primary,
                        ),
                      );
                    } else if (state.getGroupListStatus is BaseError) {
                      return const Center(
                        child: Text('ERROR'),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveClick() {
    if (widget.selectGroups.isEmpty) {
      Navigator.pop(context);
      return;
    }
    Navigator.pop(context, widget.selectGroups);
  }
}
