import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model.dart';
import '../widget/item_one_click.dart';

class OneClick extends StatelessWidget {
  const OneClick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      height: 103.h,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ItemOfOneClick(
              name: items[index].name,
              icon: items[index].icons,
              screen: items[index].screen,
            );
          }),
    );
  }
}
