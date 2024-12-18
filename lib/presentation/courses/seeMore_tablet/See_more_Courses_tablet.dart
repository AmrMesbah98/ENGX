import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/courses/outer/Tablet/Details_Courses_tablet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_courses/courses_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../master.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../outer/Details_Courses.dart';


class ShowAllCoursesTablet extends StatefulWidget {
  const ShowAllCoursesTablet({
    super.key,
  });

  @override
  State<ShowAllCoursesTablet> createState() => _ShowAllCoursesTabletState();
}

class _ShowAllCoursesTabletState extends State<ShowAllCoursesTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: BlocBuilder<GetCoursesCubit, CoursesState>(
          builder: (context, state) {
            if (state is GetCoursesFailure) {
              return Text(state.errMessage);
            } else if (state is GetCoursesSuccess) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 2.5 / 2.8,
                          crossAxisSpacing: 40,
                          mainAxisSpacing: 40
                      ),
                      itemCount: state.courses.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("all courses")
                                .doc(
                              state.courses[index].id!,
                            )
                                .collection("RateOfUser")
                                .doc(FirebaseAuth
                                .instance.currentUser!.uid)
                                .get()
                                .then((value) {
                              print(
                                  "my rate is one two ${constantvar.rateUserCourses}");
                              constantvar.rateUserCourses =
                                  value.data()?["oldRate"] ?? 0;
                              print(
                                  "my rate is ${constantvar.rateUserCourses}");
                            }).then((value) {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) {
                                    return DetailsCourses(
                                      coursesModel:
                                      constantvar.coursesModel = state.courses[index],
                                      id: GetCoursesCubit.get(context)
                                          .coursesModelList[index]
                                          .id,
                                      rate: GetCoursesCubit.get(context)
                                          .coursesModelList[index]
                                          .rate,
                                    );
                                  }));
                            });
                          },

                          child: Card(
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFe5e5e5),
                                        Color(0xFFFFFFFF),
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: state.courses[index].images!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                      height: 120.h,
                                      width: 210.w,
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.cloud_off_outlined),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade400,
                                            highlightColor: Colors.grey.shade200,
                                            child: const SizedBox(
                                              width: 200,
                                              height: 200,
                                            ),
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.015),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
                                    child: Row(

                                      children: [
                                        Text(
                                          state.courses[index].nameCourse!,
                                          style:  TextStyle(
                                              fontSize: 7.5.sp, fontWeight: FontWeight.w600),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.star,
                                          color: ColorManager.star,
                                          size: 17,
                                        ),
                                        Text(
                                            state.courses[index].rate!,
                                            style:  TextStyle(fontSize: 7.5.sp,fontWeight: FontWeight.w900)
                                          //style: Theme.of(ctx).textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  )

                                  /*
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSize.s4),
                                    child: Center(
                                      child: Text(
                                        state.courses[index].nameCourse!,
                                        //  DummyAllCourses[index].nameCourse,
                                        style: const TextStyle(
                                            fontSize: AppSize.s15,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  )

                                   */
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        )
    );
  }
}
