import 'package:flutter/material.dart';
import 'package:testo/Model/DetailsResponse.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Model/Garment3.dart';
import 'package:testo/Screens/ShopProfile.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:testo/Model/Product.dart';




class Details extends StatefulWidget {
  final int garmentId;

  Details({
    this.garmentId,
  });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future<DetailsResponse> _detailsResponse;

  @override
  void initState() {
    _detailsResponse = API_Manager().getDetails(garmentId: widget.garmentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var product = ModalRoute.of(context).settings.arguments;

    List<Color> colors = [
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.purpleAccent,
      Colors.brown,
      Colors.yellow.shade200
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBarr(),
        body: SingleChildScrollView(
          child: FutureBuilder<DetailsResponse>(
            future: _detailsResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var product = snapshot.data.data;
                //product.storeApiDto.stroePhoto
                return Column(
                  children: [
                    _imageDetail(size, product),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2, color: Color(0xFEFE8F8F))),
                      child: _productColors(size, product),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Column(
                          children: [
                            _productNameAndPrice(product),
                            _productDescription(product),
                            _productBrand(product),
                          ],
                        )),
                    Container(
                      height: size.height * 0.15,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFE8F8F), width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      //color: Colors.greenAccent,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _shopImage(product,size),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.only(right: 3),
                                  alignment: Alignment.centerLeft,
                                  width: size.width * 0.72,
                                  //color: Colors.blue,
                                  child: _nameAndStars(product,size),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: size.width * 0.72,
                                  //color: Colors.blue,
                                  child: _shopLocation(product),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: size.width * 0.72,
                                  //color: Colors.blue,
                                  child: _shopNumber(product),
                                ),
                                //
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) =>
                                ShopProfile(storeId: product.storeId,storeRank: product.storeApiDto.rank,),));
                          });
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  _imageDetail(Size size, var product) {
    return Container(
      height: size.height * 0.45,
      //margin: EdgeInsets.only(top: 5),
      child: Hero(
        tag: product.images[0],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: NetworkImage(
                'http://10.0.2.2:5001/Images/${product.images[0]}'),
            /*NetworkImage(
                'http://10.0.2.2:7297/staticfiles/${product.images[0]}'),*/
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  _productColors(Size size, var product) {

    return Container(
        height: size.height * 0.07,
        //color: Colors.greenAccent,
        //alignment: Alignment.center,
        child: ListView.builder(
          itemCount: product.colors.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 100,
          itemBuilder: (context, index) {
            return Container(
              //margin: EdgeInsets.all(10),
              //padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(60),
                  border: Border.all(width: 3, color: Colors.blueGrey),
                  shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundColor: _getColorFromHex(product.colors[index]),
                /*Icons.circle,
                color: _getColorFromHex(product.colors[index]),
                size: 45,*/
              ),
            );
          },
        ));
  }

  _productNameAndPrice(var product) {
    return Container(
      // width: 180,
      // height: 25,
      alignment: Alignment.centerLeft,
      //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      //color: Colors.indigo,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Text(
              product.name,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }

  _productDescription(var product) {
    return Container(
      // width: 180,
      // height: 20,
      alignment: Alignment.centerLeft,
      // margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      //color: Colors.deepOrange,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Text(
              product.description,
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }

  _productBrand(var product) {
    return Container(
        // width: 180,
        // height: 20,
        alignment: Alignment.centerLeft,
        // margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        //color: Colors.deepOrange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Brand (${product.brand})',
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                '(${product.price} \$)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepOrange),
              ),
            )
          ],
        ));
  }

  //----------------------------------------

  _shopImage(Data product,Size size) {
    return Container(
      width: size.width * 0.25,
      //color: Colors.indigo,
      padding: EdgeInsets.only(left: 5),
      margin: EdgeInsets.only(right: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
        child: Image(
          height: 90,
          image: NetworkImage(
              'http://10.0.2.2:5001/Images/${product.storeApiDto.stroePhoto}'
              /*'http://10.0.2.2:5001/Images/${product.storeApiDto.stroePhoto}'*/
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _shopLocation(var product) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            Icons.location_on_outlined,
          ),
        ),
        Expanded(
            child: Text(
          '${product.storeApiDto.locations[0].city}, ${product.storeApiDto.locations[0].street}',
          style: TextStyle(fontSize: 19),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ))
      ],
    );
  }

  _shopNumber(var product) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(right: 3),
            padding: EdgeInsets.only(left: 3),
            child: Icon(Icons.call_outlined)),
        Expanded(
          child: Text(
            '${product.storeApiDto.locations[0].phoneNumber}',
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }

  _nameAndStars(var product,Size size) {
    var rank = product.storeApiDto.rank;
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            width: size.width * 0.20,
            margin: EdgeInsets.only(left: 3),
            //color: Colors.red,
            child: Text(
              '${product.storeApiDto.storeName}',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        GestureDetector(
            child: Icon(
                (rank >=1 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
        )),
        GestureDetector(
            child: Icon(
                rank >=2 ? Icons.star : Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                rank >=3 ? Icons.star : Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                rank >=4 ?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                rank >=5 ? Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
      ],
    );
  }

  Color ColorPicker(String colorTxt) {
    switch (colorTxt) {
      case 'White':
        return Colors.white;
      case 'Black':
        return Colors.black;
      case 'Beige':
        return Colors.deepOrange.shade200;
      case 'Red':
        return Colors.red;
      case 'Blue':
        return Colors.blueAccent;
      case 'Yellow':
        return Colors.yellow.shade200;
      case 'Green':
        return Colors.greenAccent;
      case 'Orange':
        return Colors.orangeAccent;
      case 'Pink':
        return Colors.pinkAccent;
    }
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      //return Color(int.parse(hexColor));
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
