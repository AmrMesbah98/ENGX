import 'package:flutter/material.dart';

class CustomTextFormFieldNew extends StatelessWidget {
  CustomTextFormFieldNew({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.colorBorder = Colors.pink,
    this.maxLength = 1000,
    required this.controller,
    required this.keyboardType,
    required this.validateText,
    required this.width,
    required this.height,
    required this.color,
    required this.icon,
    this.maxLines = 1,
  });

  double width;
  double height;
  String hintText;
  bool obscureText;
  TextEditingController controller;
  Color colorBorder;
  TextInputType keyboardType;
  int maxLength;
  int maxLines;
  String validateText;
  Color color;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 13),
          counterText: '',
          prefixIcon: icon,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: Colors.black,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
        ),
        cursorColor: Colors.black54,
        maxLength: maxLength,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        validator: (val) {
          if (val!.isEmpty) {
            return validateText;
          }
        },
        maxLines: maxLines,
      ),
    );
  }
}
