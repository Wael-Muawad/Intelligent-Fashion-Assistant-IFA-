import 'package:flutter/material.dart';
import 'package:testo/Model/Garment.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:testo/Widgets/productCard.dart';



class CategoryGarments extends StatefulWidget {
  //const CategoryGarments({Key? key}) : super(key: key);
  final int categoryId;
  final String categoryName;

   CategoryGarments({
       this.categoryId,
       this.categoryName = ''});

  @override
  _CategoryGarmentsState createState() => _CategoryGarmentsState();
}

class _CategoryGarmentsState extends State<CategoryGarments> {
  Future<Garment> _garmentModel;
  bool isLikeCheck = false;

  @override
  void initState() {
    _garmentModel = API_Manager().categoryGarments(categoryId: widget.categoryId,pageNumber: 1,pageSize: 50);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarr(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Center(
                child: Text(
                  widget.categoryName,
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
                              Navigator.of(context).pushNamed('details',
                                  arguments: data);
                            });
                          },
                          isLike: isLikeCheck,
                          isLikeTap: (){
                            isLikeCheck = !isLikeCheck;
                            API_Manager().isLikeGarment(data.id);
                            _garmentModel = API_Manager().getLikedGarments();
                            setState(() {

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
          ],
        ),
      ),
    );
  }
}
