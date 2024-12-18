
import 'package:asec_application/Constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/get_project/project_cubit.dart';
import '../../../model/project_model.dart';
import '../../../shared_prefrance/shard_prefrance.dart';
import '../../login/login_view.dart';
import '../CoursesControl/BuildTextFormFieldCourses.dart';
import '../DataUser.dart';

class ControlProject extends StatefulWidget {
  ControlProject({super.key, required this.projectModel});

  ProjectModel projectModel;

  @override
  State<ControlProject> createState() => _ControlProjectState();
}

class _ControlProjectState extends State<ControlProject> {
  TextEditingController? categoryController;
  TextEditingController? detailsController;
  TextEditingController? dateController;
  TextEditingController? idController;
  TextEditingController? locationController;
  TextEditingController? imageController;
  TextEditingController? picOneController;
  TextEditingController? picTwoController;
  TextEditingController? picThreeController;
  TextEditingController? picFourController;

  @override
  void dispose() {
    super.dispose();
    categoryController!.dispose();
    detailsController!.dispose();
    dateController!.dispose();
    idController!.dispose();
    locationController!.dispose();
    imageController!.dispose();
    picOneController!.dispose();
    picTwoController!.dispose();
    picThreeController!.dispose();
    picFourController!.dispose();
  }

  GlobalKey<FormState> updateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    categoryController =
        TextEditingController(text: widget.projectModel.category);
    detailsController =
        TextEditingController(text: widget.projectModel.details);
    dateController = TextEditingController(text: widget.projectModel.date);
    idController = TextEditingController(text: widget.projectModel.id);
    locationController =
        TextEditingController(text: widget.projectModel.location);
    imageController = TextEditingController(text: widget.projectModel.iamge);
    picOneController =
        TextEditingController(text: widget.projectModel.photo![0]);
    picTwoController =
        TextEditingController(text: widget.projectModel.photo![1]);
    picThreeController =
        TextEditingController(text: widget.projectModel.photo![2]);
    picFourController =
        TextEditingController(text: widget.projectModel.photo![3]);


    return BlocConsumer<ProjectCubit,ProjectState>(
        listener: (context , state){},
        builder: (context , state){
          return SingleChildScrollView(
            child: Form(
              key: updateKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  BuildTextFormFieldCourses(
                      label: "category", controller: categoryController!),
                  BuildTextFormFieldCourses(
                      label: "Details", controller: detailsController!),
                  BuildTextFormFieldCourses(
                      label: "Date", controller: dateController!),
                  BuildTextFormFieldCourses(
                      label: "Location", controller: locationController!),
                  BuildTextFormFieldCourses(
                      label: "Image", controller: imageController!),
                  BuildTextFormFieldCourses(
                      label: "UID", controller: idController!),
                  BuildTextFormFieldCourses(
                      label: "Picture One", controller: picOneController!),
                  BuildTextFormFieldCourses(
                      label: "Picture Two", controller: picTwoController!),
                  BuildTextFormFieldCourses(
                      label: "Picture Three",
                      controller: picThreeController!),
                  BuildTextFormFieldCourses(
                      label: "Picture Four", controller: picFourController!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        height: MediaQuery.of(context).size.height * .06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            ProjectModel projectModel = ProjectModel(
                                id: idController!.text,
                                category: categoryController!.text,
                                date: dateController!.text,
                                details: detailsController!.text,
                                iamge: imageController!.text,
                                location: locationController!.text,
                                photo: [
                                  picOneController!.text,
                                  picTwoController!.text,
                                  picThreeController!.text,
                                  picFourController!.text,
                                ]);

                            if (updateKey.currentState!.validate()) {
                              ProjectCubit.get(context)
                                  .buildUpdateDocumentFunction(
                                  id: widget.projectModel.id!,
                                  model: projectModel.toMap()).then((value) {
                                FirebaseMessaging.instance.unsubscribeFromTopic('all');
                                FirebaseMessaging.instance
                                    .unsubscribeFromTopic(constantvar.Uid);
                                FirebaseAuth.instance.signOut().then((value) {
                                  CacheHelper.clearData(key: "uId");

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                                    return const LoginViewApp();


                                  }));
                                });
                              }) ;


                            }
                          },
                          child: const Text("Update"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        height: MediaQuery.of(context).size.height * .06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            if (updateKey.currentState!.validate()) {
                              ProjectCubit.get(context)
                                  .buildDeleteDocumentFunction(
                                uid: widget.projectModel.id!,
                              )
                                  .then((value) {
                                FirebaseAuth.instance.signOut().then((value) {
                                  CacheHelper.clearData(key: "uId");

                                }); // testphonix
                              });
                            }
                          },
                          child: const Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
