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
import 'HomePage_Courses.dart';

class ControlCourses extends StatefulWidget {
  ControlCourses({super.key, required this.coursesModel});

  CoursesModel coursesModel;

  @override
  State<ControlCourses> createState() => _ControlCoursesState();
}

class _ControlCoursesState extends State<ControlCourses> {
  TextEditingController? nameCourseController;
  TextEditingController? nameInstructorController;
  TextEditingController? priceController;
  TextEditingController? rateController;
  TextEditingController? imageController;
  TextEditingController? descriptionController;
  TextEditingController? moreDetailsController;
  TextEditingController? idController;
  TextEditingController? linkController;

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

  @override
  Widget build(BuildContext context) {
    nameCourseController =
        TextEditingController(text: widget.coursesModel.nameCourse);
    nameInstructorController =
        TextEditingController(text: widget.coursesModel.nameInstructor);
    priceController = TextEditingController(text: widget.coursesModel.price);
    rateController = TextEditingController(text: widget.coursesModel.rate);
    imageController = TextEditingController(text: widget.coursesModel.images);
    descriptionController =
        TextEditingController(text: widget.coursesModel.description);
    moreDetailsController =
        TextEditingController(text: widget.coursesModel.moreDetails);
    idController = TextEditingController(text: widget.coursesModel.id);
    linkController = TextEditingController(text: widget.coursesModel.link);

    GlobalKey<FormState> keyCourses = GlobalKey();


    return BlocConsumer<GetCoursesCubit,CoursesState>(
      listener: (context, state){},
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
              title: Text(
                widget.coursesModel.nameCourse!,
                style: const TextStyle(color: Colors.black54),
              )),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: keyCourses,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.yellow,
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () async {
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

                              if (keyCourses.currentState!.validate()) {
                                await GetCoursesCubit.get(context)
                                    .buildUpdateDocumentFunction(
                                  id: widget.coursesModel.id!,
                                  model: updateCourses.toJson(),
                                )
                                    .then((value) {
                                  FirebaseAuth.instance.signOut().then((value) {
                                    CacheHelper.clearData(key: "uId");

                                  });
                                });
                              }
                            },
                            child: const Text("Update"),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              await GetCoursesCubit.get(context)
                                  .buildDeleteDocumentFunction(
                                  widget.coursesModel.id!)
                                  .then((value) {
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
                            },
                            child: const Text("Delete"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

  }
}
