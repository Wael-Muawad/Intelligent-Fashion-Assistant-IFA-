import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Model/Garment2.dart';
import 'package:testo/Model/Garment3.dart';
import 'package:testo/Model/Product.dart';
import 'package:testo/Screens/Details.dart';
import 'package:testo/Screens/Search.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/CustomNavigationBar.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:testo/Widgets/productCard.dart';

class Favorites extends StatefulWidget {
  //const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Future<Garment> _garmentModel;
  bool isLikeCheck = false;

  @override
  void initState() {
    _garmentModel = API_Manager().getLikedGarments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //bottomNavigationBar: CustomNavigationBar(),
        appBar: AppBarr(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Center(
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFEF6A7A7),
                  ),
                ),
              ),
            ),

            FutureBuilder<Garment>(
              //initialData: [],
              future: _garmentModel,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(child: GridView.builder(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.data[index];
                      return  ProductCard(
                          productImg: data.images[0],
                          productName: data.name,
                          brandName: data.brand,
                          picTap: () {
                            setState(() {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) =>
                                  Details(garmentId: data.id,),));
                            });
                          },
                          isLike: true,
                          isLikeTap: () async{
                            API_Manager().isLikeGarment(data.id);
                            _garmentModel = API_Manager().getLikedGarments();
                            setState(() {
                              print('is like');
                            });
                          });
                    },
                  ));
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }

              },
            )
          ],
        ),
      ),
    );
  }
}
