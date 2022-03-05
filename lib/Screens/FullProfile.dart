import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testo/Model/UserProfileResponse.dart';
import 'package:testo/Screens/EditProfile.dart';
import 'package:testo/Screens/Login.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Widgets/CustomNavigationBar.dart';
import 'package:testo/Widgets/appbarr.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:testo/Widgets/image_widget.dart';

final ImagePicker _picker = ImagePicker();

class FullProfile extends StatefulWidget {
  //const FullProfile({Key? key}) : super(key: key);

  static const double PlusIconSize = 20.0;

  @override
  _FullProfileState createState() => _FullProfileState();
}

class _FullProfileState extends State<FullProfile> {
  Future<UserProfileResponse> _userProfileModel;

  File image;

  Future pickImage(ImageSource source) async{
    try {
      final imageChosen = await ImagePicker().getImage(source: source);
      if (imageChosen == null)
        return;
      else {
        setState(() {
          final imageTemporary = File(imageChosen.path);
          this.image = imageTemporary;
          API_Manager().uploadImage2(imageChosen.path);
        });}
    }
    on PlatformException catch (e){
      print(e.message);
    }

  }
  @override
  void initState() {
    _userProfileModel = API_Manager().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('image: $image');
    return SafeArea(
      child: Scaffold(
        appBar: AppBarr(title: 'Profile',),
        //bottomNavigationBar: CustomNavigationBar(),
        body: SingleChildScrollView(
          child: FutureBuilder<UserProfileResponse>(
            future: _userProfileModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data.data;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(right: 15,top: 15),
                          color: Colors.purple,
                          icon: Icon(Icons.logout,size: 35,),
                            onPressed: () {
                              /*Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                  builder: (context) => Login()));*/
                            }
                        ),
                      ],
                    ),
                    /*ElevatedButton(
                      child: Text('Gallery'),
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      }
                    ),
                    ElevatedButton(
                      child: Text('Camera'),
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },),
                    image != null?
                    Image.file(image,width: 160,height: 160,) :
                    FlutterLogo(size: 160,),*/
                    _profilePicture(context),
                    _profileName(data),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _boxWithIcon(
                              data: data,
                              boxWidth: 170,
                              iconPosition: (170 / 2) - 10,
                              icon: Icons.person,
                              firstText: data.firstName == null
                                  ? 'First Name'
                                  : 'First Name :  ${data.firstName}',
                              secondText: data.lastName == null
                                  ? 'Last Name'
                                  : 'Last Name :  ${data.lastName}',
                              //textAlign: TextAlign.center,
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    choice: 1,
                                    model: data,
                                  ),
                                ));
                                setState(() {
                                  _userProfileModel =
                                      API_Manager().getUserProfile();
                                });
                              }),
                          _boxWithIcon(
                              data: data,
                              boxWidth: 170,
                              iconPosition: (170 / 2) - 10,
                              icon: Icons.location_on,
                              firstText: data.country == null
                                  ? 'Country'
                                  : '${data.country}',
                              secondText: data.city == null
                                  ? 'City'
                                  : 'City :  ${data.city}',
                              //textAlign: TextAlign.center,
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    choice: 2,
                                    model: data,
                                  ),
                                ));
                                setState(() {
                                  _userProfileModel =
                                      API_Manager().getUserProfile();
                                });
                              }),
                        ],
                      ),
                    ),
                    //////////////////////////////////////////////////////////////
                    _boxWithIconForSizes(
                        data: data,
                        boxWidth: 360,
                        iconPosition: (360 / 2) - 10,
                        //icon: Icons.home,
                        onTap: () => null
                        /*async{
                          print('tap');
                          await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => EditProfile(choice: 3,model: data,),));
                          setState(() {
                            _userProfileModel = API_Manager().getUserProfile();
                          });
                        }*/
                        ),
                    //////////////////////////////////////////////////////////////
                    _boxBodyShape(
                        shape: data.shape,
                        widget1: _bodyPicture(shape: data.shape,),
                        widget2: _bodyMeasurements(data),
                        onTap: () => null

                        /*async{
                          print('tap');
                          await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => EditProfile(choice: 4,model: data,),));
                          setState(() {
                            _userProfileModel = API_Manager().getUserProfile();
                          });
                        }*/
                        )
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

  _profilePicture(BuildContext context) {
    return GestureDetector(
        child: Center(
          child: Stack(children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  //Color(0xFFE40282)
                  // Color(0xfff36495)
                  border: Border.all(width: 4, color: Colors.blueGrey)),
              child: CircleAvatar(
                backgroundImage:
                image != null?
                FileImage(image):
                AssetImage('assets/l4.png'),


                /*NetworkImage(
                    "https://www.profilenews.com/deftageh/2021/09/16310941365-819x1024.jpg"),*/
                backgroundColor: Colors.transparent,
                radius: 100,
              ),
            ),
            Positioned(
                right: 30,
                bottom: 13,
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                      Icons.photo_camera_rounded,
                      size: 35,
                      color: Colors.white
                  ),
                )
            ),
          ]),
        ),
        onTap: () async {
          showModalBottomSheet<void>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
            ),
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  //color: Colors.lightBlueAccent,
                ),
                //color: Colors.amber,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //const Text('Modal BottomSheet'),
                    ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Gallery'),
                        onTap: () {
                          pickImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        }
                    ),
                    Opacity(
                      opacity: 0.2,
                      child: Divider(
                        height: 1,
                        color: Colors.blueGrey,
                        thickness: 1,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      }
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }
}

