import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../student_degree/presentation/view/showStudentDegreePage.dart';
import '../../manger/dash_board_student_cubit.dart';

class DashBoardDegree extends StatefulWidget {
  DashBoardDegree({super.key, required this.id});

  String id;

  @override
  State<DashBoardDegree> createState() => _DashBoardDegreeState();
}

class _DashBoardDegreeState extends State<DashBoardDegree> {
  GlobalKey<FormState> degreeKey = GlobalKey();

  TextEditingController degreeController = TextEditingController();

  @override
  void dispose() {
    degreeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardStudentCubit, DashBoardStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DashBoardStudentLoadingInnerNew) {
          return Center(child: CircularProgressIndicator());
        } else {
          var innerModel =
              DashBoardStudentCubit.get(context).weekTesterModelDash;

          print(innerModel.length);

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Details Trainer ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF6AC1C9),
                      Color(0xFF3857A4),
                    ]),
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: innerModel.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 10.h),
                                  // لجعل الحوار يأخذ كامل الشاشة
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          //space
                                          SizedBox(
                                            height: 7.h,
                                          ),

                                          //text confirmation
                                          Text(
                                            "Confirmation",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Form(
                                              key: degreeKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //question 1
                                                  buildTextField(
                                                    label: "Degree",
                                                    controller:
                                                        degreeController,
                                                  ),

                                                  SizedBox(height: 16.h),
                                                ],
                                              ),
                                            ),
                                          ),

                                          //row button cansel and submit
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              //button cansel
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // إغلاق الحوار
                                                  print("Cancel pressed");
                                                },
                                                child: Text("Cancel"),
                                              ),

                                              //button submit
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "DashBoard User")
                                                      .doc(widget.id)
                                                      .collection("WeekTest")
                                                      .doc(
                                                          innerModel[index].id!)
                                                      .update({
                                                    'degree':
                                                        degreeController.text
                                                  }).then((_) {
                                                    DashBoardStudentCubit.get(
                                                            context)
                                                        .getWeakCollectionDashboard(
                                                            widget.id);

                                                    final snackBar = SnackBar(
                                                        content: Text(
                                                            'Degree Change Done'));

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);

                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("Submit"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(colors: [
                                  Color(0xFF6AC1C9),
                                  Color(0xFF3857A4),
                                ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "ID : ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              innerModel[index].id!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 5),
                                        Row(
                                          children: [
                                            Text(
                                              "Subject : ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              innerModel[index].subject!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 5),
                                        Row(
                                          children: [
                                            Text(
                                              "Instructor : ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              innerModel[index].instructor!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      innerModel[index].degree!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ));
        }
      },
    );
  }
}
