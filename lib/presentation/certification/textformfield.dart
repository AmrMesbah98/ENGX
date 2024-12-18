import 'package:flutter/material.dart';

class CustomFieldCertification extends StatelessWidget {
  CustomFieldCertification(
      {
        super.key,
        required this.label,
        required this.controller ,
        this.maxLength = 1000,
        this.counterText = '',
        this.textCapitalization=TextCapitalization.words
      });

  String label;
  TextEditingController controller;
  int maxLength;
  String counterText;
  TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        label: Text(label),
        counterText:counterText,
        labelStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey)),
      ),
      controller: controller,

      maxLength: maxLength,

      cursorColor: Colors.black54,
      validator: (val) {
        if (val!.isEmpty) {
          return "PLs Fill This Field";
        }
      },
    );
  }
}
