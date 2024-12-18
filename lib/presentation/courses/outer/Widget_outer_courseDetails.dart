import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../price/category_price.dart';


class BuildCoursesPage extends StatelessWidget {
  const BuildCoursesPage(
      {super.key,
      required this.nameCourse,
      required this.brife,
      required this.nameInstructor,
      required this.adv1,
      required this.adv2,
      required this.adv3,
      }
      );

  final String nameCourse;
  final String brife;
  final String nameInstructor;
  final String adv1;
  final String adv2;
  final String adv3;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$nameCourse ",
                  style:  TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: AppSize.s5),

                Text(
                  textAlign: TextAlign.start,
                  brife,
                  style:  TextStyle(fontSize: 13.sp, color: Colors.black),
                ),
                const SizedBox(height: AppSize.s5),

                const SizedBox(height: AppSize.s10),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/person22.png"),
                      radius: 13,
                      backgroundColor: Colors.white54,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSize.s8),
                      child: Text(
                        nameInstructor,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: ColorManager.Black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




class BuildCoursesPageTablet extends StatelessWidget {
  const BuildCoursesPageTablet(
      {super.key,
        required this.nameCourse,
        required this.brife,
        required this.nameInstructor,
        required this.adv1,
        required this.adv2,
        required this.adv3,
      }
      );

  final String nameCourse;
  final String brife;
  final String nameInstructor;
  final String adv1;
  final String adv2;
  final String adv3;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$nameCourse ",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: AppSize.s5),

                Text(
                  textAlign: TextAlign.start,
                  brife,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: AppSize.s5),

                const SizedBox(height: AppSize.s10),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                      AssetImage("assets/images/person22.png"),
                      radius: 15,
                      backgroundColor: Colors.white54,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSize.s8),
                      child: Text(
                        nameInstructor,
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorManager.Black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}