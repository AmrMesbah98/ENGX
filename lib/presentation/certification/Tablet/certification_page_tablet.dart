import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../Dashbord.dart';
import '../../../bloc/Certification/certification_cubit.dart';
import '../../../model/Certification_model.dart';
import '../../../shared/components/components.dart';

class CertificationPageTablet extends StatelessWidget {
  CertificationPageTablet({super.key, required this.certificationModel});

  CertificationModel certificationModel;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  yearDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  validateState() {
    if (certificationModel.stateCourses == "ONLINE") {
      return "0000";
    } else {
      return "1111";
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[400]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * .08),
            Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Image(
                    image: AssetImage("assets/images/certificatee.png"),
                    //image: AssetImage("assets/images/oldCertificate.png"),
                  ),
                ),

                //column text certificate
                Positioned(
                  top: height * .02.h,
                  left: width * .135.w,
                  child: Column(
                    children: [
                      Text(
                        'CERTIFICATE',
                        style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4),
                      ),
                      SizedBox(height: 3.h),
                      Text('OF APPRECIATION',
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2)),
                      SizedBox(height: 1.h),
                      Text('PROUDLY PRESENTED TO',
                          style: TextStyle(
                            fontSize: 7.sp,
                          )),
                    ],
                  ),
                ),

                // name
                Positioned(
                  top: height * .097.h,
                  left: width * .033.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .85,
                          child: Text(certificationModel.name!,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  letterSpacing: 1),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),

                // name courses
                Positioned(
                  // top: height*.135,
                  top: height * .124.h,
                  left: width * .038.w,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * .83,
                      child: Text(
                        "FOR ACHIEVING ${certificationModel.nameCourses!} DIPLOMA",
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.black,
                            letterSpacing: 1),
                        textAlign: TextAlign.center,
                      )),
                ),

                // grade
                certificationModel.grade == 'GOOD' ||
                        certificationModel.grade == 'NONE'
                    ? Positioned(
                        top: height * .1105.h,
                        left: width * .16.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: Row(
                            children: [
                              Text(
                                "GRADE ${certificationModel.grade!} ( ${certificationModel.degree!}% )",
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.black,
                                    letterSpacing: 1),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Positioned(
                        top: height * .112.h,
                        left: width * .143.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: Row(
                            children: [
                              Text(
                                "GRADE ${certificationModel.grade!} ( ${certificationModel.degree!}% )",
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.black,
                                    letterSpacing: 1),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                //column text to pass
                Positioned(
                  top: height * .16.h,
                  left: width * .112.w,
                  child: Column(
                    children: [
                      Text('TO PASS A 6-MONTH TRAINING PERIOD',
                          style: TextStyle(
                            fontSize: 7.sp,
                          )),
                      Text('IN THE FIELD OF', style: TextStyle(fontSize: 7.sp)),
                      Text('HVAC, FIREFIGHTING, PLUMBING AND MEDICAL GAS',
                          style: TextStyle(fontSize: 7.sp)),
                      Text('THE APPLICATION HAS BEEN APPLIED TO MANY PROJECTS',
                          style: TextStyle(fontSize: 7.sp)),
                      Text('USING THE REVIT AND AUTOCAD SOFTWARE',
                          style: TextStyle(
                            fontSize: 7.sp,
                          )),
                    ],
                  ),
                ),

                //text date
                Positioned(
                  top: height * .210.h,
                  left: width * .135.w,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    child: Row(
                      children: [
                        Text(
                          'DATE',
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                // date
                Positioned(
                  // top: height*.23,
                  // left: width*.211,
                  top: height * .240.h,
                  left: width * .119.w,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    child: Row(
                      children: [
                        Text(
                          todayDate(),
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                // ENG.AHMED M. SHUHAYB
                Positioned(
                  // top: height*.23,
                  // left: width*.211,
                  top: height * .210.h,
                  left: width * .265.w,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'ENG.AHMED M. SHUHAYB',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Training Manger

                Positioned(
                  // top: height*.23,
                  // left: width*.211,
                  top: height * .240.h,
                  left: width * .275.w,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    child: Row(
                      children: [
                        Text(
                          'TRAINING MANAGER',
                          style: TextStyle(fontSize: 8.sp, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                // image logo engx
                Positioned(
                  top: height * .214.h,
                  left: width * .223.w,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 30.h),
                      child: Image(
                        image: const AssetImage('assets/images/ASEC.png'),
                        height: 25.h,
                      )),
                ),

                // text logo engx
                Positioned(
                  top: height * .255.h,
                  left: width * .226.w,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text(
                        'ENG-X',
                        style: TextStyle(
                            fontSize: 4.sp, fontWeight: FontWeight.w600),
                      )),
                ),

                // serial number
                Positioned(
                  top: height * .278.h,
                  left: width * .04.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: Row(
                      children: [
                        Text(
                          "Serial No. ${yearDate()}-${validateState()}-${certificationModel.serialNumber!}",
                          style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),

            /////////////////////////////////////////////////////////////////////////

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    CertificationCubit.get(context)
                        .acceptCertificateFunction(
                            name: certificationModel.name!,
                            grade: certificationModel.grade!,
                            nameCourses: certificationModel.nameCourses!,
                            stateCourses: certificationModel.stateCourses!,
                            degree: certificationModel.degree!,
                            serialNumber: certificationModel.serialNumber!)
                        .then((value) {
                      CertificationCubit.get(context).getCertificateAccpted();
                      CertificationCubit.get(context).getCertificate();

                      FirebaseFirestore.instance
                          .collection("certificate")
                          .doc(certificationModel.id!)
                          .delete();

                      navigateTo(context, DashBorad());

                      print("ALl Done Accepted Certificate");
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified, size: 30),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .01),
                        const Center(
                            child: Text(
                          "Accepted",
                          style: TextStyle(fontSize: 22),
                        )),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('certificate')
                        .doc(certificationModel.id)
                        .delete();
                    navigateTo(context, DashBorad());
                    CertificationCubit.get(context).getCertificate();
                    CertificationCubit.get(context).getCertificateAccpted();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified, size: 30),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .01),
                        const Center(
                            child: Text(
                          "Delete",
                          style: TextStyle(fontSize: 22),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
