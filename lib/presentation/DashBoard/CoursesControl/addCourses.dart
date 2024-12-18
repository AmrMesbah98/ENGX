import 'package:asec_application/Constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/get_courses/courses_cubit.dart';
import '../../../model/courses_model.dart';
import '../../../shared_prefrance/shard_prefrance.dart';
import '../../login/login_view.dart';
import 'BuildTextFormFieldCourses.dart';

class AddCourses extends StatefulWidget {
  AddCourses({super.key});

  @override
  State<AddCourses> createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  TextEditingController? nameCourseController = TextEditingController();

  TextEditingController? nameInstructorController = TextEditingController();

  TextEditingController? priceController = TextEditingController();

  TextEditingController? rateController = TextEditingController();

  TextEditingController? imageController = TextEditingController();

  TextEditingController? descriptionController = TextEditingController();

  TextEditingController? moreDetailsController = TextEditingController();

  TextEditingController? idController = TextEditingController();

  TextEditingController? linkController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCourseController!.dispose();
    nameInstructorController!.dispose();
    priceController!.dispose();
    rateController!.dispose();
    imageController!.dispose();
    descriptionController!.dispose();
    moreDetailsController!.dispose();
    idController!.dispose();
    linkController!.dispose();
  }

  GlobalKey<FormState> _addCoursesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {



    return BlocConsumer<GetCoursesCubit,CoursesState >(
      listener: (context,state){},
        builder: (context, state){
        return Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black54),
              centerTitle: true,
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF3A65A9),
                        Color(0xFFFFFFFF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              title: const Text(
                "Add Courses",
                style: TextStyle(color: Colors.black54),
              )),
          body: SingleChildScrollView(
            child: Form(
              key: _addCoursesKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  BuildTextFormFieldCourses(
                      label: "Name Course", controller: nameCourseController!),
                  BuildTextFormFieldCourses(
                      label: "Name Instructor",
                      controller: nameInstructorController!),
                  BuildTextFormFieldCourses(
                      label: "Price", controller: priceController!),
                  BuildTextFormFieldCourses(
                      label: "Rate", controller: rateController!),
                  BuildTextFormFieldCourses(
                      label: "Image", controller: imageController!),
                  BuildTextFormFieldCourses(
                      label: "Description", controller: descriptionController!),
                  BuildTextFormFieldCourses(
                      label: "More Details",
                      controller: moreDetailsController!),
                  BuildTextFormFieldCourses(
                      label: "UID", controller: idController!),
                  BuildTextFormFieldCourses(
                      label: "Link", controller: linkController!),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height * .05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: (){
                            CoursesModel updateCourses = CoursesModel(
                              nameCourse: nameCourseController!.text,
                              nameInstructor: nameInstructorController!.text,
                              price: priceController!.text,
                              rate: rateController!.text,
                              description: descriptionController!.text,
                              moreDetails: moreDetailsController!.text,
                              link: linkController!.text,
                              images: imageController!.text,
                              id: idController!.text,
                            );
                            if (_addCoursesKey.currentState!.validate()) {
                              GetCoursesCubit.get(context).setCoursesSnap(
                                data: updateCourses.toJson(),
                              ).then((value) {
                                FirebaseMessaging.instance.unsubscribeFromTopic('all');
                                FirebaseMessaging.instance
                                    .unsubscribeFromTopic(constantvar.Uid);
                                FirebaseAuth.instance.signOut().then((value) {
                                  CacheHelper.clearData(key: "uId");

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                                    return const LoginViewApp();
                                  }));
                                });
                              });
                            }
                          },
                          child: const Center(
                              child: Text(
                                "Create Courses",
                                style: TextStyle(fontSize: 25),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        );
        },

    );
  }
}
