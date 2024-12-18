import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Row labelShortsSection() {
  return Row(
    children: [
      Text("Shorts",style: TextStyle(fontSize: 16.sp)),
      const Spacer(),
      /*
            Text("See All",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),)

       */
    ],
  );
}