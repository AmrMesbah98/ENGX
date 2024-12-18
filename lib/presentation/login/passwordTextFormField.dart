import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/values_manager.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({super.key, required this.label, required this.icon, required this.keyboardType,  required this.secure, required this.controller});


  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool secure;


  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: AppSize.s4),
      child: SizedBox(
        height: 45.h,
        child: TextFormField(
          obscureText: passwordVisible,
          decoration: InputDecoration(
            label: Text(widget.label,style:  TextStyle(color: Colors.black,fontSize: 15.sp),),
            prefixIcon: Icon(widget.icon,color: Colors.black,size: 20,),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),

            // helperText: "Password must contain special character",
            // helperStyle: TextStyle(color: Colors.green),
            suffixIcon: IconButton(
              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off , size: 20,),
              onPressed: () {
                setState(
                  () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ),
          ),
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          cursorColor: Colors.black,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }
}
