import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/get_courses/courses_cubit.dart';
import 'package:asec_application/model/courses_model.dart';
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
import '../../../generated/l10n.dart';
import '../../../model/instructor_model.dart';
import '../../rate_widget/fiveRate.dart';
import '../../rate_widget/fourRate.dart';
import '../../rate_widget/oneRate.dart';
import '../../rate_widget/threeRate.dart';
import '../../rate_widget/twoRate.dart';
import '../../rate_widget/zeroRate.dart';


class CommentPageForCoursesTablet extends StatefulWidget {
  CommentPageForCoursesTablet({
    super.key,
    required this.coursesModel,
    required this.id,
  });

  final CoursesModel coursesModel;
  String id;

  @override
  State<CommentPageForCoursesTablet> createState() => _CommentPageForCoursesTabletState();
}

class _CommentPageForCoursesTabletState extends State<CommentPageForCoursesTablet> {
  @override
  void initState() {
    GetCoursesCubit.get(context).getCourses();
    GetCoursesCubit.get(context).coursesModelList;
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

            body: RefreshIndicator(
              onRefresh: () {
                return GetCoursesCubit.get(context).getCourses();
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
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // rate
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: Text(S.of(context).Rate,
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),

                                  //for rate
                                  Row(
                                    children: [
                                      //text rate
                                      Text(
                                        widget.coursesModel.rate!,
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600),
                                      ),

                                      //space
                                      SizedBox(
                                        width: 3.w,
                                      ),

                                      //for rate
                                      constantvar.zeroRate.contains(widget.coursesModel.rate!)?
                                      zeroRateWidget():

                                      ////////////////////////////////////////////////////////////////////////////

                                      constantvar.oneRate.contains(widget.coursesModel.rate!)?
                                      oneRateWidget():

                                      ////////////////////////////////////////////////////////////////////////////

                                      constantvar.twoRate.contains(widget.coursesModel.rate!)?
                                      twoRateWidget():

                                      ////////////////////////////////////////////////////////////////////////////

                                      constantvar.threeRate.contains(widget.coursesModel.rate!)?
                                      threeRateWidget():

                                      ////////////////////////////////////////////////////////////////////////////

                                      constantvar.fourRate.contains(widget.coursesModel.rate!)?
                                      fourRateWidget():

                                      ////////////////////////////////////////////////////////////////////////////

                                      constantvar.fiveRate.contains(widget.coursesModel.rate! )?
                                      fiveRateWidget():

                                      ////////////////////////////////////////////////////////////////////////////

                                      zeroRateWidget()

                                      ////////////////////////////////////////////////////////////////////////////
                                    ],
                                  ),

                                  const Spacer(),

                                  //for number user make rate
                                  Row(
                                    children: [
                                      const Icon(Icons.person,size: 17,color: Colors.black54,),
                                      SizedBox(width: 2.w,),
                                      Text(widget.coursesModel.numberUserRate.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 9.sp,color: Colors.black54),)
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
                                  fontSize: 10.sp, fontWeight: FontWeight.w600),
                            ),
                            //space
                            SizedBox(height: 5.h),

                            //list All Comments
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.coursesModel.comment!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Card(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Container(
                                      width:
                                      MediaQuery.of(context).size.width * .94,
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
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          //row for name

                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w, top: 5.h, bottom: 5.h),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  size: 20,
                                                ),
                                                //space
                                                SizedBox(
                                                  width: 7.w,
                                                ),

                                                Flexible(
                                                  child: Text(
                                                    widget.coursesModel
                                                        .nameUser![index],
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight: FontWeight.w600),
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
                                                  size: 17,
                                                ),
                                                //space
                                                SizedBox(
                                                  width: 7.w,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    widget.coursesModel
                                                        .comment![index],
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        fontWeight: FontWeight.w500),
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
            ));
      },
    );
  }

  Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 15,);
}