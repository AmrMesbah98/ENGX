import 'package:asec_application/presentation/DashBoard_Student/presentation/manger/dash_board_student_cubit.dart';
import 'package:asec_application/presentation/DashBoard_Student/presentation/view/widget/textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterDashBoardStudent extends StatefulWidget {
  RegisterDashBoardStudent({super.key});

  @override
  State<RegisterDashBoardStudent> createState() =>
      _RegisterDashBoardStudentState();
}

class _RegisterDashBoardStudentState extends State<RegisterDashBoardStudent> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController identityController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    identityController.dispose();
    codeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  clean() {
    emailController.clear();
    identityController.clear();
    codeController.clear();
    nameController.clear();
  }

  // List of numbers
  final List<String> _numbers = [
    "Ahmed Yasser",
    "Ahmed Atta",
    "Mohamed Hesham",
    "Ayatallah Ramadan",
    "Khloud Hamdi",
    "Mostafa Omar",
  ];

  String? _selectedInstructor; //

  bool _done = false;

  final List<Map<String, dynamic>> data = [
    // 1
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'AutoCad',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null',
      'open': 'false',
    },
    // 2
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Revit',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null',
      'open': 'false'
    },
    // 3
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'HVAC',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null',
      'open': 'false'
    },
    // 4
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'FPM',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null',
      'open': 'false'
    },

    /*
      // 5
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'FireFighting 01',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    // 6
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'FireFighting 02',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    // 7
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Pluming 01',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    // 8
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Medical 01',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    // 9
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Final Project 01',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    //10
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Final Project 02',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    // 11
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Final Project 03',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
    // 12
    {
      'degree': '--',
      'degreeOfInstructor': '--',
      'instructor': 'Ahmed Shuhayb',
      'subject': 'Final Project 04',
      'submit': 'false',
      'question one': 'null',
      'questionTwo': 'null',
      'question Three': 'null'
    },
     */
  ];

  GlobalKey<FormState> DashBoardKey = GlobalKey();

  bool _isLoading = false;

  Future<void> _delayedNavigation(BuildContext context) async {
    setState(() {
      _isLoading = true;
      // Show progress indicator
    });

    // Simulate a delay
    await Future.delayed(Duration(seconds: 5)).then((_) {
      clean();
      const snackBar = SnackBar(content: Text('User Add Done'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    setState(() {
      _isLoading = false; // Hide progress indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardStudentCubit, DashBoardStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        var models =
            DashBoardStudentCubit.get(context).nameInstructor[0].nameInstructor;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Account",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF6AC1C9),
                  Color(0xFF3857A4),
                ]),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: state is GetNameInstructorLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue,
                    size: 50,
                  ),
                )
              : Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF6AC1C9),
                      Color(0xFF3857A4),
                    ]),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Form(
                      key: DashBoardKey,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: MediaQuery.sizeOf(context).height * .1),
                            buildTextFieldDashBoard(
                              iconText: Icons.email_outlined,
                              label: "E-mail",
                              controller: emailController,
                              validateText: "Please Enter Your Name",
                              secure: false,
                            ),
                            SizedBox(height: 20.h),
                            buildTextFieldDashBoard(
                              iconText: Icons.account_circle_outlined,
                              label: "Name",
                              controller: nameController,
                              validateText: "Please Enter Your Password",
                              secure: false,
                            ),
                            SizedBox(height: 20.h),
                            buildTextFieldDashBoard(
                              iconText: Icons.lock_outline,
                              label: "Identity",
                              controller: identityController,
                              validateText: "Please Enter Your Password",
                              secure: true,
                            ),
                            SizedBox(height: 20.h),
                            buildTextFieldDashBoard(
                              iconText: Icons.password,
                              label: "Code",
                              controller: codeController,
                              validateText: "Please Enter Your code",
                              secure: true,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Icon(Icons.account_box_rounded,
                                    color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  "Select Instructor",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            DropdownButtonFormField(
                              menuMaxHeight: 300,
                              isExpanded: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  // Adjust this value to increase/decrease height
                                  horizontal: 12.w,
                                ),
                              ),

                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              // Array list of items
                              items: models?.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.toString()),
                                );
                              }).toList(),

                              onChanged: (newValue) {
                                setState(() {
                                  _selectedInstructor = newValue! as String?;
                                  print(newValue);
                                });
                              },
                            ),
                            SizedBox(height: 35.h),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (DashBoardKey.currentState!.validate()) {
                                    // create account
                                    await FirebaseFirestore.instance
                                        .collection("DashBoard User")
                                        .doc(identityController.text)
                                        .set({
                                      'email': emailController.text,
                                      'identity': identityController.text,
                                      'code': codeController.text,
                                      'name': nameController.text,
                                      'instructor': _selectedInstructor
                                    }).then((_) {
                                      _delayedNavigation(context);
                                    });

                                    final collectionRef = FirebaseFirestore
                                        .instance
                                        .collection('DashBoard User')
                                        .doc(identityController.text)
                                        .collection("WeekTest");

                                    for (int i = 0; i < data.length; i++) {
                                      // Add the order field dynamically to each map
                                      data[i]['order'] = i + 1;

                                      // Create a document with this data
                                      await collectionRef.add(data[i]);
                                      /*
                            for (var doc in data) {
                            await collectionRef.add(doc);
                          }
                           */

                                      print("All documents added!");
                                    }
                                  }
                                },
                                child: _isLoading
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF6AC1C9),
                                            Color(0xFF6AC1C9),
                                          ]),
                                        ),
                                        child: Center(
                                          child: LoadingAnimationWidget
                                              .staggeredDotsWave(
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ))
                                    : Container(
                                        width: 120.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF6AC1C9),
                                            Color(0xFF3857A4),
                                          ]),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
