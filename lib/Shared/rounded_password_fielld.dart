import 'package:flutter/material.dart';
import 'package:testo/Shared/text_field_container.dart';



class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Color lockIconColor,textFieldColor,borderColor;
  final bool obscureText;
  final Widget suffixIcon;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.lockIconColor,
    this.textFieldColor,
    this.borderColor,
    this.obscureText = true,
    this.suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: textFieldColor,
      borderColor: borderColor,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: lockIconColor,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
