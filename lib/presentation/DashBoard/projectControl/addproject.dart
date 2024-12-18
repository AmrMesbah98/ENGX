
import 'package:asec_application/Constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../bloc/get_project/project_cubit.dart';
import '../../../model/project_model.dart';
import '../../../shared_prefrance/shard_prefrance.dart';
import '../../login/login_view.dart';
import '../CoursesControl/BuildTextFormFieldCourses.dart';

class AppProject extends StatefulWidget {
   const AppProject({super.key});

  @override
  State<AppProject> createState() => _AppProjectState();
}

class _AppProjectState extends State<AppProject> {
  GlobalKey <FormState> keyProject = GlobalKey();


  TextEditingController categoryController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController picOneController = TextEditingController();
  TextEditingController picTwoController = TextEditingController();
  TextEditingController picThreeController = TextEditingController();
  TextEditingController picFourController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    detailsController.dispose();
    dateController.dispose();
    idController.dispose();
    locationController.dispose();
    imageController.dispose();
    picOneController.dispose();
    picTwoController.dispose();
    picThreeController.dispose();
    picFourController.dispose();
  }

  void clear()
  {
    categoryController.clear();
    detailsController.clear();
    dateController.clear();
    idController.clear();
    locationController.clear();
    imageController.clear();
    picOneController.clear();
    picTwoController.clear();
    picThreeController.clear();
    picFourController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
        iconTheme: const IconThemeData(color: Colors.black54),
        title: const Text(
          "Courses Controller ", style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
            child: Form(
              key: keyProject,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  BuildTextFormFieldCourses(
                      label: "category", controller: categoryController),
                  BuildTextFormFieldCourses(
                      label: "Details",
                      controller: detailsController),
                  BuildTextFormFieldCourses(
                      label: "Date", controller: dateController),
                  BuildTextFormFieldCourses(
                      label: "Location", controller: locationController),
                  BuildTextFormFieldCourses(
                      label: "Image", controller: imageController),
                  BuildTextFormFieldCourses(
                      label: "UID", controller: idController),
                  BuildTextFormFieldCourses(
                      label: "Picture One", controller: picOneController),
                  BuildTextFormFieldCourses(
                      label: "Picture Two", controller: picTwoController),
                  BuildTextFormFieldCourses(
                      label: "Picture Three", controller: picThreeController),
                  BuildTextFormFieldCourses(
                      label: "Picture Four", controller: picFourController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        height: MediaQuery.of(context).size.height * .05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            ProjectModel projectModel = ProjectModel(
                                id: idController.text,
                                category: categoryController.text,
                                date: dateController.text,
                                details: detailsController.text,
                                iamge: imageController.text,
                                location: locationController.text,
                                photo: [
                                  picOneController.text,
                                  picTwoController.text,
                                  picThreeController.text,
                                  picFourController.text,
                                ]
                            );

                            if (keyProject.currentState!.validate()) {
                               ProjectCubit.get(context).setProject(
                                  data: projectModel.toMap(),
                              ).then((value)
                               {
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
                          child: const Text("Upload New Project"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
    );
  }
}
