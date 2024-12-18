import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/courses/seeMore_tablet/See_more_Courses_tablet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/Free_Courses/free_courses_cubit.dart';
import '../../bloc/get_courses/courses_cubit.dart';
import '../../generated/l10n.dart';

import '../../master.dart';
import '../../model/free_courses_model/free_courses_model.dart';
import '../../model/free_courses_model/inner_free_courses_model.dart';
import '../../shared/components/components.dart';
import '../Free_Courses/innerFreeCouses.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'outer/Details_Courses.dart';

class ShowAllFreeCourses extends StatefulWidget {
  const ShowAllFreeCourses({
    super.key,
  });

  @override
  State<ShowAllFreeCourses> createState() => _ShowAllFreeCoursesState();
}

class _ShowAllFreeCoursesState extends State<ShowAllFreeCourses> {
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
            "Free Courses",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
        ),
        body: LayoutBuilder(
            builder: (context, constrain){
              if (constrain.maxWidth < 600){
                return BlocBuilder<FreeCoursesCubit, FreeCoursesState>(
                  builder: (context, state) {
                    if (state is GetFreeCoursesError) {
                      return Text("We have Error");
                    }
                    else if (state is GetFreeCoursesSuccess) {
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
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2.8,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20
                              ),
                              itemCount: FreeCoursesCubit.get(context).freeCoursesList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(

                                  onTap: () {
                                    List<FreeCoursesModel> freeCoursesList = [];
                                    List <InnerFreeCoursesModel> innerFreeCoursesList = [];



                                    FirebaseFirestore.instance
                                        .collection("Free Courses")
                                        .doc(
                                      FreeCoursesCubit.get(context).freeCoursesList[index].id!,
                                    )
                                        .collection("RateOfUser")
                                        .doc(FirebaseAuth
                                        .instance.currentUser!.uid)
                                        .get()
                                        .then((value) {
                                      print(
                                          "my rate is one two ${constantvar.rateUserFreeCourses}");
                                      constantvar.rateUserFreeCourses =
                                          value.data()?["oldRate"] ?? 0;
                                      print(
                                          "my rate is ${constantvar.rateUserFreeCourses}");
                                    }).then((value) {
                                      constantvar.idFreeCoursesCategory = FreeCoursesCubit.get(context)
                                          .freeCoursesList[index]
                                          .id!;

                                      FirebaseFirestore.instance
                                          .collection("Free Courses")
                                          .doc(constantvar.idFreeCoursesCategory)
                                          .collection("innerCollection")
                                          .get()
                                          .then((value) {
                                        innerFreeCoursesList = [];

                                        for (var doc in value.docs) {
                                          innerFreeCoursesList.add(InnerFreeCoursesModel.fromJson(doc));
                                        }


                                      })
                                          .then((value) {
                                        navigateTo(
                                            context,
                                            InnerFreeCoursesPage(
                                              innerFreeCoursesModel: innerFreeCoursesList,
                                              id: constantvar.idFreeCoursesCategory!,
                                              freeCoursesModel:  constantvar.freeCoursesModel = FreeCoursesCubit.get(context).freeCoursesList[index],

                                            ));

                                        print("inner free courses success >>>>> ");
                                      }
                                      );
                                    });




                                    // FreeCoursesCubit.get(context)
                                    //     .getSecondCategory(context);




                                  },


                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      // image
                                      Card(
                                        shadowColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
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
                                              imageUrl: FreeCoursesCubit.get(context).freeCoursesList[index].image!,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              height: 170.h,
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
                                      // data
                                      Padding(
                                        padding:  EdgeInsets.only(bottom: 4.h,left: 4.w),
                                        child: Container(

                                          width: 160.w,
                                          height: 30.h,
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.only(bottomRight:Radius.circular(20) ,bottomLeft: Radius.circular(20))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  FreeCoursesCubit.get(context).freeCoursesList[index].title!,
                                                  style:  TextStyle(
                                                      fontSize: 10.sp, fontWeight: FontWeight.w600,color: Colors.white),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.star,
                                                  color: ColorManager.star,
                                                  size: 15,
                                                ),
                                                Text(
                                                  FreeCoursesCubit.get(context).freeCoursesList[index].rate!,
                                                  style:  TextStyle(color: Colors.white,fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
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
              else if (constrain.maxWidth < 1000) {
                return BlocBuilder<FreeCoursesCubit, FreeCoursesState>(
                  builder: (context, state) {
                    if (state is GetFreeCoursesError) {
                      return Text("We have Error");
                    }
                    else if (state is GetFreeCoursesSuccess) {
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
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 3.2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10
                              ),
                              itemCount: FreeCoursesCubit.get(context).freeCoursesList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(

                                  onTap: () {
                                    List<FreeCoursesModel> freeCoursesList = [];
                                    List <InnerFreeCoursesModel> innerFreeCoursesList = [];

                                    constantvar.idFreeCoursesCategory = FreeCoursesCubit.get(context)
                                        .freeCoursesList[index]
                                        .id!;

                                    FirebaseFirestore.instance
                                        .collection("Free Courses")
                                        .doc(constantvar.idFreeCoursesCategory)
                                        .collection("innerCollection")
                                        .get()
                                        .then((value) {
                                      innerFreeCoursesList = [];

                                      for (var doc in value.docs) {
                                        innerFreeCoursesList.add(InnerFreeCoursesModel.fromJson(doc));
                                      }


                                    })
                                        .then((value) {
                                      navigateTo(
                                          context,
                                          InnerFreeCoursesPage(
                                            innerFreeCoursesModel: innerFreeCoursesList,
                                            id: constantvar.idFreeCoursesCategory!,
                                            freeCoursesModel:  constantvar.freeCoursesModel = FreeCoursesCubit.get(context).freeCoursesList[index],
                                          ));

                                      print("inner free courses success >>>>> ");
                                    }
                                    );

                                    // FreeCoursesCubit.get(context)
                                    //     .getSecondCategory(context);



                                    /*
                                          FirebaseFirestore.instance
                                              .collection("Free Courses")
                                              .doc(
                                            FreeCoursesCubit.get(context).freeCoursesList[index].id!,
                                          )
                                              .collection("RateOfUser")
                                              .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                              .get()
                                              .then((value) {
                                            print(
                                                "my rate is one two ${constantvar.rateUserFreeCourses}");
                                            constantvar.rateUserFreeCourses =
                                                value.data()?["oldRate"] ?? 0;
                                            print(
                                                "my rate is ${constantvar.rateUserFreeCourses}");
                                          }).then((value) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) {
                                                  return InnerFreeCoursesPage(
                                                      innerFreeCoursesModel: FreeCoursesCubit.get(context).innerFreeCoursesList,
                                                      id: FreeCoursesCubit.get(context).innerFreeCoursesList[index].id!
                                                  );
                                                }));
                                          });


                                           */

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
                                              imageUrl: FreeCoursesCubit.get(context).freeCoursesList[index].image!,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              height: 180.h,
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

                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.only(bottom: 3.h,left: 4.w,right: 4.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    FreeCoursesCubit.get(context).freeCoursesList[index].title!,
                                                    style:  TextStyle(
                                                        fontSize: 6.sp, fontWeight: FontWeight.w600,color: Colors.white),
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
