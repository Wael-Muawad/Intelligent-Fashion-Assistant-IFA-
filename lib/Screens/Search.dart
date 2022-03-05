import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testo/BottomNavBar.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Model/Garment2.dart';
import 'package:testo/Model/Garment3.dart';
import 'package:testo/Model/Product.dart';
import 'package:testo/Screens/Details.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Shared/rounded_input_field.dart';
import 'package:testo/Widgets/CustomNavigationBar.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:testo/Widgets/productCard.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<Garment> _garmentModel;
  bool isLikeCheck = false;
  String search = '';

  @override
  void initState() {
    _garmentModel = API_Manager().getAllGarments(pageNumber: 1, pageSize: 50);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarr(title: 'Search',),
        //bottomNavigationBar: CustomNavigationBar(),
        body: Column(
          children: [
            RoundedInputField(
              hintText: 'Search',
              keyboardType: TextInputType.emailAddress,
              icon: Icons.search,
              controlar: searchController,
              textFieldColor: Colors.white,
              iconColor: Colors.pinkAccent,
              borderColor: Colors.pinkAccent.shade100,
              onChanged: (value) {
                setState(() {
                  //searchController.text = value;
                  searchController.text == ''
                      ? _garmentModel = API_Manager()
                          .getAllGarments(pageNumber: 1, pageSize: 50)
                      : _garmentModel = API_Manager().searchGarments(
                          searchWord: searchController.text,
                          pageNumber: 1,
                          pageSize: 50);
                  print('change');
                });
              },
            ),
            FutureBuilder<Garment>(
              //initialData: [],
              future: _garmentModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: GridView.builder(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10, crossAxisCount: 2),
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.data[index];
                      return ProductCard(
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
                          isLike: data.isLike,
                          isLikeTap: () async{
                            API_Manager().isLikeGarment(data.id);
                            _garmentModel = API_Manager().getAllGarments(pageNumber: 1, pageSize: 50);
                            setState(() {
                              print('is like');
                            });
                          });
                    },
                  ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

/*
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
                              Navigator.of(context).pushNamed('details',
                                  arguments: data);
                            });
                          },
                        isLike: isLikeCheck,
                        isLikeTap: (){
                          isLikeCheck = !isLikeCheck;
                          setState(() {
                            API_Manager().isLikeGarment(data.id);
                          });
                        }
                      );
                    },
                  ));
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            )
 */
