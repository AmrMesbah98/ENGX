import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/PodCast/pod_cast_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:asec_application/zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Developer_Team/Developer_Team.dart';
import '../../../bloc/get_information/user_information_cubit.dart';
import '../../../bloc/loclization/bloc_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../shared_prefrance/shard_prefrance.dart';
import '../../../zoomVideo/presentation/view/zoomVideoPage.dart';
import '../../certification/accpted_certiccation.dart';
import '../../podcast/videosPage.dart';
import '../../resources/values_manager.dart';
import '../../whatsUp/whatsuo_Page.dart';
import '../contact us.dart';

class SettingsTablet extends StatefulWidget {
  @override
  State<SettingsTablet> createState() => _SettingsTabletState();
}

class _SettingsTabletState extends State<SettingsTablet> {
  late FirebaseAuth _mAuth;

  @override
  void initState() {
    UserAppInformationCubit.get(context).applicationUser;
    ZoomMeetingCubit.get(context).getZoomMeetingVideo();

    PodCastCubit.get(context).podCastList;

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
          body: UserAppInformationCubit.get(context).applicationUser == null
              ? const CircularProgressIndicator()
              : SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                      child: Column(
                        children: [
                          SizedBox(height: 80.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).Welcome,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  UserAppInformationCubit.get(context)
                                      .applicationUser!
                                      .firstName,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),

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

                          SizedBox(height: 10.h),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: AppSize.s20),
                                  child: CircleAvatar(
                                      radius: 100,
                                      backgroundImage: const AssetImage(
                                          "assets/images/person22.png"),
                                      backgroundColor: Colors.grey[300]),
                                ),
                                SizedBox(height: 20.h),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return WhatsUp();
                                    }));
                                  },
                                  child: Text(
                                    S.of(context).BecomeAnInstructor,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black54),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                )
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

                          //SizedBox(height: 5.h,),

                          // AcceptedCertification

                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const AcceptedCertification();
                              }));
                            },
                            child: buildRowTablet(Icons.verified,
                                S.of(context).AccptedCertification, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const AcceptedCertification();
                              }));
                            }),
                          ),

                          /*
                     // update loading courses

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
                      child: buildRowTablet(
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
                            child: buildRowTablet(
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

                          // update loading zoom meeting

                          GestureDetector(
                            onTap: () {
                              navigateTo(context, const ShowAllZoomVideo());
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
                            child: buildRowTablet(
                                Icons.center_focus_strong_rounded,
                                "Discuss Videos", () {
                              navigateTo(context, const ShowAllZoomVideo());
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

                          /*
                            GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return LiveZoomMeetingPage();
                              }));
                            },
                            child: buildRowTablet(Icons.groups, "Live Meeting",
                                () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return LiveZoomMeetingPage();
                              }));
                            }),
                          ),
                           */

                          // development team

                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const DeveloperPage();
                              }));
                            },
                            child: buildRowTablet(
                                Icons.person, S.of(context).DeveloperTeam, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const DeveloperPage();
                              }));
                            }),
                          ),

                          // contact us
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const ContactUs();
                              }));
                            },
                            child: buildRowTablet(
                                Icons.person, S.of(context).contactUs, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const ContactUs();
                              }));
                            }),
                          ),

                          /*
                     // work

                    SizedBox(
                      width:MediaQuery.of(context).size.width,
                      height: 45.h,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                    return  GetAllJobs(

                                    );
                                  }));
                            },
                            child: buildRow(
                                Icons.work_history, "Jobs",
                                    () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return GetAllJobs(

                                        );
                                      }));
                                }),
                          );
                        },

                      ),
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
                            height: 25.h,
                          ),

                          /*
                       // logout
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
                                fontSize: 15.sp, color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                     */

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
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

  buildRowTablet(IconData icon, String title, Function() Route) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: GestureDetector(
        onTap: Route,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 11.5.sp),
            ),
            const Spacer(),
            IconButton(
                onPressed: Route,
                icon: const Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 25,
                ))
          ],
        ),
      ),
    );
  }
}
