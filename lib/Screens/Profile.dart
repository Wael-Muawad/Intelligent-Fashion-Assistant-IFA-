import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testo/Model/BodyShapeRequest.dart';
import 'package:testo/Model/BodyShapeResponse.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Shared/rounded_button.dart';
import 'package:testo/Shared/rounded_input_field.dart';
import 'package:testo/Widgets/appbarr.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _service = API_Manager();
  String shapeTitle = 'Calculate Body Shape';
  String shapePic = 'h';
  bool correct = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AppBarr(),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.15,
                    child: Center(
                      child: Text(
                        shapeTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0x88EA7A7A),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    //height: size.height * 0.75,
                    // color: Colors.green,
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            width: size.width * 0.45,
                            height: size.height * 0.75,
                            child: Image.asset(_shapePicker(shapePic),)
                          /*Image.network(
                                'https://static.wixstatic.com/media/c1b522_39a4f0de878c4bc89f2483937319fcad~mv2.png/v1/fill/w_203,h_686,al_c,q_85,usm_0.66_1.00_0.01/hourglass.webp')*/ /*Image.asset(
                            'shape.png',
                          ),*/
                            ),
                        Container(
                          width: size.width * 0.55,
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.topLeft,
                          //color: Colors.deepPurpleAccent,
                          child: Column(
                            children: [
                              Form(
                                key: formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  children: [
                                    _textFormFieldContainer(
                                      size: size,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: shoulderController,
                                        decoration: _textFormFieldDecoration(
                                          labelText: 'Shoulder (cm)',
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required *'),
                                          /*RangeValidator(
                                              min: 70,
                                              max: 300,
                                              errorText: 'Minimum size is 70 and max is 200')*/
                                        ]),
                                      ),
                                    ),
                                    _textFormFieldContainer(
                                      size: size,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: bustController,
                                        decoration: _textFormFieldDecoration(
                                          labelText: 'Bust (cm)',
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required *'),
                                          /*RangeValidator(
                                              min: 0,
                                              max: 300,
                                              errorText: 'Minimum size is 70 and max is 200')*/
                                        ]),
                                      ),
                                    ),
                                    _textFormFieldContainer(
                                      size: size,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: waistController,
                                        decoration: _textFormFieldDecoration(
                                          labelText: 'Waist (cm)',
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required *'),
                                          /*RangeValidator(
                                              min: 0,
                                              max: 300,
                                              errorText: 'Minimum size is 70 and max is 200')*/
                                        ]),
                                      ),
                                    ),
                                    _textFormFieldContainer(
                                      size: size,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: hipController,
                                        decoration: _textFormFieldDecoration(
                                          labelText: 'Hip (cm)',
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required *'),
                                          /*RangeValidator(
                                              min: 0,
                                              max: 200,
                                              errorText: 'Minimum size is 70 and max is 200')*/
                                        ]),
                                      ),
                                    ),

                                    correct ?RoundedButton(
                                      text: 'Next',
                                      btnColor: Color(0xFFE40282),
                                      textColor: Colors.white,
                                      width: size.width * 0.5,
                                      marginDouble: 20,
                                      press: () async {
                                        Navigator.of(context)
                                            .pushReplacementNamed('BottomNavBar');
                                      },
                                    ):
                                    RoundedButton(
                                      text: 'Calculate',
                                      //
                                      btnColor: Color(0xfff36495),
                                      textColor: Colors.white,
                                      width: size.width * 0.5,
                                      marginDouble: 20,
                                      press: () async {
                                        if (formKey.currentState.validate()) {
                                          BodyShapeRequest model =
                                          BodyShapeRequest(
                                            shoulderSize: double.parse(
                                                shoulderController.text),
                                            bustSize:
                                            double.parse(bustController.text),
                                            waistSize: double.parse(
                                                waistController.text),
                                            hipSize:
                                            double.parse(hipController.text),
                                          );

                                          BodyShapeResponse bodyShapeResponse =
                                          await _service.CalculateBodyShape(
                                              model);

                                          if (bodyShapeResponse.success) {
                                            shapeTitle = bodyShapeResponse.data.shape;
                                            shapePic = bodyShapeResponse.data.shape;
                                            correct = true;
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString(bodyShapeResponse.data.email, bodyShapeResponse.data.shape);
                                            setState(() {

                                            });
                                          } else {
                                            error = bodyShapeResponse.errors[0];
                                            final snackBar = SnackBar(
                                              content: Text(
                                                error,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        } else {
                                          error = 'Please fill inputs correctly';
                                          final snackBar = SnackBar(
                                            content: Text(
                                              error,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                    )
                                    //SnackBarPage(errorText: "test",)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

_textFormFieldContainer({Size size, @required Widget child}) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      width: size.width,
      child: child == null ? Container() : child);
}

_textFormFieldDecoration({String labelText, IconData icon}) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: Colors.pinkAccent.shade100,
    ),
    label: Text(labelText,textAlign: TextAlign.start,),
    labelStyle: TextStyle(color: Colors.red),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red,
        )),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );
}

_shapePicker(String shape){
  shape = shape != null? shape.toLowerCase():shape;
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
    default:
      return 'assets/shape.png';
  }
}