import 'package:asec_application/bloc/Certification/certification_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'ChoosesOperator.dart';
import 'accept_user.dart';
import 'certification_Page.dart';

class AcceptedCertification extends StatelessWidget {
  const AcceptedCertification({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CertificationCubit, CertificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Accepted Certification",
              style: TextStyle(color: Colors.black54),),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black54),

            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            height: 900,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount:CertificationCubit.get(context).accptedCertificate.length,
                itemBuilder:(context,index)
                {
                  return GestureDetector(
                    onTap: (){

                      navigateTo(context, CertificationUser(certificationModel:CertificationCubit.get(context).accptedCertificate[index] ,));
                    },
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          child: Column(
                            children: [
                              CustomBuildItemApprove(label:CertificationCubit.get(context).accptedCertificate[index].name! , icon: Icons.person),
                              CustomBuildItemApprove(label:CertificationCubit.get(context).accptedCertificate[index].nameCourses! , icon: Icons.receipt_long),
                              CustomBuildItemApprove(label:"${CertificationCubit.get(context).accptedCertificate[index].degree!}" , icon: Icons.account_balance_rounded),
                              CustomBuildItemApprove(label:CertificationCubit.get(context).accptedCertificate[index].grade! , icon: Icons.grading_rounded),
                              CustomBuildItemApprove(label:CertificationCubit.get(context).accptedCertificate[index].stateCourses! , icon: Icons.code_rounded),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),

        );
      },
    );
  }
}

class CustomBuildItemApprove extends StatelessWidget {
  CustomBuildItemApprove({super.key, required this.icon, required this.label});


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
