import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Dashbord.dart';
import '../../bloc/Certification/certification_cubit.dart';
import '../../model/Certification_model.dart';
import 'Tablet/certification_page_tablet.dart';

class CertificationPage extends StatelessWidget {
  CertificationPage({super.key, required this.certificationModel});

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
    return Scaffold(body: LayoutBuilder(builder: (context, constrain) {
      if (constrain.maxWidth < 600) {
        return Container(
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
                    top: height * .02,
                    left: width * .24,
                    child: const Column(
                      children: [
                        Text(
                          'CERTIFICATE',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4),
                        ),
                        SizedBox(height: 3),
                        Text('OF APPRECIATION',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2)),
                        SizedBox(height: 1),
                        Text('PROUDLY PRESENTED TO',
                            style: TextStyle(
                              fontSize: 9,
                            )),
                      ],
                    ),
                  ),

                  // name
                  Positioned(
                    top: height * .101,
                    left: width * .06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Text(certificationModel.name!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 1),
                                textAlign: TextAlign.center)),
                      ],
                    ),
                  ),

                  // name courses
                  Positioned(
                    // top: height*.135,
                    top: height * .13,
                    left: width * .09,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * .83,
                        child: Text(
                          "FOR ACHIEVING ${certificationModel.nameCourses!} DIPLOMA",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              letterSpacing: 1),
                          textAlign: TextAlign.center,
                        )),
                  ),

                  // grade
                  certificationModel.grade == 'GOOD' ||
                          certificationModel.grade == 'NONE'
                      ? Positioned(
                          top: height * .1105,
                          left: width * .32,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: Row(
                              children: [
                                Text(
                                  "GRADE ${certificationModel.grade!} ( ${certificationModel.degree!}% )",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      letterSpacing: 1),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Positioned(
                          top: height * .1105,
                          left: width * .28,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            child: Row(
                              children: [
                                Text(
                                  "GRADE ${certificationModel.grade!} ( ${certificationModel.degree!}% )",
                                  style: const TextStyle(
                                      fontSize: 10,
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
                    top: height * .17,
                    left: width * .23,
                    child: const Column(
                      children: [
                        Text('TO PASS A 6-MONTH TRAINING PERIOD',
                            style: TextStyle(
                              fontSize: 7,
                            )),
                        Text('IN THE FIELD OF', style: TextStyle(fontSize: 7)),
                        Text('HVAC, FIREFIGHTING, PLUMBING AND MEDICAL GAS',
                            style: TextStyle(fontSize: 7)),
                        Text(
                            'THE APPLICATION HAS BEEN APPLIED TO MANY PROJECTS',
                            style: TextStyle(fontSize: 7)),
                        Text('USING THE REVIT AND AUTOCAD SOFTWARE',
                            style: TextStyle(
                              fontSize: 7,
                            )),
                      ],
                    ),
                  ),

                  //text date
                  Positioned(
                    top: height * .200,
                    left: width * .277,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          Text(
                            'DATE',
                            style: TextStyle(
                                fontSize: 8,
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
                    top: height * .230,
                    left: width * .25,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          Text(
                            todayDate(),
                            style: const TextStyle(
                                fontSize: 8,
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
                    top: height * .200,
                    left: width * .54,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'ENG.AHMED M. SHUHAYB',
                                style: TextStyle(
                                    fontSize: 8,
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
                    top: height * .230,
                    left: width * .55,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          Text(
                            'TRAINING MANAGER',
                            style: TextStyle(fontSize: 8, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // image logo engx
                  Positioned(
                    top: height * .204,
                    left: width * .441,
                    child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        child: Image(
                          image: AssetImage('assets/images/ASEC.png'),
                          height: 25,
                        )),
                  ),

                  // text logo engx
                  Positioned(
                    top: height * .227,
                    left: width * .457,
                    child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        child: Text(
                          'ENG-X',
                          style: TextStyle(
                              fontSize: 4, fontWeight: FontWeight.w600),
                        )),
                  ),

                  // serial number
                  Positioned(
                    top: height * .265,
                    left: width * .09,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          Text(
                            "Serial No. ${yearDate()}-${validateState()}-${certificationModel.serialNumber!}",
                            style: const TextStyle(
                                fontSize: 7,
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
        );
      } else if (constrain.maxWidth < 900) {
        return Center(
            child: CertificationPageTablet(
                certificationModel: constantvar.certificationModel!
                //certificationModel: CertificationCubit.get(context).certificateList[index],
                ));
      } else {
        return const Center(child: Text("Desktop"));
      }
    }));
  }
}
