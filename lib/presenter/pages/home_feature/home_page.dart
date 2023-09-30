import 'package:easy_lamp/presenter/pages/schedule_feature/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/presenter/pages/group_feature/group_page.dart';
import 'package:easy_lamp/core/widgets/dot_navigation/dot_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          Container(),
          const GroupPage(),
          const SchedulePage(),
          Container(),
        ],
      ),
      backgroundColor: MyColors.black,
      bottomNavigationBar: DotNavigationBar(
        borderRadius: 0,
        currentIndex: currentPage,
        backgroundColor: MyColors.black,
        marginR: EdgeInsets.zero,
        itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          getItemBottomNavigation("tab_timer.svg"),
          getItemBottomNavigation("tab_home.svg"),
        ],
      ),
    );
  }

  getItemBottomNavigation(String aa) {
    return DotNavigationBarItem(path: "assets/icons/$aa");
  }
}
