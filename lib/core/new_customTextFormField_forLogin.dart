
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class NewCustomTextFormFieldForLogin extends StatelessWidget {
  NewCustomTextFormFieldForLogin({

    super.key,
    required this.label,
    this.hint,
    this.labelStyle,
    this.hintStyle,
    this.prefixIcon,
    this.keyboardType,
    this.obsocure = false,
    this.validator,
    required this.controller,
    this.color,
    this.suffixIcon,
    this.suffixPressed,
    this.maxLine = 1,
    this.readOnly=false,
    this.enable=true,
    this.textCapitalization=TextCapitalization.words

  });


  final String label;
  String? hint;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  Icon? prefixIcon;
  IconButton? suffixIcon;
  VoidCallback? suffixPressed;
  TextInputType? keyboardType;
  bool obsocure ;
  String? validator;
  final TextEditingController controller;
  dynamic color;
  int maxLine;
  final bool readOnly;
  final bool enable;
  TextCapitalization textCapitalization;





  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(height: .5),
      textCapitalization: textCapitalization,
      maxLines: maxLine,
      decoration: InputDecoration(
        fillColor: const Color(0xffECECEC),
        filled: true,
        label: Text(label),
        hintText: hint,
        labelStyle:  TextStyle(fontSize: 15.sp,color: Colors.grey),
        hintStyle:  TextStyle(fontSize: 15.sp,color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixStyle: const TextStyle(color: Colors.black),
        suffixIcon: suffixIcon ,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          //background TextFormField ====>>> white
          borderSide: const BorderSide(color: Color(0xffECECEC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  const BorderSide(color: Color(0xffECECEC)),
        ),

      ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obsocure,
      readOnly: readOnly,
      enabled: enable,

      validator: (value){
        if(value!.isEmpty){
          return validator;
        }
      },
    );
  }
}