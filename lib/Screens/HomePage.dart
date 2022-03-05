import 'package:flutter/material.dart';
import 'package:testo/BottomNavBar.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}
