import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/Settings/settings.dart';
import 'package:asec_application/presentation/whatsUp/whatsuo_Page.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/Auth/auth_cubit.dart';
import '../../bloc/delete_Doc/delete_doc_cubit.dart';
import '../../bloc/get_courses/courses_cubit.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../bloc/get_project/project_cubit.dart';
import '../../bloc/get_topFive/top_five_cubit.dart';
import '../../firebase_services/firestore_service.dart';
import '../../shared_prefrance/shard_prefrance.dart';
import '../login/login_view.dart';
import '../profile/Edit_profile.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
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

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            title: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: SafeArea(
            child: Container(
              color: Colors.white54,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),

                    // image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          maxRadius: 65,
                          backgroundImage:
                              const AssetImage("assets/images/person22.png"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    // first & last Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${userApp.firstName} ${userApp.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20.sp),
                        )
                      ],
                    ),
                    // email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userApp.email,
                          style: TextStyle(fontSize: 12.sp),
                        )
                      ],
                    ),
                    // space
                    SizedBox(
                      height: 15.h,
                    ),
                    // position
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.local_police_sharp),
                        Text(
                          userApp.position,
                          style: TextStyle(fontSize: 18.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    // list of Data
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 400.h,
                      child: ListView(
                        children: [
                          // Edit Profile
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, const EditProFilePage());
                            },
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.privacy_tip_sharp,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          // space
                          SizedBox(
                            height: 10.h,
                          ),
                          // Purchase History
                          GestureDetector(
                            onTap: () {
                              var snackBar = SnackBar(
                                content: Text(
                                  "In New Update ....",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.history,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Purchase History',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),

                          // space
                          SizedBox(
                            height: 10.h,
                          ),

                          // help & support
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, WhatsUp());
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListTile(
                                leading: Icon(Icons.help_outline,
                                    color: Colors.black54),
                                title: Text(
                                  'Help & Support',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          // space
                          SizedBox(
                            height: 10.h,
                          ),
                          // settings
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, Settings());
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.privacy_tip_sharp,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Settings',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          ),
                          // space
                          SizedBox(
                            height: 10.h,
                          ),

                          // logout
                          GestureDetector(
                            onTap: () {
                              FirebaseMessaging.instance
                                  .unsubscribeFromTopic('all');
                              FirebaseMessaging.instance
                                  .unsubscribeFromTopic(constantvar.Uid);
                              FirebaseAuth.instance.signOut().then((value) {
                                CacheHelper.clearData(key: "uId");

                                GetTopFiveCubit(FireStoreService()).close();
                                GetCoursesCubit(FireStoreService()).close();
                                ProjectCubit(FireStoreService()).close();
                                GetInstructorCubit(FireStoreService()).close();
                                UserAppInformationCubit(FireStoreService())
                                    .close();
                                DeleteDocCubit(FireStoreService()).close();
                                AuthCubit().close();

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const LoginViewApp();
                                }));
                              });
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
