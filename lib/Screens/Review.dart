import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testo/Model/FeedbacksResponse.dart';
import 'package:testo/Model/RateStoreRequest.dart';
import 'package:testo/Model/StoreDetailsResponse.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/appbarr.dart';



class Review extends StatefulWidget {
  //const Review({Key? key}) : super(key: key);
  Data store;
  int storeId;
  Review(
      this.store,
      this.storeId,
      );

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController commentController = TextEditingController();
  Future<FeedbacksResponse> _storeModel;
  RateStoreRequest rateStore = RateStoreRequest();
  var rank = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeModel = API_Manager().getStoreFeedback(storeId: widget.storeId);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarr(),
        body: SingleChildScrollView(
          child: Column(
            children: [

              /*IconButton(
                  onPressed: onPressed,
                  icon: icon),*/
              _ratingAndSomething(),
              Container(
                height: size.height * 0.25,
                //color: Colors.blueGrey,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  subtitle: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                          onPressed: () async{
                            rateStore.id = widget.store.id;
                            rateStore.body = commentController.text;
                            DisplayMyDialog(
                                context: context,
                                MyTitle: 'Submit Rate ?',
                                no: 'No',
                                yes: 'Yes'
                            );
                            print('Post');
                          },
                          child: Text('Post',style: TextStyle(fontSize: 25),))),
                  title: Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.17,
                        //minHeight: size.height * 0.17,
                      ),
                      child: TextField(
                        //textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        controller: commentController,
                          decoration: InputDecoration(
                            //labelText: 'Label text',
                              //contentPadding: EdgeInsets.only(bottom: 100),
                              border: OutlineInputBorder (),
                              //contentPadding: EdgeInsets.only(bottom: 100)
                          )
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: 400,
                  //color: Color(0xfff3d2de),
                  child: FutureBuilder<FeedbacksResponse>(
                    future: _storeModel,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data.data[index];
                            //data.
                            return Card(
                              elevation: 1,
                              shadowColor: Colors.pinkAccent,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.pink,
                                  radius: 25,
                                ),
                                trailing: _starNormal2(r: data.rate),
                                title: Text('\n${data.userName}',),
                                subtitle: Text('\n${data.body}'),
                                isThreeLine: true,
                                selectedColor: Colors.pink,
                              ),
                            );
                          },);
                      }
                      else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _ratingAndSomething() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.all(15),
          child: Text(
            'Rate our Store',
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
        ),
        Container(margin: EdgeInsets.only(right: 15), child: _starsWithSetState())
      ],
    );
  }

  _starsWithSetState() {
    rateStore.storeId = widget.store.id;
    if(rank == 0){
      rateStore.rate = 0;
    }
    return Row(
      children: [
        GestureDetector(
            onTap:() {
              rateStore.rate = 1;
              rank = 1;
              setState(() {});
            },
            child: Icon(
                (rank >=1 )?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            onTap:() {
              rateStore.rate = 2;
              rank = 2;
              setState(() {});
            },
            child: Icon(
                rank >=2 ? Icons.star : Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            onTap:() {
              rateStore.rate = 3;
              rank = 3;
              setState(() {});
            },
            child: Icon(
                rank >=3 ? Icons.star : Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            onTap:() {
              rateStore.rate = 4;
              rank = 4;
              setState(() {});
            },
            child: Icon(
                rank >=4 ?  Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
        GestureDetector(
            onTap:() {
              rateStore.rate = 5;
              rank = 5;
              setState(() {});
            },
            child: Icon(
                rank >=5 ? Icons.star: Icons.star_border_outlined,
                size: 23,
                color: Color(0xfee09423)
            )),
      ],
    );
  }
  _starNormal(){
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
  _starNormal2({int r}){
    return Container(
      width: 120,
      //height: 30,
      //color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
              child: Icon(
                  (r >=1 )?  Icons.star: Icons.star_border_outlined,
                  size: 23,
                  color: Color(0xfee09423)
              )),
          GestureDetector(
              child: Icon(
                  (r >=2 )?  Icons.star: Icons.star_border_outlined,
                  size: 23,
                  color: Color(0xfee09423)
              )),
          GestureDetector(
              child: Icon(
                  (r >=3 )?  Icons.star: Icons.star_border_outlined,
                  size: 23,
                  color: Color(0xfee09423)
              )),
          GestureDetector(
              child: Icon(
                  (r >=4 )?  Icons.star: Icons.star_border_outlined,
                  size: 23,
                  color: Color(0xfee09423)
              )),
          GestureDetector(
              child: Icon(
                  (r >=5 )?  Icons.star: Icons.star_border_outlined,
                  size: 23,
                  color: Color(0xfee09423)
              )),
        ],
      ),
    );
  }
  void DisplayMyDialog(
      {BuildContext context,
        String MyTitle,
        //Widget MyContent,
        String yes,
        String no})
  {
    var dialog = AlertDialog(
      title: Text(MyTitle,style: TextStyle(color: Color(0xFF1C92C5),),),
      content: _starNormal(),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all(Color(0xfff36495),),
          ),
          child: Text(yes,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
          onPressed: () async {
            //BasketData.forEach((element) async { await dbHelper.deleteBasket(element['id']); });

            Navigator.of(context).pop();
            API_Manager().rateStore(rateStore);
            _storeModel = API_Manager().getStoreFeedback(storeId: widget.storeId);
            setState(() async {

            });
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all(Color(0xfff36495),),
          ),
          child: Text(no,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {

            });
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
