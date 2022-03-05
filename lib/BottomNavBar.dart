import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:testo/Screens/Categories.dart';
import 'package:testo/Screens/Details.dart';
import 'package:testo/Screens/Favorites.dart';
import 'package:testo/Screens/FullProfile.dart';
import 'package:testo/Screens/Login.dart';
import 'package:testo/Screens/Profile.dart';
import 'package:testo/Screens/Search.dart';
import 'package:testo/Screens/Signup.dart';

 int pageIndex = 0;
 final screens = [Search(),Favorites(),Categories(),FullProfile(),];

class BottomNavBar extends StatefulWidget {
  //final BuildContext context;
  //
  BottomNavBar();
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final items = <Widget>[
    Icon(
      Icons.search,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.favorite,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.line_weight,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.person,
      size: 30,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return

    SafeArea(
      child: Scaffold(
        body: screens[pageIndex],
        bottomNavigationBar:CurvedNavigationBar(
          items: items,
          key: navigationKey,
          index: pageIndex,
          onTap: (index) => setState(() => pageIndex = index),

          //StyleColor(0xFFE40282),
          color: Color(0xFFDE739F),
          buttonBackgroundColor: Color(0xFFE40282),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          height: 60,
        ) ,
      ),
    );





  }
}
