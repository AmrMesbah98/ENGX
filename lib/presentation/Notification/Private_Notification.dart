import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/person_FCM/individual_notification_cubit.dart';
import '../login/customTextFormField.dart';

class FcmPerson extends StatefulWidget {
  FcmPerson({super.key, required this.Userid});

  QueryDocumentSnapshot Userid;

  @override
  State<FcmPerson> createState() => _FcmPersonState();
}

class _FcmPersonState extends State<FcmPerson> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  GlobalKey<FormState> keyFCM = GlobalKey();

  clear() {
    titleController.clear();
    bodyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black54),
        title: const Text(
          "Individual Notification",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Form(
          key: keyFCM,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage("assets/images/ASEC.png"),
                    width: MediaQuery.of(context).size.width * .7,
                    height: MediaQuery.of(context).size.height * .3,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                  label: "Title",
                  icon: Icons.textsms_outlined,
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  secure: false,
                  maxLine: 1),
              const SizedBox(height: 20),
              CustomTextFormField(
                  label: "Body",
                  icon: Icons.textsms_outlined,
                  keyboardType: TextInputType.text,
                  controller: bodyController,
                  secure: false,
                  maxLine: 1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[200],
                          padding: const EdgeInsets.all(10),
                          shape: const RoundedRectangleBorder()),
                      onPressed: () async {
                        if (keyFCM.currentState!.validate()) {
                          await IndividualNotificationCubit.get(context)
                              .sendIndividualNotification(titleController.text,
                                  bodyController.text, widget.Userid.id);
                          await clear();

                          var snackBar = SnackBar(
                            content: Text(
                              "${bodyController.text}",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        "Send Private Notification",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
