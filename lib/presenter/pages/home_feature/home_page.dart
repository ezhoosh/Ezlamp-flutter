import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/data/repositories/isar_group_repository.dart';
import 'package:easy_lamp/locator.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:easy_lamp/presenter/pages/group_feature/group_page.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/profile_page.dart';
import 'package:easy_lamp/presenter/pages/schedule_feature/schedule_page.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/splash_page.dart';
import 'package:easy_lamp/presenter/pages/state_feature/state_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/widgets/dot_navigation/dot_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 1);
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) {
          if (prev.logOutStatus is BaseSuccess &&
              curr.logOutStatus is BaseNoAction) {
            return false;
          }
          return true;
        },
        listener: (context, state) {
          if (state.logOutStatus is BaseSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashPage()),
                ModalRoute.withName("/"));
          }
        },
        child: BlocListener<StateBloc, StateState>(
          listener: (context, state) {
            if (state.getChartInformation is BaseSuccess) {
              setState(() {
                currentPage = 2;
              });
              controller.animateToPage(
                2,
                duration: const Duration(microseconds: 500),
                curve: Curves.easeIn,
              );
            }
          },
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: const [
              ProfilePage(),
              GroupPage(),
              StatePage(),
              SchedulePage(),
            ],
          ),
        ),
      ),
      backgroundColor: MyColors.black,
      bottomNavigationBar: DotNavigationBar(
        borderRadius: 0,
        currentIndex: currentPage,
        backgroundColor: MyColors.black,
        marginR: EdgeInsets.zero,
        itemPadding: const EdgeInsets.symmetric(horizontal: 20),
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
          controller.animateToPage(
            i,
            duration: const Duration(microseconds: 500),
            curve: Curves.easeIn,
          );
        },
        selectedItemColor: MyColors.white,

        unselectedItemColor: MyColors.secondary.shade800,
        // dotIndicatorColor: Colors.black,
        items: [
          getItemBottomNavigation("tab_user.svg"),
          getItemBottomNavigation("tab_group.svg"),
          getItemBottomNavigation("chart.svg"),
          getItemBottomNavigation("tab_timer.svg"),
        ],
      ),
    );
  }

  getItemBottomNavigation(String aa) {
    return DotNavigationBarItem(path: "assets/icons/$aa");
  }
}
