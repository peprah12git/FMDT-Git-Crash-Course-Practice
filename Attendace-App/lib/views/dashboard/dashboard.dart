import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/utils/shared_prefs.dart';
import 'package:attendance_app/views/attendance/attendance_history.dart';
import 'package:attendance_app/views/home/home.dart';
import 'package:attendance_app/views/profile/profile.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key, this.pageIndex});
  final int? pageIndex;
  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _pageIndex = 0;
  PageController? _pageController;

  List<Widget>? screens;
  @override
  void initState() {
    print(getUserProfile());
    // userController.getUser();

    _pageController = PageController(initialPage: _pageIndex);

    screens = [
      HomeView(),
      AttendanceHistory(),
      const ProfileView(),

      ////////////
    ];
    // noCardDilog();
    super.initState();
  }

  void _setPage(int pageIndex) {
    setState(() {
      // print(userController.user.value.phoneNumber);
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   noCardDilog();
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      // noCardDilog();
    });
    var textStyle = const TextStyle(
        fontSize: 12, fontFamily: "Lato", fontWeight: FontWeight.w400);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: screens!.length,
            itemBuilder: ((context, index) => screens![index])),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: textStyle,
        unselectedLabelStyle: textStyle,
        selectedItemColor: CustomeColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        onTap: _setPage,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(FeatherIcons.home)),
          BottomNavigationBarItem(
              label: "Attendance", icon: Icon(FeatherIcons.activity)),
          BottomNavigationBarItem(
              label: "Profile", icon: Icon(FeatherIcons.user)),
        ],
      ),
    );
  }
}
