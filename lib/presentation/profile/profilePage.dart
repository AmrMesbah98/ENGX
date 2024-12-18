
import 'package:asec_application/shared/components/components.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/CV/cv_control_cubit.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../Info_Character/buildInfoScreen.dart';
import 'Edit_profile.dart';
import 'edit_cv.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {


  @override
  void initState() {
    CvControlCubit.get(context).cvCubit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();

    var codeCountry = "+20";
    List typeList = [
      "Male",
      "Female",
    ];
    List positionList = [
      "Student",
      "Engineer",
      "Manger",
      "Senior",
      "Other",
    ];

    String selectedValueType = "Male";
    String selectedValuePosition = "Other";

    var userApp = UserAppInformationCubit.get(context).applicationUser;
    var uID = FirebaseAuth.instance.currentUser!.uid;

    return BlocConsumer<UserAppInformationCubit, UserInformationState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userApp = UserAppInformationCubit.get(context).applicationUser;
        var profileImage = UserAppInformationCubit.get(context).profileImage;

        firstNameController.text = userApp!.firstName;
        lastNameController.text = userApp.lastName;
        phoneController.text = userApp.phone;
        emailController.text = userApp.email;
        addressController.text = userApp.address;
        return Scaffold(
          body: SafeArea(
            child: ListView(
              children: [
                // image and logo
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 120.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/procover.png"),
                                fit: BoxFit.fill
                            ),
                          ),




                        ),
                      ),
                      const Align(
                       alignment: Alignment.bottomLeft,

                           child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 45,
                              backgroundImage:
                                   AssetImage("assets/images/engx.png"),
                            ),
                          ),


                      ),
                    ],
                  ),
                ),
                // space
                const SizedBox(
                  height: 5,
                ),
                // Button of Edit profile
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 40,
                          child: OutlinedButton(
                              onPressed: () {
                                navigateTo(context, EditProFilePage());
                              },
                              child: const Text("EDIT PROFILE"))),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height* .01,),
                // button of edit cv

                /*
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 40,
                          child: OutlinedButton(
                              onPressed: () {
                                navigateTo(context, EditCv(cvModelEdit:CvControlCubit.get(context).cvCubit! ,));
                              },
                              child: const Text("EDIT CV"))),
                    ),
                  ],
                ),

                 */
                // space
                const SizedBox(
                  height: 20,
                ),
                // show the details
                BuildInfoScreen(
                  firstName: UserAppInformationCubit.get(context).applicationUser!.firstName,
                  lastname: UserAppInformationCubit.get(context).applicationUser!.lastName,
                  email: UserAppInformationCubit.get(context).applicationUser!.email,
                  phone: UserAppInformationCubit.get(context).applicationUser!.phone,
                  address: UserAppInformationCubit.get(context).applicationUser!.address,
                  position: UserAppInformationCubit.get(context).applicationUser!.position,
                  type: UserAppInformationCubit.get(context).applicationUser!.type,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
