import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm({
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
    required this.colorsFill,
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
  Color colorsFill;
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
          contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 12.h),
          counterText: '',
          prefixIcon: icon,
          hintText: hintText,
          filled: true,
          fillColor: colorsFill,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent)),
        ),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
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
