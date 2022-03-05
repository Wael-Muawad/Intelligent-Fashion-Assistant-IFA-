import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:testo/Model/ApiResponse.dart';
import 'package:testo/Model/UserProfileRequest.dart';
import 'package:testo/Model/UserProfileResponse.dart';
import 'package:testo/Services/api_manager.dart';
import 'package:testo/Shared/rounded_button.dart';
import 'package:testo/Shared/rounded_input_field.dart';
import 'package:testo/Shared/rounded_password_fielld.dart';
import 'package:testo/Widgets/appbarr.dart';

class PasswordValues{
  bool obscureText = true;
  IconData visibilityIcon;
  PasswordValues(this.obscureText,this.visibilityIcon);
}


TextEditingController firstController = TextEditingController();
TextEditingController secondController = TextEditingController();
TextEditingController thirdController = TextEditingController();
/////////////////////////////////////////////////////////////////
TextEditingController bustController = TextEditingController();
TextEditingController waistController = TextEditingController();
TextEditingController highHipController = TextEditingController();
TextEditingController hipsController = TextEditingController();
/////////////////////////////////////////////////////////////////
bool wrongInput = true;
DateTime _dateTime;

bool obscureText1 = true;
bool obscureText2 = true;
IconData visibilityIcon1;
IconData visibilityIcon2;
PasswordValues passValue1 = PasswordValues(obscureText1,visibilityIcon1);
PasswordValues passValue2 = PasswordValues(obscureText2,visibilityIcon2);



class EditProfile extends StatefulWidget {
  //const EditProfile({Key? key}) : super(key: key);
  EditProfile({this.choice,this.model});
  final int choice;
  final Data model;


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error = '';
  String countryValue;
  String stateValue;
  String cityValue;
  var _service = API_Manager();

  @override
  Widget build(BuildContext context) {
    passValue1.visibilityIcon = passValue1.obscureText? Icons.visibility_off: Icons.visibility;
    passValue2.visibilityIcon = passValue2.obscureText? Icons.visibility_off: Icons.visibility;

    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarr(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _editPicker(choice: widget.choice,size: size),
              //_saveAndCancelButtons()
            ],
          ),
        ),
      ),
    );


  }

Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;

    setState(() => _dateTime = newDate);
  }

  _editPicker({@required int choice, @required Size size}) {
    switch (choice) {
      case 1:
        return _nameAndBirthDate(size);
      case 2:
        return _countryAndCity();
      case 3:
        return _editSizes();
      case 4:
        return _bodyShape(size);
      case 5:
        return _emailAndPassword();
    }
  }
