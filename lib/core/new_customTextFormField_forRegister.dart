
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class NewCustomTextFormFieldForRegister extends StatelessWidget {
  NewCustomTextFormFieldForRegister({

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
    this.textCapitalization=TextCapitalization.words,
    this.maxLength = 1000,
    this.counterText = '',
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
  int maxLength;
  String counterText;





  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        textCapitalization: textCapitalization,
        maxLines: maxLine,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText:counterText,
          label: Text(label),
          hintText: hint,
          labelStyle:  TextStyle(fontSize: 13.sp,color: const Color(0xff46454a)),
          hintStyle:  TextStyle(fontSize: 12.sp,color: const Color(0xff46454a)),
          prefixIcon: prefixIcon,
          prefixStyle: const TextStyle(color: Colors.black),
          suffixIcon: suffixIcon ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            //background TextFormField ====>>> white
            borderSide: const BorderSide(color: Color(0xffffffff)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:  const BorderSide(color: Color(0xffffffff)),
          ),

        ),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obsocure,
        readOnly: readOnly,
        enabled: enable,
        maxLength: maxLength,

        validator: (value){
          if(value!.isEmpty){
            return validator;
          }
        },
      ),
    );
  }
}