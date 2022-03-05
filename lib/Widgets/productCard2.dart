import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard2 extends StatelessWidget {
  final String productImg, productName,brandName;
  final Function picTap, iconTap;
  final bool isLike;

  ProductCard2({
    @required this.productImg,
    @required this.productName,
    @required this.brandName,
    @required this.picTap,
    @required this.iconTap,
    @required this.isLike,
  });
  static const IconData heart_outlined = IconData(0xf442, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData heart = IconData(0xf443, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        shadowColor: Colors.pinkAccent,
        margin: EdgeInsets.symmetric(horizontal:  5, vertical:  5),
        //color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            Container(
              height: 250,
              padding: EdgeInsets.only(left: 1,right: 1),
              alignment: Alignment.topCenter,
              child: Hero(
                tag: productImg,
                child: Container(
                  //width: 240,
                  //height: 200,
                  // color: Colors.redAccent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                    child: Image(
                      image: NetworkImage('http://10.0.2.2:5001/Images/$productImg'),
                      height: 205,
                      //width: 160,
                      //NetworkImage('http://10.0.2.2:7297/staticfiles/$productImg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Positioned(
                  top: 5,
                  right: 0,
                  child: GestureDetector(
                    child: Icon(
                      isLike ? heart : heart_outlined,
                      size: 40,
                      color: Color(0xFFFE8F8F),
                    ),
                    onTap: iconTap,
                  )),

            ),
            Container(
              child: Positioned(
                bottom: 25,
                left: 5,
                child: Container(
                  width: 180,
                  //height: 25,
                  alignment: Alignment.centerLeft,
                  // margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  //color: Colors.indigo,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  //color: Colors.blue,
                  width: 180,
                  height: 20,
                  alignment: Alignment.centerLeft,
                  // margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  //color: Colors.deepOrange,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Text(
                          brandName,
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: picTap,
    );
  }
}