////////////////////////////////////////////////////////////
_flexText({@required String text, TextStyle style, TextAlign textAlign}) {
  return Flex(
    direction: Axis.horizontal,
    children: [
      Expanded(
        child: Text(
          text,
          style: style,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      )
    ],
  );
}

_positionedContainer({double boxWidth, Widget child}) {
  return Container(
      height: 85,
      width: boxWidth,
      margin: EdgeInsets.only(top: 35, bottom: 10, right: 10, left: 10),
      //padding: EdgeInsets.only(left: 5,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 4, color: Colors.blueGrey,)),
      child: child == null ? Text('Null Widget') : child);
}
////////////////////////////////////////////////////////////



_profileName(Data data) {
  data.username =data.username.replaceFirst(data.username[0], data.username[0].toUpperCase());
  int age = data.birthDate == null ? 0 : 2022 - data.birthDate.year;
  return Container(
      padding: EdgeInsets.only(bottom: 15, left: 5, right: 5),
      child: Flex(direction: Axis.horizontal, children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '${data.username}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFE723131),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  ' ${age == 0 ? '' : '($age years)'}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFE723131),
                      //fontWeight: FontWeight.bold),
                ),
              ),)
              //${age == 0 ? '' : '($age years)'}
            ],
          ),
        ),
      ]));
}

_boxWithIcon(
    {@required Data data,
    TextAlign textAlign,
    double iconPosition,
    IconData icon,
    double boxWidth,
    String firstText = '',
    String secondText = '',
    Function onTap}) {
  return GestureDetector(
    //iconPosition = (boxWidth/2)-10 to be centered
    child: Stack(
      children: [
        Positioned(
            top: 0,
            left: iconPosition,
            child: Icon(
              icon,
              size: 35,
              color: Colors.blueGrey,
            )),
        _positionedContainer(
          boxWidth: boxWidth,
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _flexText(
                    text: firstText == null ? '' : firstText,
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    textAlign: textAlign),
                _flexText(
                    text: secondText == null ? '' : secondText,
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    textAlign: textAlign),
              ],
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}

_boxWithIconForSizes(
    {@required Data data,
    double iconPosition,
    IconData icon,
    double boxWidth,
/*      String firstText = '',
      String secondText = '',*/
    Function onTap}) {
  return GestureDetector(
    //iconPosition = (boxWidth/2)-10 to be centered
    //data.sizes.
    child: Stack(
      children: [
        Positioned(
            top: 0,
            left: iconPosition,
            child: Icon(
              icon,
              size: 35,
              color: Colors.blueGrey,
            )),
        _positionedContainer(
          boxWidth: boxWidth,
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _flexText(
                    text: 'Top     Dress     Jumpsuit     Pants     Skirt',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                _flexText(
                    text: ' ${data.sizes.top}            '
                        '${data.sizes.dress}                '
                        '${data.sizes.jumpsuit}             '
                        '${data.sizes.pants.toString()}    '
                        '${data.sizes.skirt.toString()}',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
              ],
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}

_boxBodyShape(
    {Widget widget1, Widget widget2, Function onTap, @required String shape}) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(top: 35),
      child: Stack(
        children: [
          Positioned(
              child: Container(
            height: 500,
            width: 360,
            margin: EdgeInsets.only(top: 15, bottom: 10, right: 10, left: 10),
            //padding: EdgeInsets.only(t: 5,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 4, color: Colors.blueGrey)),
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget1 == null ? Text("widget1") : widget1,
                  widget2 == null ? Text("widget2") : widget2
                ],
              ),
            ),
          )),
          Positioned(
            top: 0,
            left: (360 / 5.2),
            child: Container(
              width: 240,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 4, color: Colors.blueGrey)),
              child: Text(
                shape,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //decoration: TextDecoration.combine(decorations),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFEFCEEEE)
                    //backgroundColor: Color(0xFEFE8F8F),

                    ),
              ),
            ),
          ),
        ],
      ),
    ),
    onTap: onTap,
  );
}

_bodyPicture({@required String shape}) {
  return Container(
      padding: EdgeInsets.only(top: 35, bottom: 10),
      alignment: Alignment.topLeft,
      child: Image.asset(_shapePicker(shape.toLowerCase()),width: 230,));
  /*Image.network(
          'https://static.wixstatic.com/media/c1b522_39a4f0de878c4bc89f2483937319fcad~mv2.png/v1/fill/w_203,h_686,al_c,q_85,usm_0.66_1.00_0.01/hourglass.webp'));*/
}

_bodyMeasurements(
  @required Data data,
) {
  TextStyle myStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 15);
  return Container(
    //width: size.width * 0.5,
    padding: EdgeInsets.only(right: 10),
    alignment: Alignment.topLeft,
    //color: Colors.deepPurpleAccent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Column(
            children: [
              Text('Shoulder (cm)',style: myStyle),
              SizedBox(
                height: 15,
              ),
              Text('${data.shoulderSize}',style: myStyle),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('Bust (cm)',style: myStyle),
              SizedBox(
                height: 15,
              ),
              Text('${data.bustSize}',style: myStyle),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('Waist (cm)',style: myStyle),
              SizedBox(
                height: 15,
              ),
              Text('${data.waistSize}',style: myStyle),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('Hip (cm)',style: myStyle),
              SizedBox(
                height: 15,
              ),
              Text('${data.hipSize}',style: myStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

_shapePicker(String shape){
  switch(shape){
    case 'hourglass':
      return'assets/hourglass.jpg';
    case'apple':
      return'assets/apple.jpg';
    case 'triangle':
      return'assets/pearTriangle.jpg';
    case'inverted triangle':
      return'assets/invertedTriangle.jpg';
    case'rectangle':
      return'assets/rectangle.jpg';
  }
}