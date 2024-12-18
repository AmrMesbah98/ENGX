import 'package:asec_application/ADS/ads.dart';
import 'package:asec_application/Widget/date_picker.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:asec_application/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/Certification/certification_cubit.dart';
import '../homepage/homepage.dart';
import 'accept_user.dart';
import 'accpted_certiccation.dart';
import 'make_certificate.dart';

class ChoosesState extends StatelessWidget {
  const ChoosesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chooses Operator",
          style: TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),

      ),
      body: SizedBox(
        width: double.infinity,
        height: 900,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Image(
                image: const AssetImage("assets/images/ASEC.png"),
                fit: BoxFit.fill,
                width: 200.w,
                height: 200.h,
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: () {
                  navigateTo(context, MakeCertification());

                  // disable for few time
                  // this is ADS
                 // Ads().showAdsTwo();

                },

                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .2,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.engineering, size: 60),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Center(
                          child: Text(
                        "Make Certification",
                        style: TextStyle(fontSize: 25),
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              GestureDetector(
                onTap: () {
                  navigateTo(context, const AcceptedCertification());
                  // disable for few time
                  // this is ADS
                 // Ads().showAdsTwo();
          
                  CertificationCubit.get(context).getCertificateAccpted();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .2,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified, size: 60),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Center(
                          child: Text(
                        "Approved Certification",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      )),
                    ],
                  ),
                ),
              ),
          
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}
