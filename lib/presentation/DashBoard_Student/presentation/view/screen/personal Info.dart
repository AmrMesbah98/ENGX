import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/DashBoard_Student/presentation/manger/dash_board_student_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../student_degree/presentation/view/showStudentDegreePage.dart';

class DetailsTrainer extends StatefulWidget {
  const DetailsTrainer({super.key});

  @override
  State<DetailsTrainer> createState() => _DetailsTrainerState();
}

class _DetailsTrainerState extends State<DetailsTrainer> {
  TextEditingController questionOneController = TextEditingController();
  TextEditingController questionTwoController = TextEditingController();
  TextEditingController questionThreeController = TextEditingController();

  @override
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

  GlobalKey<FormState> reviewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardStudentCubit, DashBoardStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DashBoardStudentLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          var model = DashBoardStudentCubit.get(context).weekTesterModel;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF6AC1C9),
                    Color(0xFF3857A4),
                  ]),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "Personal Info",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Container(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:
                      DashBoardStudentCubit.get(context).weekTesterModel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF6AC1C9),
                                Color(0xFF3857A4),
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model[index].subject!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      model[index].instructor!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  // degree
                                  model[index].submit == "true"
                                      ? Text(
                                          model[index].degree!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Container(
                                            width: 70.w,
                                            height: 15.h,
                                            color: Colors.white,
                                          ),
                                        ),

                                  // review
                                  model[index].submit == "false"
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 10.h),
                                                    // لجعل الحوار يأخذ كامل الشاشة
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                key: reviewKey,
                                                                child: Column(
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
                                                                        color: Colors
                                                                            .black87,
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
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          borderSide:
                                                                              BorderSide.none,
                                                                        ),
                                                                        contentPadding:
                                                                            EdgeInsets.symmetric(
                                                                          vertical:
                                                                              12.h,
                                                                          // Adjust this value to increase/decrease height
                                                                          horizontal:
                                                                              12.w,
                                                                        ),
                                                                      ),

                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      // Array list of items
                                                                      items: _numbers.map(
                                                                          (String
                                                                              items) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              items,
                                                                          child:
                                                                              Text(items.toString()),
                                                                        );
                                                                      }).toList(),

                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          _selectedNumber =
                                                                              newValue!;
                                                                          print(
                                                                              newValue);
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
                                                                    Navigator.of(
                                                                            context)
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
                                                                      () async {
                                                                    if (reviewKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "DashBoard User")
                                                                          .doc(constantvar
                                                                              .coder)
                                                                          .collection(
                                                                              'WeekTest')
                                                                          .doc(model[index]
                                                                              .id!)
                                                                          .update({
                                                                        'question one':
                                                                            questionOneController.text,
                                                                        'questionTwo':
                                                                            questionTwoController.text,
                                                                        'question Three':
                                                                            questionThreeController.text,
                                                                        'degreeOfInstructor':
                                                                            _selectedNumber,
                                                                        'submit':
                                                                            'true'
                                                                      }).then((val) {
                                                                        DashBoardStudentCubit.get(context)
                                                                            .getWeakCollection();
                                                                        DashBoardStudentCubit.get(context)
                                                                            .getDashBoardCollection();
                                                                      });

                                                                      const snackBar =
                                                                          SnackBar(
                                                                              content: Text('Done Review '));

                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);

                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  child: const Text(
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
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: const Center(
                                                  child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  "Review Now",
                                                  style: TextStyle(
                                                      color: Color(0xFF3857A4),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              )),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: const Text(
                                            "Review Done",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                ],
                              )
                            ],
                          )),
                    );
                  }),
            ),
          );
        }
      },
    );
  }
}
