import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/DashBoard_Student/presentation/manger/dash_board_student_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model.dart';
import 'deatils_review.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<WeekTesterModel> weekModel = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardStudentCubit, DashBoardStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        var masterModel =
            DashBoardStudentCubit.get(context).dashBoardModelReview;
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Review Screen",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6AC1C9), Color(0xFF3857A4)],
                  ),
                ),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is DashBoardStudentLoadingReview
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6AC1C9), Color(0xFF3857A4)],
                            ),
                          ),
                          height: 120.h,
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: masterModel.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    constantvar.reviewScreenInstructor =
                                        masterModel[index].instructor;
                                    DashBoardStudentCubit.get(context)
                                        .getDashBoardCollectionReviewFilter(
                                            constantvar
                                                .reviewScreenInstructor!);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                        ),
                                      ),
                                      Text(
                                        masterModel[index].instructor!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  state is DashBoardStudentLoadingReviewFilter
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * .39),
                            Center(child: CircularProgressIndicator()),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: DashBoardStudentCubit.get(context)
                                    .dashBoardModelReviewFilter
                                    .length,
                                itemBuilder: (context, index) {
                                  var model = DashBoardStudentCubit.get(context)
                                      .dashBoardModelReviewFilter;
                                  return GestureDetector(
                                    onTap: () async {
                                      constantvar.coderDash = model[index].id;

                                      await FirebaseFirestore.instance
                                          .collection('DashBoard User')
                                          .doc(constantvar.coderDash)
                                          .collection('WeekTest')
                                          .get()
                                          .then((val) {
                                        print(
                                            '11111111'); // Debugging checkpoint
                                        weekModel = [];
                                        for (var doc in val.docs) {
                                          print(
                                              '22222222'); // Debugging checkpoint for each document
                                          weekModel.add(
                                              WeekTesterModel.fromJson(
                                                  doc)); // Use doc.data()
                                        }
                                        print(
                                            '33333333'); // Debugging checkpoint after processing all docs
                                        print(
                                            'WeekModel Length: ${weekModel.length}'); // Check final length
                                      }).then((val) {});
                                      print('our model is : $weekModel');

                                      navigateTo(
                                          context,
                                          ReviewUserDetails(
                                            model: weekModel,
                                          ));

                                      print(constantvar.coderDash);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 7),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF6AC1C9),
                                                Color(0xFF3857A4)
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Name : ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    model[index].name!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 7.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    "E-mail : ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    model[index].email!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 7.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Code : ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    model[index].code!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                ],
              ),
            ));
      },
    );
  }
}
