import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15, top: 0),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color:  Color(0xFFE40282),
          //border: Border.all(color:Color(0xff002b36), width: 2),
          //borderRadius:const BorderRadius.all(Radius.circular(5)),
          boxShadow: const [
            /*BoxShadow(
                color: Colors.black87,
                blurRadius:0,
                blurStyle:BlurStyle.normal,
                spreadRadius: 1,
                offset: Offset(3, 3)
            ),*/
            /*BoxShadow(
                color: Colors.white,
                blurRadius:0,
                blurStyle:BlurStyle.normal,
                spreadRadius: 1,
                offset: Offset(1, 1)
            )*/
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: (){Navigator.pushReplacementNamed(context, "Category");},
            icon: const Icon(Icons.home, size: 30, color: Colors.white,),
          ),
          IconButton(
            onPressed: (){Navigator.pushReplacementNamed(context, "search");},
            icon: const Icon(Icons.category, size: 30, color: Color(0xff002b36),),
          ),
          IconButton(
            onPressed: (){Navigator.pushReplacementNamed(context, "Favorites");},
            icon: const Icon(Icons.view_module_rounded, size: 30, color: Colors.white,),
          ),
          IconButton(
            onPressed: (){Navigator.pushReplacementNamed(context, "fullProfile");},
            icon: const Icon(Icons.person, size: 30, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
