import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/PodCast/pod_cast_cubit.dart';
import 'package:asec_application/presentation/Settings/Tablet/settingsTablet.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:asec_application/zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../Developer_Team/Developer_Team.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../bloc/loclization/bloc_cubit.dart';
import '../../bloc/profile/profile_cubit.dart';
import '../../generated/l10n.dart';
import '../../master.dart';
import '../../shared_prefrance/shard_prefrance.dart';
import '../Work/presentation/manager/get_work_cubit.dart';
import '../chats/presentation/view/chatUsers_screen.dart';
import '../chats/presentation/view/chat_screen.dart';
import '../podcast/videosPage.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../whatsUp/whatsuo_Page.dart';
import '../zoom_video/bim.dart';
import 'contact us.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late FirebaseAuth _mAuth;

  @override
  void initState() {
    UserAppInformationCubit.get(context).applicationUser;
    ZoomMeetingCubit.get(context).getZoomMeetingVideo();

    PodCastCubit.get(context).podCastList;
    GetWorkCubit.get(context).getAllJobs();

    _mAuth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<blockManagement, cubitState>(
      listener: (context, state) async {
        if (state is successStateAr) {
          print("Arabic");
          await CacheHelper.saveData(key: 'languages', value: constantvar.lang);
        }
        if (state is successStateEn) {
          print("English");
          await CacheHelper.saveData(key: 'languages', value: constantvar.lang);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Master();
                  }));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            flexibleSpace: Container(
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
            ),
            iconTheme: const IconThemeData(color: Colors.black54),
            elevation: 0,
            centerTitle: true,
            title: Text(
              S.of(context).settings,
              style: TextStyle(color: ColorManager.Black),
            ),
          ),
          body: LayoutBuilder(builder: (context, constrain) {
            if (constrain.maxWidth < 600) {
              return UserAppInformationCubit.get(context).applicationUser ==
                      null
                  ? const CircularProgressIndicator()
                  : SafeArea(
                      child: Container(
                        height: 800.h,
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
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for test

                                /*
                                                                    ElevatedButton(onPressed: (){




                                                    FirebaseFirestore.instance
                                                        .collection('User Application')
                                                        .get()
                                                        .then(
                              (value) => value.docs.forEach(
                                (element) {
                              var docRef = FirebaseFirestore.instance
                                  .collection('User Application')
                                  .doc(element.id);

                              docRef.update({'updateCode': 1});
                                                        },
                                                      ),
                                                    );




                                        }, child: const Text("Update")),

                                                         */

                                /*
                                  ElevatedButton(onPressed: (){




                                    FirebaseFirestore.instance
                                        .collection('User Application')
                                        .get()
                                        .then(
                                          (value) => value.docs.forEach(
                                            (element) {
                                          var docRef = FirebaseFirestore.instance
                                              .collection('User Application')
                                              .doc(element.id);

                                          docRef.update({
                                            "arrayMsg": [
                                              {'msg': 'Welcome', 'uid': 'fNxe5mBrhVUYqZXAAZ1fVbOt2ju2'},
                                            ],
                                          });
                                        },
                                      ),
                                    );




                                  }, child: const Text("array test")),


                                   */

                                //image

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: AppSize.s20),
                                        child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: const AssetImage(
                                                "assets/images/person22.png"),
                                            backgroundColor: Colors.grey[300]),
                                      ),
                                      SizedBox(height: 8.h),
                                      //welcome + name
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            S.of(context).Welcome,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            UserAppInformationCubit.get(context)
                                                .applicationUser!
                                                .firstName,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      //space
                                      SizedBox(height: 7.h),
                                      //become instructor
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return WhatsUp();
                                          }));
                                        },
                                        child: Text(
                                          S.of(context).BecomeAnInstructor,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /*
                                                     GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                        return const OrderProject();
                                                      }));
                                                    },
                                                    child: buildRow(Icons.file_copy, S.of(context).orderProject, () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                        return const OrderProject();
                                                      }));
                                                    }),
                                              ),
                                               */

                                SizedBox(height: 20.h),

                                //text profile
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                //space
                                SizedBox(
                                  height: 5.h,
                                ),
                                //divider
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black54,
                                ),
                                //space
                                SizedBox(
                                  height: 10.h,
                                ),

                                const CardInfoForSetting(),

                                const SizedBox(height: 30),

                                //old ui setting
                                // AcceptedCertification
                                /*
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const AcceptedCertification();
                                      }));
                                    },
                                    child: buildRow(Icons.verified,
                                        S.of(context).AccptedCertification, () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const AcceptedCertification();
                                      }));
                                    }),
                                  ),

                                  SizedBox(height: 10.h),

                                  // update loading courses

                                  /*
                              GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: S.of(context).coursesUpdate,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[200],
                                      textColor: Colors.black,
                                      fontSize: 15.sp);
                                },
                                child: buildRow(
                                    Icons.videocam, S.of(context).courses, () {
                                  Fluttertoast.showToast(
                                      msg: S.of(context).coursesUpdate,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[200],
                                      textColor: Colors.black,
                                      fontSize: 15.sp);
                                }),
                              ),
                               */

                                  /*
                              // quiz
                                                        GestureDetector(
                              onTap: () {


                              },

                              child: buildRow(
                                Icons.co2, "Quiz",

                                  (){
                                  navigateTo(context, QuizPage());
                                  }


                              )

                                                        ),
                                                         */

                                  // PodCast

                                  GestureDetector(
                                    onTap: () {
                                      navigateTo(context, const VideosPage());

                                      /*
                                           Fluttertoast.showToast(
                                    msg: S.of(context).coursesUpdate,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[200],
                                    textColor: Colors.black,
                                    fontSize: 15.sp);
                                 */
                                    },
                                    child: buildRow(
                                        Icons.mic, S.of(context).BroadCast, () {
                                      navigateTo(context, const VideosPage());

                                      /*
                                           Fluttertoast.showToast(
                                    msg: S.of(context).coursesUpdate,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[200],
                                    textColor: Colors.black,
                                    fontSize: 15.sp);
                                 */
                                    }),
                                  ),

                                  SizedBox(height: 10.h),
                                  // update loading zoom meeting

                                  GestureDetector(
                                    onTap: () {
                                      navigateTo(
                                          context, const ShowAllZoomVideo());
                                      /*
                                Fluttertoast.showToast(
                                    msg: S.of(context).ZoomUpdate,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[200],
                                    textColor: Colors.black,
                                    fontSize: 15.sp);

                                 */
                                    },
                                    child: buildRow(
                                        Icons.center_focus_strong_rounded,
                                        "Discuss Videos", () {
                                      navigateTo(context, const MasterZoom());
                                      //navigateTo(context,  const ShowAllZoomVideo());
                                      /*
                                Fluttertoast.showToast(
                                    msg: S.of(context).ZoomUpdate,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[200],
                                    textColor: Colors.black,
                                    fontSize: 15.sp);

                                     */
                                    }),
                                  ),

                                  SizedBox(height: 10.h),

                                  // lang
                                  /*
                                                        Padding(
                              padding: const EdgeInsets.all(AppSize.s12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).arabic,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  blockManagement
                                      .get(context)
                                      .buildSwitchLang(),
                                  Text(
                                    S.of(context).english,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                                                        ),

                                                         */

                                  // live meeting

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return LiveZoomMeetingPage();
                                      }));
                                    },
                                    child: buildRow(Icons.groups, "Live Meeting",
                                        () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return LiveZoomMeetingPage();
                                      }));
                                    }),
                                  ),

                                  SizedBox(height: 10.h),

                                  // development team

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const DeveloperPage();
                                      }));
                                    },
                                    child: buildRow(
                                        Icons.person, S.of(context).DeveloperTeam,
                                        () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const DeveloperPage();
                                      }));
                                    }),
                                  ),

                                  SizedBox(height: 10.h),
                                  // contact us
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const ContactUs();
                                      }));
                                    },
                                    child: buildRow(Icons.headset_mic,
                                        S.of(context).contactUs, () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const ContactUs();
                                      }));
                                    }),
                                  ),

                                  // job

                                  /*
                              SizedBox(
                                width:MediaQuery.of(context).size.width,
                                height: 45.h,
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context,index){
                                    return GestureDetector(
                                      onTap: () {


                                        navigateTo(context, const GetAllJobs());



                                        /*
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                              return  GetAllJobs(
                                                jopModel: GetWorkCubit.get(context).jobList,
                                                id: GetWorkCubit.get(context).jobList[index].id,
                                              );
                                            }));
                                         */



                                      },
                                      child: buildRow(
                                          Icons.work_history, "Jobs",
                                              () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                                  return GetAllJobs();


                                                }));
                                          }),
                                    );
                                  },

                                ),
                              ),
                               */

                                  // test screenshot to pdf
                                  /*
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return  ScreenShotToPdf();
                                      }));
                                },
                                child: buildRow(
                                    Icons.person, "test pdf",
                                        () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                            return  ScreenShotToPdf();
                                          }));
                                    }),
                              ),

                               */

                                  // Courses video
                                  /*
                                                        GestureDetector(
                              onTap: () {
                                navigateTo(context, const ShowAllCourses());
                              },
                              child: buildRow(
                                  Icons.video_camera_back, "Courses video",
                                      () {
                                        navigateTo(context, const ShowAllCourses());
                                  }),
                                                        ),

                                                         */

                                  //space
                                  SizedBox(
                                    height: 15.h,
                                  ),

                                  // logout
                                  /*
                               GestureDetector(
                                onTap: () {
                                  FirebaseMessaging.instance
                                      .unsubscribeFromTopic('all');
                                  FirebaseMessaging.instance
                                      .unsubscribeFromTopic(constantvar.Uid);
                                  _mAuth.signOut().then((value) {
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
                                    PaymentCubit().close();

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (_) {
                                          return const LoginViewApp();
                                        }));
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  height: MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      S.of(context).logout,
                                      style:  TextStyle(
                                          fontSize: 20.sp, color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                               */

                                   */
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            } else if (constrain.maxWidth < 900) {
              return Center(child: SettingsTablet());
            } else {
              return const Center(child: Text("Desktop"));
            }
          }),

          /*
            floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (FirebaseAuth.instance.currentUser!.email ==
                  "admin@gmail.com") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) {
                      return ChatUsersScreen(
                        userModel: ProfileCubit.get(context).userList,
                      );
                    }));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) {
                      return ChatScreen();
                    }));
              }
            },
        backgroundColor: Colors.grey,
        elevation: 4,
        splashColor: Colors.grey,
        child: const Icon(Icons.chat, color: Colors.white, size:25,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,

             */

          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
            children: [
              //chat
              FloatingActionButton.small(
                heroTag: null,
                child: const Icon(
                  Icons.chat_outlined,
                ),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser!.email ==
                      "admin@gmail.com") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ChatUsersScreen(
                        userModel: ProfileCubit.get(context).userList,
                      );
                    }));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ChatScreen();
                    }));
                  }
                },
              ),

              //whatsapp
              FloatingActionButton.small(
                heroTag: null,
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
                ),
                onPressed: () async {
                  await launchWhatsAppAhmed();
                },
              ),

              //telegram
              FloatingActionButton.small(
                heroTag: null,
                child: const Icon(
                  FontAwesomeIcons.telegram,
                ),
                onPressed: () async {
                  await launch(
                    //"https://t.me/+ZxaZb4iA_RI4ZmVk",
                    "https://t.me/Shuhayb33",
                    forceSafariVC: false,
                    forceWebView: false,
                    headers: <String, String>{
                      'my_header_key': 'my_header_value'
                    },
                  );
                },
              ),

              //facebook
              FloatingActionButton.small(
                heroTag: null,
                child: const Icon(
                  FontAwesomeIcons.facebook,
                ),
                onPressed: () async {
                  await launch(
                    "https://www.facebook.com/AHMEDSHUHAYB16",
                    forceSafariVC: false,
                    forceWebView: false,
                    headers: <String, String>{
                      'my_header_key': 'my_header_value'
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  buildRow(IconData icon, String title, Function() Route) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child: GestureDetector(
        onTap: Route,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 13.sp),
            ),
            const Spacer(),
            IconButton(
                onPressed: Route,
                icon: const Icon(Icons.keyboard_double_arrow_right))
          ],
        ),
      ),
    );
  }

  launchWhatsAppAhmed() async {
    const link = WhatsAppUnilink(
      phoneNumber: "+201093460618",
    );
    await launch('$link');
  }
}

