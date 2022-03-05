import 'package:flutter/material.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Model/Garment3.dart';
import 'package:testo/Model/RateStoreRequest.dart';
import 'package:testo/Model/StoreDetailsResponse.dart';
import 'package:testo/Screens/Review.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:testo/Widgets/productCard.dart';
import 'package:testo/Widgets/productCard2.dart';

class ShopProfile extends StatefulWidget {
  //const ShopProfile({Key? key}) : super(key: key);
  final int storeId;
  final int storeRank;

  ShopProfile({
    this.storeId,
    this.storeRank,
  });
  @override
  _ShopProfileState createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  Future<StoreDetailsResponse> _storeModel;
  RateStoreRequest store = new RateStoreRequest();
  var rank = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeModel = API_Manager().getStoreWithGarments(storeId: widget.storeId,pageNumber: 1,pageSize: 50);
  }

  @override
  Widget build(BuildContext context) {

    //var product = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarr(),
        body: SingleChildScrollView(
          child: FutureBuilder<StoreDetailsResponse>(
            future: _storeModel,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var product = snapshot.data.data;
                return Container(
                  child: Column(
                    children: [
                      _profilePicture(size: size, product: product),
                      _profileName(product: product),
                      _ratingAndSomething(product),
                      _location(product: product),
                    Container(
                      height: 500,
                      width: size.width * 0.95,

                      child: ListView.builder(
                        itemCount: snapshot.data.data.garments.length,
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          var data = snapshot.data.data.garments[index];
                          return ProductCard2(
                              productImg:data.images[0],
                              productName: data.name,
                              brandName: data.brand,
                              picTap: () {
                                /*setState(() {
                                  Navigator.of(context)
                                      .pushNamed('details', arguments: data);
                                });*/
                              },

                              iconTap: () async {
                                API_Manager().isLikeGarment(data.id);
                                _storeModel = API_Manager().getStoreWithGarments(storeId: widget.storeId,pageNumber: 1,pageSize: 50);
                                setState(() {
                                  print('is like');
                                });
                              },
                              isLike: data.isLike,);
                        },
                      ),
                    ),
                    ],
                  ),
                );
              }
              else{
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

  _ratingAndSomething(var product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFEA69C90))
            ),
              child: Text(
            'View Comments..',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => Review(product,widget.storeId)
              ));
            }
          ),
        ),
        Container(margin: EdgeInsets.only(right: 15), child: _starNormal())
      ],
    );
  }
  _starNormal(){
    rank = widget.storeRank;
    return Row(
      children: [
        GestureDetector(
            child: Icon(
                (rank >=1 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                (rank >=2 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                (rank >=3 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                (rank >=4 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            child: Icon(
                (rank >=5 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
      ],
    );
  }
}

_profilePicture({@required Size size, @required Data product}) {
  return Center(
    child: Container(
      height: size.height * 0.30,
      width: size.height * 0.30,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 4, color: Color(0xFEFEC18F)),
      ),
      child: Hero(
        tag: product.stroePhoto,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: NetworkImage('http://10.0.2.2:5001/Images/${product.stroePhoto}'
                //'http://10.0.2.2:5001/Images/${product.images[0]}'
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

_profileName({var product}) {
  product.storeName = product.storeName.replaceFirst(product.storeName[0], product.storeName[0].toUpperCase());
  return Container(
      padding: EdgeInsets.only(bottom: 15, left: 5, right: 5),
      child: Flex(direction: Axis.horizontal, children: [
        Expanded(
          child: Center(
            child: Text(
              product.storeName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFED76E26),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]));
}



_location({var product}) {
  //product.locations[index].country
  //product.locations[index].street
  //product.locations[index].city
  //product.locations[index].phoneNumber
  return Container(
    height: 150,
    color: Colors.black12,
    margin: EdgeInsets.only(top: 20),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: product.locations.length,
      itemBuilder: (context, index) {
        return Card(
            child: Container(
          padding: EdgeInsets.all(10),
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.locations[index].country,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text(
                      product.locations[index].street,
                      style: TextStyle(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Text(product.locations[index].city),
              Text(product.locations[index].phoneNumber),
            ],
          ),
        ));
      },
    ),
  );
}

/*
FutureBuilder<Garment3>(
                future: _garmentModel,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    return Container(
                      height: 500,
                      width: size.width *0.8,
                      child: ListView.builder(
                        itemCount: snapshot.data.data.length,
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          var data = snapshot.data.data[index];
                          return  ProductCard(
                              productImg: 'https://lumiere-a.akamaihd.net/v1/images/sa_pixar_virtualbg_coco_16x9_9ccd7110.jpeg',
                              productName: data.name,
                              brandName: data.brand,
                              picTap: () {
                                setState(() {
                                  Navigator.of(context).pushNamed('details',
                                      arguments: data);
                                });
                              },
                              iconTap: () {
                                setState(() {
                                  /*productList[index].isLike =
                                  !productList[index].isLike;*/
                                });
                              },
                              isLike: false
                          );

                        },
                      ),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }

                },
              )
 */
