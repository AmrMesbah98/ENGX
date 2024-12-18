import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextFieldDashBoard({
  required String label,
  required String validateText,
  required bool secure,
  required TextEditingController controller,
  //String? Function(String?)? validator,
  Widget? suffixIcon,
  Widget? prefixIcon,
  IconData? iconText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            iconText,
            color: Colors.white,
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      SizedBox(height: 8.h),
      TextFormField(
        obscureText: secure,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h, // Adjust this value to increase/decrease height
            horizontal: 12.w,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validateText;
          }
          return null;
        },
      ),
    ],
  );
}
