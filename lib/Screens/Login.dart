import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testo/BottomNavBar.dart';
import 'package:testo/Model/LoginResponse.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Shared/rounded_button.dart';
import 'package:testo/Shared/rounded_input_field.dart';
import 'package:testo/Shared/rounded_password_fielld.dart';
import 'package:testo/Widgets/CustomNavigationBar.dart';
import 'package:testo/Widgets/appbarr.dart';

TextEditingController userController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  //
  String passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _service = API_Manager();
  String error = '';

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    IconData visibilityIcon =
        obscureText ? Icons.visibility_off : Icons.visibility;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBarr(),
      //bottomNavigationBar: CustomNavigationBar(),
      body: SingleChildScrollView(
    child: Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Image(image: NetworkImage('http://10.0.2.2:5001/Images/logo1.png',scale: 20))
              //logo1.png
              Image.asset('assets/l3.png',),
              Padding(
                padding: const EdgeInsets.only(right: 15,left: 15,bottom: 35),
                child: Image.asset('assets/l10.png',),
              ),
            ],
          ),
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                _textFormFieldContainer(
                  size: size,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _textFormFieldDecoration(
                      labelText: 'Email',
                      icon: Icons.email,
                    ),
                    validator: RequiredValidator(errorText: 'Required *'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: _textFormFieldContainer(
                      size: size,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: _textFormFieldDecoration(
                          labelText: 'Password',
                          icon: Icons.lock,
                        ),
                        validator:
                            RequiredValidator(errorText: 'Required *'),
                      )),
                ),

                Container(
                  child: Center(
                    child: TextButton(
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
                          children:[
                            TextSpan(text: 'Create One', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.pink,),
                            ),
                            //TextSpan(text: ' world!'),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('signup');
                      },
                    )
                    //Text('Don\'t have an account? Create One'),
                  ),
                ),
                RoundedButton(
                  text: 'Login',
                  //#E0C3C6
                  //#E7C0B3
                  //#fecda4
                  btnColor: Color(0xfff36495),
                  textColor: Colors.white,
                  width: size.width * 0.7,
                  marginDouble: 20,
                  press: () async {
                    if (formKey.currentState.validate()) {
                      String email = emailController.text;
                      String password = passwordController.text;
                      LoginResponse loginResponse =
                          await _service.LoginToken(
                              email: email, password: password);

                      print(loginResponse.success);
                      if (loginResponse.success) {
                        Map<String, dynamic> decodedToken =
                            JwtDecoder.decode(loginResponse.data);
                        if (decodedToken['role'] != 'Customer') {
                          error = 'Invalid Login';
                          final snackBar = SnackBar(
                            content: Text(
                              error,
                              textAlign: TextAlign.center,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (prefs.containsKey(email)) {
                            Navigator.of(context)
                                .pushReplacementNamed('BottomNavBar');
                          } else {
                            Navigator.of(context)
                                .pushReplacementNamed('profile');
                          }
                        }
                      } else {
                        error = loginResponse.errors[0];
                        final snackBar = SnackBar(
                          content: Text(
                            error,
                            textAlign: TextAlign.center,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                      setState(() {});
                    } else {
                      error = 'Please fill inputs correctly';
                      final snackBar = SnackBar(
                        content: Text(
                          error,
                          textAlign: TextAlign.center,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
                //SnackBarPage(errorText: "test",)
              ],
            ),
          ),
        ],
      ),
    ),
      ),
    );
  }
}

_textFormFieldContainer({Size size, @required Widget child}) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      width: size.width * 0.9,
      child: child == null ? Container() : child);
}

_textFormFieldDecoration({String labelText, IconData icon}) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: Colors.blueGrey,
    ),
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.black,),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Color(0xFFE40282),
        )),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Color(0xFFE40282),
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

/*
RoundedButton(
                text: 'Login',
                btnColor: Color(0xFFFF5C58),
                textColor: Colors.white,
                width: size.width * 0.7,
                marginDouble: 20,
                press: () async{

                  String email = userController.text;
                  String password = passwordController.text;
                  LoginResponse loginResponse = await _service.LoginToken(email: email, password: password);

                  if(loginResponse.success)
                    Navigator.of(context).pushReplacementNamed('search');
                  else{
                    error = loginResponse.errors[0];
                    setState(() {

                    });
                  }
                } ,
              ),
 */
