import 'dart:async';

import 'package:app/Screen/home/home.dart';
import 'package:app/Screen/profile/user_profile.dart';
import 'package:app/model/user_entity.dart';
import 'package:app/preference/user_preference_data.dart';
import 'package:app/service/injection.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, this.index = 0, this.innerPageRoute})
      : super(key: key);

  final int index;
  final String? innerPageRoute;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

late PersistentTabController controller;

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  // ConnectivityListnerBloc connectivityListnerBloc =
  //     getIt<ConnectivityListnerBloc>();
  // final DevelopmentLogger logger = getIt<DevelopmentLogger>();

  String? pageRoute;
  Timer? timer;

  @override
  void dispose() {
    // connectivityListnerBloc.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    pageRoute = widget.innerPageRoute;
    controller = PersistentTabController(initialIndex: widget.index);
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      FutureBuilder(
          future: getIt<UserPreferences>().getUserInformation(),
          builder: (BuildContext context, AsyncSnapshot<UserEntity?> snapshot) {
            if (snapshot.hasData) {
              return UserProfile(userEntity: snapshot.data);
            } else {
              return SizedBox();
            }
          })
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      navItem(icon: Icons.note_add),
      navItem(icon: Icons.person),
    ];
  }

  PersistentBottomNavBarItem navItem({
    required IconData icon,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      contentPadding: 0,
      activeColorPrimary: AppTheme.primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PersistentTabView(
          context,
          controller: controller,
          padding: const NavBarPadding.symmetric(vertical: 10),
          navBarHeight: 70,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          onItemSelected: (index) {
            clearPageRoute();
          },
          backgroundColor: Colors.black, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: false, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: const NavBarDecoration(
            colorBehindNavBar: Colors.white,

            // boxShadow: AppTheme.backgroundColor,
          ),
          // onWillPop: willPopCallback,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .simple, // Choose the nav bar style with this property.
        ));
  }

  void clearPageRoute() {
    if (pageRoute != null) {
      setState(() => pageRoute = null);
    }
  }
}
