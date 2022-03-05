import 'package:flutter/material.dart';

class AppBarr extends StatelessWidget with PreferredSizeWidget {
  final String title;
  AppBarr({
    this.title = ''
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          Image.asset(
            'assets/l8.png',
            fit: BoxFit.contain,
            width: 80,
          ),
        ],
      ),
      toolbarHeight: 50,
      //Color(0xFFE40282),
      backgroundColor: Color(0xFFDE739F),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
