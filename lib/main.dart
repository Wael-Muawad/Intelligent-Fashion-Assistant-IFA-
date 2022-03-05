import 'package:flutter/material.dart';
import 'package:testo/BottomNavBar.dart';
import 'package:testo/Screens/Categories.dart';
import 'package:testo/Screens/CategoryGarments.dart';
import 'package:testo/Screens/Details.dart';
import 'package:testo/Screens/EditProfile.dart';
import 'package:testo/Screens/Favorites.dart';
import 'package:testo/Screens/FullProfile.dart';
import 'package:testo/Screens/HomePage.dart';
import 'package:testo/Screens/Login.dart';
import 'package:testo/Screens/Profile.dart';
import 'package:testo/Screens/Review.dart';
import 'package:testo/Screens/Search.dart';
import 'package:testo/Screens/ShopProfile.dart';
import 'package:testo/Screens/Signup.dart';

void main() {
  return runApp(MaterialApp(
    title: 'IFA',
    theme: ThemeData(
      primaryColor: Colors.pinkAccent,
      scaffoldBackgroundColor: Colors.white,
      //dividerColor: Colors.blueGrey
    ),
    initialRoute: 'login',
    routes: {
      'BottomNavBar': (context) => BottomNavBar(),
      'login': (context) => Login(),
      'signup': (context) => Signup(),
      'profile': (context) => Profile(),
      'search': (context) => Search(),
      'Favorites': (context) => Favorites(),
      'Home': (context) => Home(),
      'details': (context) => Details(),
      'fullProfile': (context) => FullProfile(),
      'editProfile': (context) => EditProfile(),
      'shopProfile': (context) => ShopProfile(),
      //'review': (context) => Review(),
      'Category': (context) => Categories(),
      'CategoryGarments': (context) => CategoryGarments(),
      /*  'intro':(context) => IntroPage(),
      'login':(context) => Login(),
      'signup':(context) => Signup(),
      'homepage':(context) => HomePage(),
      'drawer':(context) => DrawerPage(),
      'details': (context) => Details(),
      'cart': (context) => CartPage(),*/
    },
    debugShowCheckedModeBanner: false,
  ));
}
