import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  TextEditingController textController;
  bool obscure;
  CustomTextField({
    Key? key,
    required this.hintText,
    required this.textController,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: textController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
