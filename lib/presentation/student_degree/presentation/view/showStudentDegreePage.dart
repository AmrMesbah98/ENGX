import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/student_degree_cubit.dart';

class ShowStudentDegreePage extends StatefulWidget {
  const ShowStudentDegreePage({
    super.key,
  });

  @override
  State<ShowStudentDegreePage> createState() => _ShowStudentDegreePageState();
}

class _ShowStudentDegreePageState extends State<ShowStudentDegreePage> {
  TextEditingController questionOneController = TextEditingController();
  TextEditingController questionTwoController = TextEditingController();
  TextEditingController questionThreeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  void dispose() {
    questionOneController.dispose();
    questionTwoController.dispose();
    questionThreeController.dispose();
    super.dispose();
  }

  clear() {
    questionOneController.clear();
    questionTwoController.clear();
    questionThreeController.clear();
  }

  // List of numbers
  final List<String> _numbers = [
    "70 %",
    "75 %",
    "80 %",
    "85 %",
    "90 %",
    "95 %",
    "100 %"
  ];
  String? _selectedNumber; // Currently selected number

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentDegreeCubit, StudentDegreeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('student degree')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No data found'));
                    }

                    final documents = snapshot.data!.docs;

                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final doc = documents[index];

                          final name = doc['name'] ?? 'No Name';
                          final track = doc['track'] ?? 'No Track';
                          final instructor =
                              doc['instructor'] ?? 'No Instructor';
                          final degree = doc['degree'] ?? 'No Degree';
                          final showData = doc['showData'] ?? 'No Data';

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //name
                                        Text(
                                          name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        ),

                                        // Text(StudentDegreeCubit.get(context).studentDegreeList[index].name!,
                                        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                        // ),

                                        //track
                                        Text(
                                          track,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp),
                                        ),
                                        //instructor
                                        Text(
                                          instructor,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        //button degree
                                        Container(
                                          width: 90.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 10,
                                                offset:
                                                    Offset(0, 5), // إزاحة الظل
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                          child: Center(
                                            child: showData == false
                                                ? Text(
                                                    'Degree',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Text(
                                                    degree,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                          ),
                                        ),

                                        //space
                                        SizedBox(
                                          height: 7.h,
                                        ),

                                        //button Review
                                        showData == false
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        insetPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.w,
                                                                vertical: 10.h),
                                                        // لجعل الحوار يأخذ كامل الشاشة
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child:
                                                              SingleChildScrollView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
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
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),

                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16.0),
                                                                  child: Form(
                                                                    key:
                                                                        formKey,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        //question 1
                                                                        buildTextField(
                                                                          label:
                                                                              "What do you think of the Instructors’s explanation?",
                                                                          controller:
                                                                              questionOneController,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                16.h),
                                                                        //question 2
                                                                        buildTextField(
                                                                          label:
                                                                              "Does he convey the information easily?",
                                                                          controller:
                                                                              questionTwoController,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                16.h),
                                                                        //question 3
                                                                        buildTextField(
                                                                          label:
                                                                              "Is his performance distinctive and useful?",
                                                                          controller:
                                                                              questionThreeController,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                16.h),

                                                                        //text grade
                                                                        Text(
                                                                          "Degree of Instructor",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15.sp,
                                                                            color:
                                                                                Colors.black87,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                8.h),

                                                                        //dropdown grade
                                                                        DropdownButtonFormField(
                                                                          menuMaxHeight:
                                                                              300,
                                                                          isExpanded:
                                                                              true,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                Colors.grey[200],
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              borderSide: BorderSide.none,
                                                                            ),
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(
                                                                              vertical: 12.h,
                                                                              // Adjust this value to increase/decrease height
                                                                              horizontal: 12.w,
                                                                            ),
                                                                          ),

                                                                          icon:
                                                                              const Icon(
                                                                            Icons.keyboard_arrow_down,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          // Array list of items
                                                                          items:
                                                                              _numbers.map((String items) {
                                                                            return DropdownMenuItem(
                                                                              value: items,
                                                                              child: Text(items.toString()),
                                                                            );
                                                                          }).toList(),

                                                                          onChanged:
                                                                              (String? newValue) {
                                                                            setState(() {
                                                                              _selectedNumber = newValue!;
                                                                              print(newValue);
                                                                            });
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),

                                                                //row button cansel and submit
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    //button cansel
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // إغلاق الحوار
                                                                        print(
                                                                            "Cancel pressed");
                                                                      },
                                                                      child: Text(
                                                                          "Cancel"),
                                                                    ),

                                                                    //button submit
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          if (instructor ==
                                                                              "Eng Ahmed Yasser") {
                                                                            StudentDegreeCubit.get(context)
                                                                                .addReviewToAhmedYasserFunction(
                                                                                  context: context,
                                                                                  userName: name,
                                                                                  answerOne: questionOneController.text,
                                                                                  answerTwo: questionTwoController.text,
                                                                                  answerThree: questionThreeController.text,
                                                                                  grade: _selectedNumber.toString(),
                                                                                )
                                                                                .then((value) => {
                                                                                      FirebaseFirestore.instance.collection("student degree").doc(StudentDegreeCubit.get(context).studentDegreeList[index].id!).update({
                                                                                        "showData": true
                                                                                      }).then((value) => {
                                                                                            clear(),
                                                                                            print("OK Submit Done"),
                                                                                            Navigator.of(context).pop(),
                                                                                          })
                                                                                    });
                                                                          } else if (instructor ==
                                                                              "Eng Yousif Yasser") {
                                                                            StudentDegreeCubit.get(context)
                                                                                .addReviewToYousifYasserFunction(
                                                                                  context: context,
                                                                                  userName: name,
                                                                                  answerOne: questionOneController.text,
                                                                                  answerTwo: questionTwoController.text,
                                                                                  answerThree: questionThreeController.text,
                                                                                  grade: _selectedNumber.toString(),
                                                                                )
                                                                                .then((value) => {
                                                                                      FirebaseFirestore.instance.collection("student degree").doc(StudentDegreeCubit.get(context).studentDegreeList[index].id!).update({
                                                                                        "showData": true
                                                                                      }).then((value) => {
                                                                                            clear(),
                                                                                            print("OK Submit Done"),
                                                                                            Navigator.of(context).pop(),
                                                                                          })
                                                                                    });
                                                                          } else if (instructor ==
                                                                              "Eng Khalid Amin") {
                                                                            StudentDegreeCubit.get(context)
                                                                                .addReviewToKhalidAminFunction(
                                                                                  context: context,
                                                                                  userName: name,
                                                                                  answerOne: questionOneController.text,
                                                                                  answerTwo: questionTwoController.text,
                                                                                  answerThree: questionThreeController.text,
                                                                                  grade: _selectedNumber.toString(),
                                                                                )
                                                                                .then((value) => {
                                                                                      FirebaseFirestore.instance.collection("student degree").doc(StudentDegreeCubit.get(context).studentDegreeList[index].id!).update({
                                                                                        "showData": true
                                                                                      }).then((value) => {
                                                                                            clear(),
                                                                                            print("OK Submit Done"),
                                                                                            Navigator.of(context).pop(),
                                                                                          })
                                                                                    });
                                                                          } else {
                                                                            StudentDegreeCubit.get(context)
                                                                                .addReviewFunction(
                                                                                  context: context,
                                                                                  userName: name,
                                                                                  answerOne: questionOneController.text,
                                                                                  answerTwo: questionTwoController.text,
                                                                                  answerThree: questionThreeController.text,
                                                                                  grade: _selectedNumber.toString(),
                                                                                )
                                                                                .then((value) => {
                                                                                      FirebaseFirestore.instance.collection("student degree").doc(StudentDegreeCubit.get(context).studentDegreeList[index].id!).update({
                                                                                        "showData": true
                                                                                      }).then((value) => {
                                                                                            clear(),
                                                                                            print("OK Submit Done"),
                                                                                            Navigator.of(context).pop(),
                                                                                          })
                                                                                    });
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                          "Submit"),
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
                                                child: Container(
                                                  width: 90.w,
                                                  height: 35.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        blurRadius: 10,
                                                        offset: Offset(
                                                            0, 5), // إزاحة الظل
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 3,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: showData == false
                                                        ? Text(
                                                            'Review',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        : Text(
                                                            'Done',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              )
                                            : const Text(""),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildTextField({
  required String label,
  required TextEditingController controller,
  //String? Function(String?)? validator,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h, // Adjust this value to increase/decrease height
            horizontal: 12.w,
          ),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter answer of this question';
          }
          return null;
        },
      ),
    ],
  );
}
