import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/values_manager.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.icon,
    required this.keyboardType,
    required this.controller,
    required this.secure,
    required this.maxLine,
    this.colorIcon = Colors.black,
    this.maxDigit = 200,

  });

  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool secure;
  final int maxLine;
  final int maxDigit;
  final Color colorIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 16.w, vertical: AppSize.s7),

      child: Container(

        width: MediaQuery.of(context).size.width  ,
        child: SizedBox(
          height: 45.h,
          child: TextFormField(
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLength: widget.maxDigit,
            decoration: InputDecoration(
              counterText: "",
              label: Text(
                widget.label,
                style:  TextStyle(color: widget.colorIcon),
              ),
              labelStyle:  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500,),
              prefixIcon: Icon(
                widget.icon,
                color: widget.colorIcon,
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(

                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            cursorColor: Colors.black,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            obscureText: widget.secure,
            maxLines: widget.maxLine,
          ),
        ),
      ),
    );
  }
}