//////////////////////////////////////////
  //Screens
  _nameAndBirthDate(Size size) {
    //firstController.text = (widget.model.username == null? '':widget.model.username);
    //secondController.text = (widget.model.firstName == null? '':widget.model.firstName);
    //thirdController.text = (widget.model.lastName == null? '':widget.model.lastName);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            _header('User Name'),
            _textFormFieldContainer(
              size: size,
              child: TextFormField(
                controller: firstController,
                decoration: _textFormFieldDecoration(
                  labelText: (widget.model.username == null? '':widget.model.username),
                  icon: Icons.person,
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Required *'),
                  LengthRangeValidator(
                        min: 3,
                        max: 15,
                        errorText:
                        'Length should be between 3 To 15'),
                  ]
                )

              ),
            ),

            _header('First Name'),
            _textFormFieldContainer(
              size: size,
              child: TextFormField(
                //initialValue: ,
                controller: secondController,
                decoration: _textFormFieldDecoration(
                  labelText: (widget.model.firstName == null? '':widget.model.firstName),
                  icon: Icons.person,
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Required *'),
                  LengthRangeValidator(
                      min: 3,
                      max: 15,
                      errorText:
                      'Length should be between 3 To 15'),
                ]
                )
              ),
            ),

            _header('Last Name'),
            _textFormFieldContainer(
              size: size,
              child: TextFormField(
                //initialValue: ,
                controller: thirdController,
                decoration: _textFormFieldDecoration(
                  labelText: (widget.model.lastName == null? '':widget.model.lastName),
                  icon: Icons.person,
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Required *'),
                  LengthRangeValidator(
                      min: 3,
                      max: 15,
                      errorText:
                      'Length should be between 3 To 15'),
                ]
                )
              ),
            ),

            _dateField(onPressed: () => pickDate(context),),
            _saveAndCancelButtons(
              cancelFunction: () => Navigator.pop(context),
              saveFunction: () async {
                if (formKey.currentState.validate()) {
                  print('True');
                  //Navigator.of(context).pushNamed('login');
                  UserProfileRequest editUser = UserProfileRequest(
                    id: widget.model.id,
                    email: widget.model.email,

                    username: firstController.text,
                    firstName: secondController.text,
                    lastName: thirdController.text,
                    birthDate: _dateTime == null ?
                               widget.model.birthDate :
                               _dateTime,

                    country: widget.model.country,
                    city: widget.model.city,
                    street: widget.model.street,
                    phoneNumber: widget.model.phoneNumber,
                    shoulderSize: widget.model.shoulderSize,
                    bustSize: widget.model.bustSize,
                    hipSize: widget.model.hipSize,
                    waistSize: widget.model.waistSize
                  );
                  UserProfileResponse response =
                  await _service.editUserProfile(editUser);
                  print(response.success);
                  if (response.success) {
                    Navigator.of(context).pop();
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
            )
          ],
        ),
      ),
    );
  }
  
  _countryAndCity(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        height: 450,
        child:
        Column(
          children: [
            SelectState(
              style: TextStyle(color: Colors.red),
              dropdownColor: Color(0xFFF5D6D6),
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged:(value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged:(value) {
                setState(() {
                  cityValue = value;
                });
              },

            ),

            _saveAndCancelButtons(
              cancelFunction: () => Navigator.pop(context),
                saveFunction: () async {
                  if (countryValue != null &&
                      cityValue != null &&
                      stateValue != null) {
                    //print('True');
                    //Navigator.of(context).pushNamed('login');
                    UserProfileRequest editUser = UserProfileRequest(
                        id: widget.model.id,
                        email: widget.model.email,

                        username: widget.model.username,
                        firstName: widget.model.firstName,
                        lastName: widget.model.lastName,

                        birthDate: _dateTime == null ?
                        widget.model.birthDate :
                        _dateTime,

                        country: countryValue,
                        city: cityValue,

                        street: widget.model.street,
                        phoneNumber: widget.model.phoneNumber,
                        shoulderSize: widget.model.shoulderSize,
                        bustSize: widget.model.bustSize,
                        hipSize: widget.model.hipSize,
                        waistSize: widget.model.waistSize
                    );

                    UserProfileResponse response =
                    await _service.editUserProfile(editUser);
                    print(response.success);
                    if (response.success) {
                      Navigator.pop(context);
                    } else {
                      error = response.errors[0];
                      final snackBar = SnackBar(
                        content: Text(error,textAlign: TextAlign.center,),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    setState(() {});
                  }

                  else {
                    error = 'Please fill the inputs';
                    final snackBar = SnackBar(
                      content: Text(error,textAlign: TextAlign.center,),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
            ),
          ],
        )
    );
  }

  _editSizes(){
    return Container();
  }

  _emailAndPassword(){
    return Column(
      children: [
        /*_textFormFieldContainer(
            oldData: 'Email', icon: Icons.person, controller: firstController),*/
        _passwordField(controller: secondController,passwordValues: passValue1),
        _passwordField(controller: thirdController,passwordValues: passValue2),
      ],
    );
  }

  _bodyShape(Size size){
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.15,
          child: Center(
            child: Text(
              "Hourglass",
              style: TextStyle(
                  fontSize: 50,
                  color: Color(0x88EA7A7A),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.60,
          // color: Colors.green,
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  width: size.width * 0.5,
                  child: Image.network('https://static.wixstatic.com/media/c1b522_39a4f0de878c4bc89f2483937319fcad~mv2.png/v1/fill/w_203,h_686,al_c,q_85,usm_0.66_1.00_0.01/hourglass.webp')/*Image.asset(
                          'shape.png',
                        ),*/
              ),
              Container(
                width: size.width * 0.5,
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.topLeft,
                //color: Colors.deepPurpleAccent,
                child: Column(
                  children: [
                    RoundedInputField(
                      controlar: bustController,
                      hintText: 'Bust (cm)',
                      keyboardType: TextInputType.number,
                      textFieldColor: Colors.white,
                      borderColor: Colors.red,
                    ),
                    RoundedInputField(
                      controlar: waistController,
                      hintText: 'Waist (cm)',
                      keyboardType: TextInputType.number,
                      textFieldColor: Colors.white,
                      borderColor: Colors.red,
                    ),
                    RoundedInputField(
                      controlar: highHipController,
                      hintText: 'High Hip (cm)',
                      keyboardType: TextInputType.number,
                      textFieldColor: Colors.white,
                      borderColor: Colors.red,
                    ),
                    RoundedInputField(
                      controlar: hipsController,
                      hintText: 'Hips (cm)',
                      keyboardType: TextInputType.number,
                      textFieldColor: Colors.white,
                      borderColor: Colors.red,
                    ),
                    RoundedButton(
                      text: 'Calculate',
                      btnColor: Color(0xFFFF5C58),
                      textColor: Colors.white,
                      width: size.width * 0.5,
                      marginDouble: 20,
                      press: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
//////////////////////////////////////////

_header(String title){
    return Text(
      title,
      style: TextStyle(
          fontSize: 25,
          color: Color(0xFE723131),
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
}
//////////////////////////////////////////
  //Components
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


  _passwordField({TextEditingController controller,PasswordValues passwordValues})
  {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Center(
            child: RoundedPasswordField(
              controller: controller,
              textFieldColor: Colors.white,
              lockIconColor: Colors.pinkAccent.shade100,
              borderColor: Colors.red,
              obscureText: passwordValues.obscureText,
              suffixIcon: GestureDetector(
                child: Icon(passwordValues.visibilityIcon,color: passwordValues.visibilityIcon == Icons.visibility? Colors.red:Colors.grey),
                onTap: (){
                  setState(() {
                    passwordValues.obscureText = !passwordValues.obscureText;
                  });
                },
              ),
            ),
          ),
          /*Text(wrongInput?'Wrong Input!':'',
          style: TextStyle(fontSize: 18,color: Color(0xFEF50D0D),fontWeight: FontWeight.w500),textAlign: TextAlign.center,),*/
        ],
      ),
    );
  }
  _dateField({@required Function onPressed}) {
    return Container(
      //margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            _getDateText(),
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFE723131),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child:
            ElevatedButton(
                style: _dateButtonStyle(),
                onPressed: onPressed,
                child: FittedBox(
                  child: Text(
                    'Birth Date',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ),
          /*Text(wrongInput?'Wrong Input!':'',
          style: TextStyle(fontSize: 18,color: Color(0xFEF50D0D),fontWeight: FontWeight.w500),textAlign: TextAlign.center,),*/
        ],
      ),
    );
  }

  _getDateText() {
    if (_dateTime == null) {
      return 'Select Date';
    } else {
      return '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}';
    }
  }
//////////////////////////////////////////
  //Save and Cancel Buttons
  _saveAndCancelButtons({@required Function cancelFunction,@required Function saveFunction}){
    return Container(
      margin: EdgeInsets.only(top: 30,bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: _saveButtonStyle(),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: cancelFunction
          ),
          ElevatedButton(
              style: _saveButtonStyle(),
              child: Text(
                '  Save  ',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: saveFunction
          ),
        ],
      ),
    );
  }

/////////////////////////////////
  //Buttons Style
  _saveButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Color(0xFEF58888),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.all<Color>(
        Color(0xFEFC5757),
      ),
      //fixedSize: MaterialStateProperty.all(Size.fromRadius(20)),
    );
  }

  _dateButtonStyle(){
    return ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.red, width: 1.2))),
      backgroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
      foregroundColor: MaterialStateProperty.all(Color(0xFEF58888)),
      overlayColor: MaterialStateProperty.all(
        Color(0xFEFC5757),
      ),
      minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
    );
  }
/////////////////////////////////
}












