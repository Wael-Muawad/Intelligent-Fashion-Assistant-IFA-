import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:testo/Model/CategoryResponse.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Screens/CategoryGarments.dart';
import 'package:testo/Screens/Details.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/CustomNavigationBar.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:testo/Widgets/productCard2.dart';

class Categories extends StatefulWidget {
  //const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<CategoryResponse> _categoryModel;
  Future<Garment> _garmentModel;
  static const IconData heart_outlined = IconData(0xf442, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData heart = IconData(0xf443, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  String catName = 'Categories';
  int catId = 0;
  @override
  void initState() {
    // TODO: implement initState
    _categoryModel = API_Manager().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarr(title: catName,),
        //bottomNavigationBar: CustomNavigationBar(),
        body: Column(
      children: [
        Container(
          height: 120,
          //color: Colors.grey,
          child: FutureBuilder<CategoryResponse>(
            future: _categoryModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                var data = snapshot.data.data[index];
                return Container(
                  width: 100,
                  height: 100,
                  //color: Colors.grey,
                  margin: EdgeInsets.only(left: 5,top: 5,),
                  /*decoration: BoxDecoration(
                  //nega
                  //japanBlush
                  gradient:  FlutterGradients.frozenDreams(type: GradientType.linear),
                  border: Border.all(color: Color(0xfff36495),width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),*/
                  child: IconButton(
                      icon: Stack(
                        children: [
                          //Color(0xFFE40282)
                          // Color(0xfff36495)
                          Icon(heart,color: Color(0xfff36495),size: 100,),
                          Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(15),
                            child: FittedBox(child:
                            Text(data.name.length<4? ' ${data.name} ':'${data.name}'
                              ,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white,),)),
                          ),
                        ],
                      ),
                    onPressed: () {
                        catName = data.name;
                        catId = data.id;
                        _garmentModel = API_Manager().categoryGarments(categoryId: data.id,pageNumber: 1,pageSize: 50);
                        setState(() {

                        });
                      /*Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) =>
                          CategoryGarments(categoryId: data.id,categoryName: data.name,),));*/
                    },
                  ),
                );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        //_displayName(catName),
        FutureBuilder<Garment>(
          //initialData: [],
          future: _garmentModel,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Expanded(child: ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data.data[index];

                  return  ProductCard2(
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
                      iconTap: () async {
                        //isLikeCheck = !isLikeCheck;
                        API_Manager().isLikeGarment(data.id);
                        _garmentModel = API_Manager().categoryGarments(categoryId: catId,pageNumber: 1,pageSize: 50);
                        setState(() {

                        });
                      }
                  );
                },
              ));
            }else{
              return Text('');}

          },
        )
      ],
        ),
      ),
    );
  }
}
_displayName(String categoryName){
  return Container(
    margin: EdgeInsets.all(25),
    child: Center(
      child: Text(
        categoryName == null?'':categoryName,
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Color(0xFEF6A7A7),
        ),
      ),
    ),
  );
}
/*
TextButton(
                      style: ButtonStyle(
                        /*elevation: MaterialStateProperty.all(3),
                        shadowColor: MaterialStateProperty.all(Color(0xFEFE8F8F)),*/
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                            ),
                          )),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) =>
                            CategoryGarments(categoryId: data.id,categoryName: data.name,),));
                      },
                      child: Text(
                        data.name,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFEB42A2A)
                      ),
                      ),
                    ),
 */