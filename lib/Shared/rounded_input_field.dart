import 'package:flutter/material.dart';
import 'package:testo/Shared/text_field_container.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextEditingController controlar;
  final Color iconColor,textFieldColor, borderColor;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.controlar,
    this.iconColor,
    this.textFieldColor,
    this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: textFieldColor,
      borderColor: borderColor,
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controlar,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
