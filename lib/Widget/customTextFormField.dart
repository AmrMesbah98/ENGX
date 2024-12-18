
import 'package:flutter/material.dart';

import '../presentation/resources/color_manager.dart';
import '../presentation/resources/values_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.width = 0.5,
    this.height = 0.5,
    this.title = 'Title',
    this.hint = 'Hint',
    this.enable = false,
    required this.validate ,
    this.keyboard = TextInputType.name,
    this.line = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final double width;
  final double height;
  final String title;
  final String hint;
  final bool enable;
  final dynamic validate;
  final TextInputType keyboard;
  final int line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: height,
        child: TextFormField(
          cursorColor: Colors.black54,
          onTapOutside: (event){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: validate ,
          style: const TextStyle(fontSize: 15,color: Colors.black),
          controller: controller,
          maxLines: line,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontSize: AppSize.s24,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),

            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            disabledBorder: OutlineInputBorder(),

          ),
          enabled: enable,
          keyboardType: keyboard,
        ),
      ),
    );
  }
}
