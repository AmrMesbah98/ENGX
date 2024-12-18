import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/DashBoard_Student/presentation/view/screen/personal_info_trainer.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../shared_prefrance/shard_prefrance.dart';
import '../../manger/dash_board_student_cubit.dart';

class LoginTrainer extends StatefulWidget {
  const LoginTrainer({super.key});

  @override
  State<LoginTrainer> createState() => _LoginTrainerState();
}

class _LoginTrainerState extends State<LoginTrainer> {
  final TextEditingController codeController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey();

  @override
  void dispose() {
    codeController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  clean() {
    codeController.clear();
    passwordController.clear();
  }

  bool _isLoading = false;
  Future<void> _delayedNavigation(BuildContext context) async {
    setState(() {
      _isLoading = true;
      // Show progress indicator
    });

    // Simulate a delay
    await Future.delayed(Duration(seconds: 2));
    navigateTo(context, const PersonalInfo());
    setState(() {
      _isLoading = false; // Hide progress indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardStudentCubit, DashBoardStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Login Now',
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
              )),
          body: Form(
            key: loginKey,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF6AC1C9),
                  Color(0xFF3857A4),
                ]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * .12),
                      Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.yellow,
                        size: 130,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Warning! No entry without permission from the lecturer",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12
                                .h, // Adjust this value to increase/decrease height
                            horizontal: 12.w,
                          ),
                        ),
                        controller: codeController,
                        onChanged: (val) {
                          constantvar.coder = val;
                          CacheHelper.saveData(key: "coderDash", value: val);
                          constantvar.coderDash =
                              CacheHelper.getData(key: "coderDash");
                          print(constantvar.coder);
                        },
                      ),
                      const SizedBox(height: 50),
                      // submit
                      GestureDetector(
                        onTap: state is DashBoardStudentLoading
                            ? null // Disable the button during loading
                            : () async {
                                await DashBoardStudentCubit.get(context)
                                    .getWeakCollection();
                                navigateTo(context, PersonalInfo());
                                clean();
                              },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: state is DashBoardStudentLoading
                              ? SizedBox(
                                  width: 100,
                                  height: 60,
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w700),
                                )),
                        ),
                      )

                      /*
                       ElevatedButton(
                        onPressed: state is DashBoardStudentLoading
                            ? null // Disable the button during loading
                            : () async {
                                await DashBoardStudentCubit.get(context)
                                    .getWeakCollection();
                                navigateTo(context, PersonalInfo());
                              },
                        child: state is DashBoardStudentLoading
                            ? SizedBox(
                                width: 100,
                                height: 60,
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 50,
                                ),
                              )
                            : Text("Submit"),
                      ),
                      _isLoading
                          ? Container(
                              decoration: BoxDecoration(),
                              child: Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (loginKey.currentState!.validate()) {
                                    final collectionRef = FirebaseFirestore
                                        .instance
                                        .collection('DashBoard User');
                                    // Fetch all documents in the collection
                                    final querySnapshot =
                                        await collectionRef.get();
                                    final docIds = querySnapshot.docs
                                        .map((doc) => doc.id)
                                        .toList();

                                    if (docIds.contains(codeController.text)) {
                                      const snackBar = SnackBar(
                                          content:
                                              Text('Welcome In DashBoard'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      _delayedNavigation(context);

                                      DashBoardStudentCubit.get(context)
                                          .getWeakCollection();

                                      clean();
                                    } else {
                                      const snackBarError = SnackBar(
                                          content: Text('your Info is Wrong'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBarError);
                                    }
                                  }
                                },
                                child: Container(
                                  width: 120.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF6AC1C9),
                                      Color(0xFF3857A4),
                                    ]),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                       */
                      ,
                      const SizedBox(height: 20),
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
