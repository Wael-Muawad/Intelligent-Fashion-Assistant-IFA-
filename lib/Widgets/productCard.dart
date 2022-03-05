import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productImg, productName,brandName;
  final Function picTap, isLikeTap;
  final bool isLike;

  ProductCard({
    @required this.productImg,
    @required this.productName,
    @required this.brandName,
    @required this.picTap,
    @required this.isLikeTap,
    @required this.isLike,
  });
  static const IconData heart_outlined = IconData(0xf442, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData heart = IconData(0xf443, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: productImg,
                      child: Container(
                        //width: 240,
                        //height: 170,
                        // color: Colors.redAccent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image: NetworkImage('http://10.0.2.2:5001/Images/$productImg'),
                            height: 130,
                            //width: 160,
                            //NetworkImage('http://10.0.2.2:7297/staticfiles/$productImg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 5,
                      right: 0,
                      child: GestureDetector(
                        child: Icon(
                          isLike ? heart : heart_outlined,
                          size: 40,
                          color: Color(0xFFFE8F8F),
                        ),
                        onTap: isLikeTap,
                      )),
                  Positioned(
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
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: Container(
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
                  )
                ],
              ),
      ),
      onTap: picTap,
    );
  }
}
