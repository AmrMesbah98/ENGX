import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/publicNotification/publicnotification_cubit.dart';
import '../../login/customTextFormField.dart';

class FcmPublicTablet extends StatefulWidget {
  const FcmPublicTablet({super.key});

  @override
  State<FcmPublicTablet> createState() => _FcmPublicTabletState();
}

class _FcmPublicTabletState extends State<FcmPublicTablet> {
  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  GlobalKey<FormState> keyFCMPublic = GlobalKey();

  clear() {
    titleController.clear();
    bodyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(),
        child: Form(
          key: keyFCMPublic,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage("assets/images/ASEC.png"),
                    width: MediaQuery.of(context).size.width * .5,
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
                  GestureDetector(
                    onTap: () async {
                      if (keyFCMPublic.currentState!.validate()) {
                        await PublicNotificationCubit.get(context)
                            .sendPublicNotification(
                                titleController.text, bodyController.text);

                        await PublicNotificationCubit.get(context)
                            .seFcm(fcm: bodyController.text, date: todayDate())
                            .then((value) async {
                          await clear();

                          var snackBar = SnackBar(
                            content: Text(
                              "Notification Sent",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .7,
                        height: MediaQuery.of(context).size.height * .085,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xFFe5e5e5), Colors.white60],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          "Send Public Notification",
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
