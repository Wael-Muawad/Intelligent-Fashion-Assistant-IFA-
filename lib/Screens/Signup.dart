import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:testo/BottomNavBar.dart';
import 'package:testo/Model/ApiResponse.dart';
import 'package:testo/Model/User.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Shared/SnackBarPage.dart';
import 'package:testo/Shared/rounded_button.dart';
import 'package:testo/Shared/rounded_input_field.dart';
import 'package:testo/Shared/rounded_password_fielld.dart';
import 'package:testo/Widgets/CustomNavigationBar.dart';
import 'package:testo/Widgets/appbarr.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //bottomNavigationBar: CustomNavigationBar(),
      //appBar: AppBarr(),
      body: SingleChildScrollView(
    child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            /*ElevatedButton(onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed('login');
            }, child: Text('login')),*/
            Image.asset('assets/l3.png',),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,bottom: 35),
              child: Image.asset('assets/l10.png',),
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [

                  _textFormFieldContainer(
                      size: size,
                      child: TextFormField(
                          controller: userController,
                          decoration: _textFormFieldDecoration(
                            labelText: 'User Name',
                            icon: Icons.person,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Required *'),
                            LengthRangeValidator(
                                min: 3,
                                max: 15,
                                errorText:
                                    'Length should be between 3 To 15'),
                          ]))),
                  _textFormFieldContainer(
                    size: size,
                    child: TextFormField(
                        controller: emailController,
                        decoration: _textFormFieldDecoration(
                          labelText: 'Email',
                          icon: Icons.email,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required *'),
                          EmailValidator(errorText: 'Incorrect Email'),
                          PatternValidator(emailPattern,
                              errorText: 'Wrong Email Pattern')
                        ])),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: _textFormFieldContainer(
                        size: size,
                        child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: _textFormFieldDecoration(
                              labelText: 'Password',
                              icon: Icons.lock,
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required *'),
                              LengthRangeValidator(
                                  min: 8,
                                  max: 155,
                                  errorText:
                                  'Length should be between 8 To 155'),
                              PatternValidator(passwordPattern,
                                  errorText:
                                  'Should have at least one number one capital and small character')
                            ]))),
                  ),
                  Container(
                    //margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(bottom: 7),
                    child: Center(
                        child: TextButton(
                          child: RichText(
                            text: TextSpan(
                              text: 'already have an account? ',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
                              children:[
                                TextSpan(text: 'Sign in', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.pink,),
                                ),
                                //TextSpan(text: ' world!'),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('login');
                          },
                        )
                    ),
                  ),
                  RoundedButton(
                    text: 'Create Account',
                    btnColor: Color(0xfff36495),
                    textColor: Colors.white,
                    width: size.width * 0.7,
                    marginDouble: 0,
                    press: () async {
                      if (formKey.currentState.validate()) {
                        print('True');
                        //Navigator.of(context).pushNamed('login');
                        User newUser = User(
                          firstName: 'First Name',
                          lastName: 'Last Name',
                          username: userController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          birthDate: DateTime.now(),
                          country: "Country",
                          city: 'City',
                          street: 'Street',
                          houseNumber: '',
                          phoneNumber: 'Phone Number',
                        );

                        ApiResponse response =
                            await _service.addCustomer(newUser);
                        print(response.success);
                        if (response.success) {
                          Navigator.of(context)
                              .pushReplacementNamed('login');
                        } else {
                          error = response.errors[0];
                          final snackBar = SnackBar(
                            content: Text(error,textAlign: TextAlign.center,),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        setState(() {});
                      } else {
                        error = 'Please fill inputs correctly';
                        final snackBar = SnackBar(
                          content: Text(error,textAlign: TextAlign.center,),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  Container(
                    height: 100,

                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

_textFormFieldContainer({Size size, @required Widget child}) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
    labelStyle: TextStyle(color: Colors.black),
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
_textFormFieldContainer(
                          size: size,
                          child: TextFormField(
                              controller: firstNameController,
                              decoration: _textFormFieldDecoration(
                                labelText: 'First Name',
                                icon: Icons.person,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
                                LengthRangeValidator(
                                    min: 3,
                                    max: 10,
                                    errorText:
                                        'Length should be between 3 To 10')
                              ]))),
                      _textFormFieldContainer(
                          size: size,
                          child: TextFormField(
                              controller: lastNameController,
                              decoration: _textFormFieldDecoration(
                                labelText: 'Last Name',
                                icon: Icons.person,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required *'),
                                LengthRangeValidator(
                                    min: 3,
                                    max: 10,
                                    errorText:
                                        'Length should be between 3 To 10')
                              ]))),
 */


/*
SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,

          child: Column(
            children: [
              //SizedBox(height: 50,),
              Container(
                margin: EdgeInsets.only(top: 25,bottom: 25),
                child: Center(
                  child: Text('Log In',style: TextStyle(fontSize: 30,color: Color(
                      0xFE4D1010),fontWeight: FontWeight.bold),),
                ),
              ),
              Container(
                width: size.width-50,
                height: size.height*0.2,
                margin: EdgeInsets.only(bottom: 20),
                color: Color(0xFFF69E9E),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Image.asset('measurementPic.png'),
                    //Image.asset('ifaTxt.png'),
                  ],),
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
                          decoration: _textFormFieldDecoration(
                            labelText: 'Email',
                            icon: Icons.email,
                          ),
                          validator: RequiredValidator(errorText: 'Required *'),),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: _textFormFieldContainer(
                          size: size,
                          child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: _textFormFieldDecoration(
                                labelText: 'Password',
                                icon: Icons.lock,
                              ),
                              validator: RequiredValidator(errorText: 'Required *'),)),
                    ),
                    RoundedButton(
                      text: 'Login',
                      btnColor: Color(0xFFFF5C58),
                      textColor: Colors.white,
                      width: size.width * 0.7,
                      marginDouble: 0,
                      press: () async {
                        if (formKey.currentState.validate()) {
                          print('True');
                          //Navigator.of(context).pushNamed('login');
                          User newUser = User(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            username: userController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            birthDate: DateTime.now(),
                            country: "any Country",
                            city: 'any City',
                            street: 'any Street',
                            houseNumber: 'anything',
                            phoneNumber: '01234',
                          );

                          ApiResponse response =
                          await _service.addCustomer(newUser);
                          print(response.success);
                          if (response.success) {
                            Navigator.of(context)
                                .pushReplacementNamed('login');
                          } else {
                            error = response.errors[0];
                            final snackBar = SnackBar(
                              content: Text(error,textAlign: TextAlign.center,),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          setState(() {});
                        } else {
                          error = 'Please fill inputs correctly';
                          final snackBar = SnackBar(
                            content: Text(error,textAlign: TextAlign.center,),
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
    ));
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
      color: Colors.pinkAccent.shade100,
    ),
    labelText: labelText,
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
 */
