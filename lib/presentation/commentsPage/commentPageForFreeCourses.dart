import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/Free_Courses/free_courses_cubit.dart';
import 'package:asec_application/bloc/get_courses/courses_cubit.dart';
import 'package:asec_application/model/courses_model.dart';
import 'package:asec_application/model/free_courses_model/free_courses_model.dart';
import 'package:asec_application/presentation/resources/color_manager.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../../model/instructor_model.dart';
import '../../generated/l10n.dart';
import '../rate_widget/fiveRate.dart';
import '../rate_widget/fourRate.dart';
import '../rate_widget/oneRate.dart';
import '../rate_widget/threeRate.dart';
import '../rate_widget/twoRate.dart';
import '../rate_widget/zeroRate.dart';
import 'Tablet/commentPageForCourses_tablet.dart';
import 'Tablet/commentPageForFreeCourses_tablet.dart';

class CommentPageForFreeCourses extends StatefulWidget {
  CommentPageForFreeCourses({
    super.key,
    required this.freeCoursesModel,
    required this.id,
  });

  final FreeCoursesModel freeCoursesModel;
  String id;

  @override
  State<CommentPageForFreeCourses> createState() => _CommentPageForFreeCoursesState();
}

class _CommentPageForFreeCoursesState extends State<CommentPageForFreeCourses> {
  @override
  void initState() {
    FreeCoursesCubit.get(context).getFreeCoursesVideo();
    FreeCoursesCubit.get(context).freeCoursesList;
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorManager.Black),
            elevation: 0,
            centerTitle: true,
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
            title: Text(
              S.of(context).ReviewPage,
              style:  TextStyle(color: Colors.black,fontSize: 18.sp),
            ),
          ),
          body: LayoutBuilder(builder: (context, constrain) {
            if (constrain.maxWidth < 600) {
              return RefreshIndicator(
                onRefresh: () {
                  return FreeCoursesCubit.get(context).getFreeCoursesVideo();
                },
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
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
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // rate
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(S.of(context).Rate,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600)),
                                    ),

                                    //for rate
                                    Row(
                                      children: [
                                        //text rate
                                        Text(
                                          widget.freeCoursesModel.rate!,
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600),
                                        ),

                                        //space
                                        SizedBox(
                                          width: 5.w,
                                        ),

                                        //for rate
                                        constantvar.zeroRate.contains(
                                            widget.freeCoursesModel.rate!)
                                            ? zeroRateWidget()
                                            :

                                        ////////////////////////////////////////////////////////////////////////////

                                        constantvar.oneRate.contains(
                                            widget.freeCoursesModel.rate!)
                                            ? oneRateWidget()
                                            :

                                        ////////////////////////////////////////////////////////////////////////////

                                        constantvar.twoRate.contains(
                                            widget
                                                .freeCoursesModel.rate!)
                                            ? twoRateWidget()
                                            :

                                        ////////////////////////////////////////////////////////////////////////////

                                        constantvar.threeRate
                                            .contains(widget
                                            .freeCoursesModel
                                            .rate!)
                                            ? threeRateWidget()
                                            :

                                        ////////////////////////////////////////////////////////////////////////////

                                        constantvar.fourRate
                                            .contains(widget
                                            .freeCoursesModel
                                            .rate!)
                                            ? fourRateWidget()
                                            :

                                        ////////////////////////////////////////////////////////////////////////////

                                        constantvar.fiveRate
                                            .contains(widget
                                            .freeCoursesModel
                                            .rate!)
                                            ? fiveRateWidget()
                                            :

                                        ////////////////////////////////////////////////////////////////////////////

                                        zeroRateWidget()

                                        ////////////////////////////////////////////////////////////////////////////
                                      ],
                                    ),

                                    const Spacer(),

                                    //for number user make rate
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 17,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          widget.freeCoursesModel.numberUserRate
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.sp,
                                              color: Colors.black54),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //space
                              SizedBox(height: 5.h),
                              //tex All Comments
                              Text(
                                S.of(context).AllComments,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              //space
                              SizedBox(height: 5.h),

                              //list All Comments
                              ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.freeCoursesModel.comment!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Card(
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            .94,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xffeeeded),
                                                  Color(0xFFFFFFFF),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            //row for name

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.w,
                                                  top: 5.h,
                                                  bottom: 5.h),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    size: 16,
                                                  ),
                                                  //space
                                                  SizedBox(
                                                    width: 7.w,
                                                  ),

                                                  Flexible(
                                                    child: Text(
                                                      widget.freeCoursesModel
                                                          .nameUser![index],
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //row for comment

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.w, bottom: 5.h),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.comment,
                                                    size: 14,
                                                  ),
                                                  //space
                                                  SizedBox(
                                                    width: 7.w,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      widget.freeCoursesModel
                                                          .comment![index],
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              //////////////////////////////////////////////////////////

                              //space
                              SizedBox(
                                height: 20.h,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            } else if (constrain.maxWidth < 900) {
              return  Center(child: CommentPageForFreeCoursesTablet(
                freeCoursesModel: constantvar.freeCoursesModel!,
                id: constantvar.freeCoursesModel!.id!,
              ));
            } else {
              return const Center(child: Text("Desktop"));
            }
          }),
        );
      },
    );
  }

  Icon iconStar(MaterialColor color) => Icon(
    Icons.star,
    color: color,
    size: 15,
  );
}