class CardInfoForSetting extends StatelessWidget {
  const CardInfoForSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BuildCard(
          iconData: Icons.mic,
          //data: podCast,
          text: 'PodCast',
          fun: () {
            navigateTo(context, const VideosPage());
          },
        ),
        BuildCard(
          iconData: Icons.center_focus_strong_rounded,
          //data: discussVideos,
          text: 'Discuss Videos',
          fun: () {
            navigateTo(context, const MasterZoom());
          },
        ),
        // developer team
        BuildCard(
          iconData: Icons.person,
          //data: developerTeam,
          text: 'Developer Team',
          fun: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const DeveloperPage();
            }));
          },
        ),
        // contact us
        BuildCard(
          iconData: Icons.headset_mic,
          //data: contactUs,
          text: 'Contact us',
          fun: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ContactUs();
            }));
          },
        ),
      ],
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard(
      {super.key,
      required this.iconData,
      required this.text,
      required this.fun});

  final IconData iconData;
  final String text;
  final Function() fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: fun,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(
                iconData,
                color: Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: IconButton(
                    onPressed: fun,
                    icon: const Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Colors.black54,
                    ))),
          ],
        ),
      ),
    );
  }
}

class CardInfoForSupport extends StatelessWidget {
  const CardInfoForSupport({
    super.key,
    required this.support,
    required this.edit,
    required this.logout,
  });

  final String support;
  final String edit;
  final String logout;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BuildCardForSupport(
          iconData: Icons.support_agent_outlined,
          text: support,
          fun: () {},
        ),
        BuildCardForSupport(
          iconData: Icons.edit_rounded,
          text: edit,
          fun: () {},
        ),
      ],
    );
  }
}

class BuildCardForSupport extends StatelessWidget {
  const BuildCardForSupport(
      {super.key,
      required this.iconData,
      required this.text,
      required this.fun});

  final IconData iconData;
  final String text;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: GestureDetector(
        onTap: () {
          fun();
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff999999),
              child: Icon(
                iconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
