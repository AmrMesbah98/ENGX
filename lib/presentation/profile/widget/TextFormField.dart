import 'package:flutter/material.dart';

class CustomTextCv extends StatelessWidget {
  const CustomTextCv({super.key, required this.hint, required this.controller});


 final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100]
        ),
        child: TextFormField(
          autofocus: true,

          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey)
            ),
          ),
          controller: controller,
          validator: (val)
          {
            if(val!.isEmpty)
              {
                return "PLS Enter this Field";
              }
          },
        ),
      ),
    );
  }
}
