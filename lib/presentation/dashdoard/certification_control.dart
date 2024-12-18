import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/Certification/certification_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Dashbord.dart';
import '../certification/certification_Page.dart';

class CertificateControl extends StatelessWidget {
  const CertificateControl({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CertificationCubit, CertificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("CertificationPage Control",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),

          ),
          body: Container(
              width: MediaQuery.of(context) .size.width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:CertificationCubit.get(context).certificateList.length,
                  itemBuilder: (context, index)
                  {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]
                            ),
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   CustomBuildItem(icon: Icons.person, label: CertificationCubit.get(context).certificateList[index].name!),
                                   CustomBuildItem(icon: Icons.safety_check_outlined, label: CertificationCubit.get(context).certificateList[index].nameCourses!),
                                    CustomBuildItem(icon: Icons.accessibility_new_sharp, label: CertificationCubit.get(context).certificateList[index].grade!),
                                  CustomBuildItem(icon: Icons.rotate_90_degrees_ccw, label: "${CertificationCubit.get(context).certificateList[index].degree!}"),
                                   CustomBuildItem(icon: Icons.recycling, label: CertificationCubit.get(context).certificateList[index].stateCourses!),
                                  ],
                                ),
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                          child: ElevatedButton(
                              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
                              onPressed: (){

                                /*
                                CertificationCubit.get(context).acceptCertificateFunction(
                                    name: CertificationCubit.get(context).certificateList[index].name!,
                                    grade: CertificationCubit.get(context).certificateList[index].grade!,
                                    nameCourses: CertificationCubit.get(context).certificateList[index].nameCourses!,
                                    stateCourses: CertificationCubit.get(context).certificateList[index].stateCourses!,
                                    degree: CertificationCubit.get(context).certificateList[index].degree!
                                ).then((value) {



                                  print("ALl Done Accepted Certificate");

                                });

                                 */

                                navigateTo(context, CertificationPage(certificationModel: constantvar.certificationModel= CertificationCubit.get(context).certificateList[index],));



                              }, child: const Text("See certificate",style: TextStyle(color: Colors.black),)
                          ),
                        )
                      ],
                    );
                  }
              )
          ),
        );
      },
    );
  }
}


class CustomBuildItem extends StatelessWidget {
   CustomBuildItem({super.key, required this.icon, required this.label});
  
  
  IconData icon ;
  String label;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(width: MediaQuery.of(context).size.width *.01,),
          Text(label,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}

