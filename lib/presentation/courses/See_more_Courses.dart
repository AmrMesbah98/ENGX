import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/courses/seeMore_tablet/See_more_Courses_tablet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/get_courses/courses_cubit.dart';
import '../../generated/l10n.dart';

import '../../master.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'outer/Details_Courses.dart';

class ShowAllCourses extends StatefulWidget {
  const ShowAllCourses({
    super.key,
  });

  @override
  State<ShowAllCourses> createState() => _ShowAllCoursesState();
}

class _ShowAllCoursesState extends State<ShowAllCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const Master();
                }));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          flexibleSpace: Container(
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
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "AllCourses",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
        ),
        body: LayoutBuilder(
            builder: (context, constrain){
              if (constrain.maxWidth < 600){
                return BlocBuilder<GetCoursesCubit, CoursesState>(
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
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2.6,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20
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
                                              rate:
                                              GetCoursesCubit.get(context)
                                                  .coursesModelList[index]
                                                  .rate,
                                            );
                                          }));
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Card(
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
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: state.courses[index].images!,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              height: 158.h,
                                              width: AppSize.s200,
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
                                        ),
                                      ),

                                      Padding(
                                        padding:  EdgeInsets.only(bottom: 4.h,left: 4.w),
                                        child: Container(
                                          height: 30.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                                          ),
                                          child: Row(

                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 8.w),
                                                child: Text(
                                                  state.courses[index].nameCourse!,
                                                  style:  TextStyle(
                                                      fontSize: 10.sp, fontWeight: FontWeight.w600,color: Colors.white),
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                Icons.star,
                                                color: ColorManager.star,
                                                size: 17,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(right: 5.w),
                                                child: Text(
                                                    state.courses[index].rate!,
                                                    style:  TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w900,color: Colors.white)
                                                  //style: Theme.of(ctx).textTheme.bodyLarge,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                );
              }
              else if (constrain.maxWidth < 900) {
                return BlocBuilder<GetCoursesCubit, CoursesState>(
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
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: state.courses[index].images!,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              height: 180.h,
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

                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(20),bottomRight: Radius.circular(20))
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.only(bottom: 3.h,right: 4.w,left: 4.w),
                                              child: Row(

                                                children: [
                                                  Text(
                                                    state.courses[index].nameCourse!,
                                                    style:  TextStyle(
                                                        fontSize: 7.5.sp, fontWeight: FontWeight.w600,color: Colors.white),
                                                  ),
                                                  const Spacer(),
                                                  Icon(
                                                    Icons.star,
                                                    color: ColorManager.star,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                      state.courses[index].rate!,
                                                      style:  TextStyle(fontSize: 7.5.sp,fontWeight: FontWeight.w900,color: Colors.white)
                                                    //style: Theme.of(ctx).textTheme.bodyLarge,
                                                  ),
                                                ],
                                              ),
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
                );
              }

              else {
                return const Center(child: Text("Desktop"));
              }
            }
        )
    );
  }
}
