import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/profile/profilePage.dart';
import 'package:asec_application/presentation/whatsUp/whatsuo_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Dashbord.dart';
import '../../Developer_Team/Developer_Team.dart';
import '../../bloc/Auth/auth_cubit.dart';
import '../../bloc/delete_Doc/delete_doc_cubit.dart';
import '../../bloc/get_courses/courses_cubit.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../bloc/get_project/project_cubit.dart';
import '../../bloc/get_topFive/top_five_cubit.dart';
import '../../firebase_services/firestore_service.dart';
import '../../generated/l10n.dart';
import '../../shared/components/components.dart';
import '../../shared_prefrance/shard_prefrance.dart';
import '../CV/cv_share.dart';
import '../CV/cv_view.dart';
import '../Posts/reviewPost.dart';
import '../Settings/contact us.dart';
import '../certification/ChoosesOperator.dart';
import '../login/login_view.dart';

class buildDrawerPage extends StatefulWidget {
  buildDrawerPage({super.key});

  @override
  State<buildDrawerPage> createState() => _buildDrawerPageState();
}

class _buildDrawerPageState extends State<buildDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAppInformationCubit, UserInformationState>(
      listener: (context, state) {
        if (state is LoadingInformationState) {
          const Center(child: LinearProgressIndicator());
        }
      },
      builder: (context, state) {
        if (state is LoadingInformationState) {
          return const Center(child: LinearProgressIndicator());
        } else {
          return UserAppInformationCubit.get(context).applicationUser! != null
              ? Drawer(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      DrawerHeader(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: UserAccountsDrawerHeader(
                            decoration: const BoxDecoration(),
                            accountName: (state is LoadingInformationState)
                                ? const CircularProgressIndicator()
                                : Text(
                                    "${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                            accountEmail: (state is LoadingInformationState)
                                ? const CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () {
                                      launchURL();
                                    },
                                    child: Container(
                                      child: const Text(
                                        "https://asec.work",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                            currentAccountPictureSize: const Size.square(40),
                            currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: (state is LoadingInformationState)
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "${UserAppInformationCubit.get(context).applicationUser!.firstName[0].toUpperCase()}${UserAppInformationCubit.get(context).applicationUser!.lastName[0].toUpperCase()}",
                                        style: const TextStyle(
                                            color: Colors.black))), //
                          )),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text(' My Profile '),
                              onTap: () {
                                navigateTo(context, const ProFilePage());
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.card_membership),
                              title: const Text('Certification'),
                              onTap: () {
                                navigateTo(context, const ChoosesState());
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.contact_page),
                              title: const Text('CV Share'),
                              onTap: () {
                                // if(isAdLoaded)
                                // {
                                //   interstitialAd.show();
                                // }

                                navigateTo(context, ShareCV());
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.find_in_page),
                              title: const Text('CV Search'),
                              onTap: () {
                                navigateTo(context, Search_CV());
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.group_work_outlined),
                              title: Text(
                                FirebaseAuth.instance.currentUser!.email ==
                                        "admin@gmail.com"
                                    ? "DashBoard"
                                    : S.of(context).contactUs,
                              ),
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser!.email ==
                                    "admin@gmail.com") {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return DashBorad();
                                  }));
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const ContactUs();
                                  }));
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.add),
                              title: Text(
                                FirebaseAuth.instance.currentUser!.email ==
                                        "admin@gmail.com"
                                    ? S.of(context).reviewPost
                                    : S.of(context).whatsapp,
                              ),
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser!.email ==
                                    "admin@gmail.com") {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const ReviewPost();
                                  }));
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return WhatsUp();
                                  }));
                                }
                              },
                            ),
                            /*
                      ListTile(
                        leading: const Icon(Icons.workspace_premium),
                        title: const Text('Go Premium'),
                        onTap: () {
                          navigateTo(context, const GoldenMember());
                        },
                      ),

                       */
                            ListTile(
                              leading:
                                  const Icon(Icons.account_circle_outlined),
                              title: const Text('Developer'),
                              onTap: () {
                                navigateTo(context, const DeveloperPage());
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.sensor_door_outlined),
                              title: Text(S.of(context).logout),
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
                                  GetInstructorCubit(FireStoreService())
                                      .close();
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
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: IconButton(
                                    onPressed: () async {
                                      await launch(
                                        "https://t.me/+ZxaZb4iA_RI4ZmVk",
                                        forceSafariVC: false,
                                        forceWebView: false,
                                        headers: <String, String>{
                                          'my_header_key': 'my_header_value'
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.telegram,
                                      color: Colors.blue,
                                    ),
                                    iconSize: 45,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .04),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: LinearProgressIndicator(),
                );
        }
      },
    );
  }

  launchURL() async {
    final Uri url = Uri.parse('https://asec.work/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }
}

/*
buildDrawerPage(BuildContext ctx) {

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;


  interstitialAdFunction()
  {
    InterstitialAd.load(
        adUnitId: '',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad)
            {
              interstitialAd = ad;
              isAdLoaded = true;
            },
            onAdFailedToLoad: onAdFailedToLoad
        )
    );
  }





  return BlocConsumer<UserAppInformationCubit, UserInformationState>(
    listener: (context, state) {},
    builder: (context, state) {
      return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFe5e5e5),
                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(),
                  accountName: (state is LoadingInformationState)
                      ? const CircularProgressIndicator()
                      : Text(
                          UserAppInformationCubit.get(context)
                              .applicationUser!
                              .firstName,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                  accountEmail: (state is LoadingInformationState)
                      ? const CircularProgressIndicator()
                      : Text(
                          UserAppInformationCubit.get(context)
                              .applicationUser!
                              .email,
                          style: const TextStyle(color: Colors.black),
                        ),
                  currentAccountPictureSize: const Size.square(40),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: (state is LoadingInformationState)
                          ? const CircularProgressIndicator()
                          : Text(
                              UserAppInformationCubit.get(context)
                                  .applicationUser!
                                  .firstName[0],
                              style: const TextStyle(color: Colors.black))), //
                )),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {



                navigateTo(ctx, const ProFilePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text('Go Premium'),
              onTap: () {
                navigateTo(ctx, const GoldenMember());
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('CV Share'),
              onTap: () {
                navigateTo(ctx, ShareCV());
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Developer'),
              onTap: () {
                navigateTo(ctx, const DeveloperPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.find_in_page),
              title: const Text('CV Search'),
              onTap: () {



                navigateTo(ctx, Search_CV());
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_work_outlined),
              title: Text(
                FirebaseAuth.instance.currentUser!.email == "admin@gmail.com"
                    ? S.of(context).message
                    : S.of(context).contactUs,
              ),
              onTap: () {
                if (FirebaseAuth.instance.currentUser!.email ==
                    "admin@gmail.com") {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DashBorad();
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ContactUs();
                  }));
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.group_work_outlined),
              title: Text(
                FirebaseAuth.instance.currentUser!.email == "admin@gmail.com"
                    ? S.of(context).reviewPost
                    : S.of(context).privacyPolicy,
              ),
              onTap: () {
                if (FirebaseAuth.instance.currentUser!.email ==
                    "admin@gmail.com") {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ReviewPost();
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ContactUs();
                  }));
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.sensor_door_outlined),
              title:  Text(S.of(context).logout),
              onTap: (){
                FirebaseMessaging.instance.unsubscribeFromTopic('all');
                FirebaseMessaging.instance
                    .unsubscribeFromTopic(constantvar.Uid);
                FirebaseAuth.instance.signOut().then((value) {
                  CacheHelper.clearData(key: "uId");



                  GetTopFiveCubit(FireStoreService()).close();
                  GetCoursesCubit(FireStoreService()).close();
                  ProjectCubit(FireStoreService()).close();
                  GetInstructorCubit(FireStoreService()).close();
                  UserAppInformationCubit(FireStoreService()).close();
                  DeleteDocCubit(FireStoreService()).close();
                  AuthCubit().close();
                  PaymentCubit().close();



                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                    return const LoginViewApp();
                  }));
                });
              },
            ),

          ],
        ),
      );
    },
  );
}


 */
