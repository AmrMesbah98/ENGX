import 'package:flutter/material.dart';

import '../../resources/values_manager.dart';

class BuildTextFormFieldCourses extends StatelessWidget {
  BuildTextFormFieldCourses({super.key, required this.label ,required this.controller});

  String label;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(AppSize.s10),
      child: TextFormField(
        maxLines: 5,
        style: const TextStyle(color: Colors.black,fontSize: 22),
        cursorColor: Colors.black,
        decoration:  InputDecoration(
          label:  Text(label),
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black54)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.redAccent)
          ),
        ),
        keyboardType: TextInputType.text,
        controller: controller,
        validator: (value)
        {
          if(value == null)
            {
              return "Must Fill This field";
            }
        },
      ),
    );
  }
}