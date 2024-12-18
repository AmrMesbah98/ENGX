import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/Notification/show_notification.dart';
import 'package:asec_application/presentation/homepage/tablet/list_details_tablet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../Dashbord.dart';
import '../../../Widget/homepageWidget.dart';
import '../../../bloc/Auth/auth_cubit.dart';
import '../../../bloc/Free_Courses/free_courses_cubit.dart';
import '../../../bloc/delete_Doc/delete_doc_cubit.dart';
import '../../../bloc/get_courses/courses_cubit.dart';
import '../../../bloc/get_information/user_information_cubit.dart';
import '../../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../../bloc/get_package/get_package_cubit.dart';
import '../../../bloc/get_project/project_cubit.dart';
import '../../../bloc/get_topFive/top_five_cubit.dart';
import '../../../bloc/news/news_cubit.dart';
import '../../../firebase_services/firestore_service.dart';
import '../../../generated/l10n.dart';
import '../../../model/free_courses_model/free_courses_model.dart';
import '../../../model/free_courses_model/inner_free_courses_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared_prefrance/shard_prefrance.dart';
import '../../CV/cv_share.dart';
import '../../CV/cv_view.dart';
import '../../Free_Courses/innerFreeCouses.dart';
import '../../Instructor/Instructor.dart';
import '../../Instructor/detailInstructorr.dart';
import '../../Settings/contact us.dart';
import '../../Top_Five/TopFive.dart';
import '../../Top_Five/TopFiveDetails.dart';
import '../../Work/presentation/manager/get_work_cubit.dart';
import '../../Work/presentation/view/get_all_jobs.dart';
import '../../Work/presentation/view/get_details_job.dart';
import '../../certification/ChoosesOperator.dart';
import '../../courses/See_more_Courses.dart';
import '../../courses/outer/Details_Courses.dart';
import '../../courses/see more free courses.dart';
import '../../login/login_view.dart';
import '../../package/details_package.dart';
import '../../profile/profilePage.dart';
import '../../resources/values_manager.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({super.key});

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  launchURL() async {
    final Uri url = Uri.parse('https://asec.work/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }

  final scrollController = ScrollController();
  final searchController = TextEditingController();
  bool showLast = false;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /*
    showFunction() {
    if (constantvar.mainShow == null) {
      print(" for test is ===== >>>> ${constantvar.showState}");
      return WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase(
              [_showTestOne, _showTestTwo, _showTestThree, _showTestFour]));
    } else {}
  }
   */

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: Row(
        children: [
          //drawer
          Expanded(
            flex: 1,
            child: BlocConsumer<UserAppInformationCubit, UserInformationState>(
              listener: (context, state) {
                if (state is GetRequestJobsSuccess) {
                  navigateTo(
                      context,
                      GetDetailsJob(
                        innerRequestModel:
                            GetWorkCubit.get(context).innerRequestList,
                        id: constantvar.idWork,
                      ));
                }
              },
              builder: (context, state) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      DrawerHeader(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFffffff),
                                  Colors.grey[100]!,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFffffff),
                                    Colors.grey[100]!,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            accountName: (state is LoadingInformationState)
                                ? const LinearProgressIndicator()
                                : Text(
                                    "${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                            accountEmail: (state is LoadingInformationState)
                                ? const LinearProgressIndicator()
                                : GestureDetector(
                                    onTap: () {
                                      launchURL();
                                    },
                                    child: const Row(
                                      children: [
                                        FaIcon(FontAwesomeIcons.linkedin),
                                        Text(
                                          " LinkedIn",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                            currentAccountPictureSize: const Size.square(40),
                            currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: (state is LoadingInformationState)
                                    ? const LinearProgressIndicator()
                                    : Text(
                                        "${UserAppInformationCubit.get(context).applicationUser!.firstName[0].toUpperCase()}${UserAppInformationCubit.get(context).applicationUser!.lastName[0].toUpperCase()}",
                                        style: const TextStyle(
                                            color: Colors.black))),

                            //
                          )),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          ' My Profile ',
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
                        onTap: () {
                          navigateTo(context, const ProFilePage());
                        },
                      ),
                      SizedBox(height: 15.h),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(
                          ' Notification ',
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
                        onTap: () {
                          navigateTo(context, const NotificationPage());
                        },
                      ),
                      SizedBox(height: 15.h),
                      ListTile(
                        leading: const Icon(Icons.card_membership),
                        title: Text(
                          'Certification',
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
                        onTap: () {
                          navigateTo(context, const ChoosesState());
                        },
                      ),
                      SizedBox(height: 15.h),
                      ListTile(
                        leading: const Icon(Icons.contact_page),
                        title: Text(
                          'CV Share',
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
                        onTap: () {
                          // if(isAdLoaded)
                          // {
                          //   interstitialAd.show();
                          // }

                          // Ads().showAdsOne();

                          navigateTo(context, ShareCV());
                        },
                      ),
                      SizedBox(height: 15.h),
                      ListTile(
                        leading: const Icon(Icons.find_in_page),
                        title: Text(
                          'CV Search',
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
                        onTap: () {
                          navigateTo(context, Search_CV());
                        },
                      ),
                      SizedBox(height: 15.h),
                      ListTile(
                        leading: FirebaseAuth.instance.currentUser!.email ==
                                "admin@gmail.com"
                            ? const Icon(Icons.group_work_outlined)
                            : const Icon(Icons.headset_mic),
                        title: Text(
                          FirebaseAuth.instance.currentUser!.email ==
                                  "admin@gmail.com"
                              ? "DashBoard"
                              : S.of(context).contactUs,
                          style: TextStyle(fontSize: 6.5.sp),
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
                      //SizedBox(height: 15.h),
                      //review post and whatsapp
                      /*
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: Text(
                          FirebaseAuth.instance.currentUser!.email ==
                                  "admin@gmail.com"
                              ? S.of(context).reviewPost
                              : S.of(context).whatsapp,
                          style: TextStyle(fontSize: 6.5.sp),
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

                       */
                      SizedBox(height: 15.h),
                      /*
                        ListTile(
                        leading: const Icon(Icons.groups),
                        title: Text(
                          'Zoom Meeting',
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
                        onTap: () {
                          navigateTo(context, LiveZoomMeetingPage());
                        },
                      ),
                       */

                      SizedBox(height: 15.h),
                      ListTile(
                        leading: const Icon(Icons.sensor_door_outlined),
                        title: Text(
                          S.of(context).logout,
                          style: TextStyle(fontSize: 6.5.sp),
                        ),
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
                            UserAppInformationCubit(FireStoreService()).close();
                            DeleteDocCubit(FireStoreService()).close();
                            AuthCubit().close();

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return const LoginViewApp();
                            }));
                          });
                        },
                      ),
                      SizedBox(height: 10.h),
                      const Spacer(),
                      //row for icon social media
                      Row(
                        children: [
                          const Spacer(),

                          //facebook                            //facebook
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: IconButton(
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
                              icon: const Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              ),
                              iconSize: 35,
                            ),
                          ),
                          //whatsapp
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: IconButton(
                              onPressed: () async {
                                await launchWhatsAppAhmed();
                              },
                              icon: const Icon(
                                FontAwesomeIcons.whatsappSquare,
                                color: Colors.green,
                              ),
                              iconSize: 35,
                            ),
                          ),
                          //telegram
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
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
                              icon: const Icon(
                                FontAwesomeIcons.telegram,
                                color: Colors.blue,
                              ),
                              iconSize: 35,
                            ),
                          ),
                        ],
                      ),

                      /*
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
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

                       */
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                                iconSize: 15.w,
                              ),
                            ),
                          ),
                          /*
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                                  FontAwesomeIcons.facebook,
                                  color: Colors.blue,
                                ),
                                iconSize: 15.w,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                                  FontAwesomeIcons.squareWhatsapp,
                                  color: Color(0xff25D366),
                                ),
                                iconSize: 15.w,
                              ),
                            ),
                          ),

                           */
                        ],
                      ),

                       */

                      SizedBox(height: 10.h),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .04),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFFFF),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        // label of top five
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.w,
                                  right: 8.w,
                                  top: 15.h,
                                  bottom: 6.5.h),
                              child: Text(
                                "Top Ten",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                        // space
                        SizedBox(height: 6.h),
                        // item of top five
                        SizedBox(
                          width: double.infinity,
                          height: 65.h,
                          child: BlocBuilder<GetTopFiveCubit, TopFiveState>(
                            builder: (context, state) {
                              if (state is ErrorTopFiveState) {
                                return Text(state.errMessage);
                              } else if (state is SuccessTopFiveState) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    //state.TopFiveCharacter.length,
                                    itemCount: state.TopFiveCharacter.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("Top Five")
                                                .doc(
                                                  state.TopFiveCharacter[index]
                                                      .id!,
                                                )
                                                .collection("RateOfUser")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get()
                                                .then((value) {
                                              print(
                                                  "my rate is one two ${constantvar.rateUserTopFive}");
                                              constantvar.rateUserTopFive =
                                                  value.data()?["oldRate"] ?? 0;
                                              print(
                                                  "my rate is ${constantvar.rateUserTopFive}");
                                            }).then((value) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return TopFiveDetails(
                                                  topFiveModel: constantvar
                                                          .topFiveModel =
                                                      state.TopFiveCharacter[
                                                          index],
                                                  id: state
                                                      .TopFiveCharacter[index]
                                                      .id!,
                                                );
                                              }));
                                            });
                                          },
                                          child: CircleAvatarUITablet(
                                              image: state
                                                  .TopFiveCharacter[index]
                                                  .image!,
                                              id: state.TopFiveCharacter[index]
                                                  .id!));
                                    });
                              }
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey.shade300,
                                ),
                              );
                            },
                          ),
                        ),
                        // space
                        SizedBox(height: 10.h),
                        // slider
                        BlocConsumer<NewsCubit, NewsState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .16,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24)),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        NewsCubit.get(context).newsModel.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .64,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          child: Column(
                                            children: [
                                              Opacity(
                                                opacity: .5,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .64,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .06,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(24),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      24))),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.w,
                                                            vertical: 6.h),
                                                    child: Text(
                                                      NewsCubit.get(context)
                                                          .newsModel[index]
                                                          .title!,
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .85,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .07,
                                                child: Center(
                                                    child: Text(
                                                  NewsCubit.get(context)
                                                      .newsModel[index]
                                                      .description!,
                                                  style: const TextStyle(
                                                      height: 1.4,
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .009),
                                              Opacity(
                                                opacity: 0.8,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          24),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      24))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .01),
                                                        const Icon(
                                                          Icons.calendar_month,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          NewsCubit.get(context)
                                                              .newsModel[index]
                                                              .date!,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: height * .01),
                        // label jobs
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s10,
                                  horizontal: AppSize.s8),
                              child: Text(
                                "Jobs",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),

                            //for see more

                            const Spacer(),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const GetAllJobs();
                                  }));
                                },
                                child: Text(
                                  S.of(context).SeeMore,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        // item  jobs
                        SizedBox(
                          width: double.infinity,
                          height: 180.h,
                          child: SizedBox(
                            height: 180.h,
                            child: GetWorkCubit.get(context).jobList.isNotEmpty
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    //itemCount: GetWorkCubit.get(context).jobList.length,
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          constantvar.idWork =
                                              GetWorkCubit.get(context)
                                                  .jobList[index]
                                                  .id!;

                                          GetWorkCubit.get(context)
                                              .getRequestCollection(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //image
                                                  Container(
                                                      width: 55.w,
                                                      height: 75.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        //child: Image(image: NetworkImage(widget.jopModel[index].image!,),width: 40.w,height: 40.h,),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: GetWorkCubit
                                                                  .get(context)
                                                              .jobList[index]
                                                              .image!,
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment
                                                              .topCenter,
                                                          height: 55.h,
                                                          width: 55.w,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(Icons
                                                                  .cloud_off_outlined),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer
                                                                  .fromColors(
                                                            baseColor: Colors
                                                                .grey.shade400,
                                                            highlightColor:
                                                                Colors.grey
                                                                    .shade200,
                                                            child:
                                                                const SizedBox(
                                                              width: 200,
                                                              height: 200,
                                                            ),
                                                          ),
                                                        ),
                                                      )),

                                                  //space
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),

                                                  //details
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        GetWorkCubit.get(
                                                                context)
                                                            .jobList[index]
                                                            .code!,
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit
                                                                  .get(context)
                                                              .jobList[index]
                                                              .company!,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          icon:
                                                              Icons.apartment),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit
                                                                  .get(context)
                                                              .jobList[index]
                                                              .location!,
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  Colors.grey),
                                                          icon: Icons
                                                              .location_on),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit
                                                                  .get(context)
                                                              .jobList[index]
                                                              .phone!,
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  Colors.grey),
                                                          icon: Icons
                                                              .phone_android),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit
                                                                  .get(context)
                                                              .jobList[index]
                                                              .email!,
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  Colors.grey),
                                                          icon: Icons.email),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                    ],
                                                  ),

                                                  //icon
                                                  const Icon(
                                                    Icons.bookmark,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),

                                              //row for date
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    GetWorkCubit.get(context)
                                                        .jobList[index]
                                                        .date!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 200.w,
                                        height: 200.h,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // label Free Courses
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s10,
                                  horizontal: AppSize.s8),
                              child: Text(
                                "Free Courses",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),

                            //for see more

                            const Spacer(),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s8),
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context, const ShowAllFreeCourses());
                                },
                                child: Text(
                                  S.of(context).SeeMore,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // space
                        const SizedBox(height: AppSize.s10),
                        // item  Free Courses
                        SizedBox(
                          width: double.infinity,
                          height: 120.h,
                          child:
                              BlocBuilder<FreeCoursesCubit, FreeCoursesState>(
                            builder: (context, state) {
                              if (state is GetFreeCoursesError) {
                                return Text(state.errMessage!);
                              } else if (state is GetFreeCoursesSuccess) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        List<FreeCoursesModel> freeCoursesList =
                                            [];
                                        List<InnerFreeCoursesModel>
                                            innerFreeCoursesList = [];

                                        FirebaseFirestore.instance
                                            .collection("Free Courses")
                                            .doc(
                                              FreeCoursesCubit.get(context)
                                                  .freeCoursesList[index]
                                                  .id!,
                                            )
                                            .collection("RateOfUser")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get()
                                            .then((value) {
                                          print(
                                              "my rate is one two ${constantvar.rateUserFreeCourses}");
                                          constantvar.rateUserFreeCourses =
                                              value.data()?["oldRate"] ?? 0;
                                          print(
                                              "my rate is ${constantvar.rateUserFreeCourses}");
                                        }).then((value) {
                                          constantvar.idFreeCoursesCategory =
                                              FreeCoursesCubit.get(context)
                                                  .freeCoursesList[index]
                                                  .id!;

                                          FirebaseFirestore.instance
                                              .collection("Free Courses")
                                              .doc(constantvar
                                                  .idFreeCoursesCategory)
                                              .collection("innerCollection")
                                              .get()
                                              .then((value) {
                                            innerFreeCoursesList = [];

                                            for (var doc in value.docs) {
                                              innerFreeCoursesList.add(
                                                  InnerFreeCoursesModel
                                                      .fromJson(doc));
                                            }
                                          }).then((value) {
                                            navigateTo(
                                                context,
                                                InnerFreeCoursesPage(
                                                  innerFreeCoursesModel:
                                                      innerFreeCoursesList,
                                                  id: constantvar
                                                      .idFreeCoursesCategory!,
                                                  freeCoursesModel: constantvar
                                                          .freeCoursesModel =
                                                      FreeCoursesCubit.get(
                                                                  context)
                                                              .freeCoursesList[
                                                          index],
                                                ));

                                            print(
                                                "inner free courses success >>>>> ");
                                          });
                                        });

                                        // FreeCoursesCubit.get(context)
                                        //     .getSecondCategory(context);
                                      },
                                      child: buildHorizontalFreeCoursesListTab(
                                        context,
                                        FreeCoursesCubit.get(context)
                                            .freeCoursesList[index]
                                            .image!,
                                        FreeCoursesCubit.get(context)
                                            .freeCoursesList[index]
                                            .title!,
                                        FreeCoursesCubit.get(context)
                                            .freeCoursesList[index]
                                            .rate!,
                                      ),
                                    );
                                  },
                                  itemCount: 4,
                                );
                              }
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  color: Colors.grey.shade300,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: AppSize.s15),

                        // label paid Courses
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s10,
                                  horizontal: AppSize.s8),
                              child: Text(
                                "Paid Course",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const ShowAllCourses();
                                  }));
                                },
                                child: Text(
                                  S.of(context).SeeMore,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // space
                        const SizedBox(height: AppSize.s10),
                        // item paid Courses
                        SizedBox(
                          width: double.infinity,
                          height: 120.h,
                          child: BlocBuilder<GetCoursesCubit, CoursesState>(
                            builder: (context, state) {
                              if (state is GetCoursesFailure) {
                                return Text(state.errMessage);
                              } else if (state is GetCoursesSuccess) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection("all courses")
                                            .doc(
                                              state.courses[index].id!,
                                            )
                                            .collection("RateOfUser")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get()
                                            .then((value) {
                                          print(
                                              "my rate is one two ${constantvar.rateUserCourses}");
                                          constantvar.rateUserCourses =
                                              value.data()?["oldRate"] ?? 0;
                                          print(
                                              "my rate is ${constantvar.rateUserCourses}");
                                        }).then((value) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (_) {
                                            return DetailsCourses(
                                              coursesModel:
                                                  constantvar.coursesModel =
                                                      state.courses[index],
                                              id: GetCoursesCubit.get(context)
                                                  .coursesModelList[index]
                                                  .id,
                                              rate: GetCoursesCubit.get(context)
                                                  .coursesModelList[index]
                                                  .rate,
                                            );
                                          }));
                                        });
                                      },
                                      child: buildHorizontalListTablet(
                                        context,
                                        state.courses[index].images!,
                                        state.courses[index].nameCourse!,
                                        state.courses[index].nameInstructor!,
                                        state.courses[index].price!,
                                        state.courses[index].rate!,
                                      ),
                                    );
                                  },
                                  itemCount: 3,
                                );
                              }
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  color: Colors.grey.shade300,
                                ),
                              );
                            },
                          ),
                        ),

                        // label package
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSize.s5, horizontal: AppSize.s8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).packageCourses,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        // item package
                        BlocBuilder<GetPackageCubit, GetPackageState>(
                          builder: (context, state) {
                            if (state is GetPackageError) {
                              return Text(state.errMessage);
                            } else if (state is GetPackageSuccess) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.height * .4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.packageCourses.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection("package")
                                            .doc(
                                              state.packageCourses[index].id!,
                                            )
                                            .collection("RateOfUser")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get()
                                            .then((value) {
                                          print(
                                              "my rate is one two ${constantvar.rateUserPackage}");
                                          constantvar.rateUserPackage =
                                              value.data()?["oldRate"] ?? 0;
                                          print(
                                              "my rate is ${constantvar.rateUserPackage}");
                                        }).then((value) {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return DetailsPackage(
                                              packageCourses: constantvar
                                                      .packageCoursesModel =
                                                  state.packageCourses[index],
                                              id: constantvar
                                                  .packageCoursesModel!.id,
                                            );
                                          }));
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: state
                                                .packageCourses[index].images!,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.topCenter,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            errorWidget: (context, url,
                                                    error) =>
                                                const Icon(
                                                    Icons.cloud_off_outlined),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey.shade400,
                                              highlightColor:
                                                  Colors.grey.shade200,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.grey.shade300,
                                ),
                              );
                            }
                          },
                        ),

                        // this is project section (deactivated)

                        /*
                          // label project
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSize.s10, horizontal: AppSize.s8),
                            child: Text(
                              S.of(context).titleOfProject,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.s8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return ShowAllProject();
                                }));
                              },
                              child: Text(
                                S.of(context).SeeMore,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s10),
                      // item Project
                      SizedBox(
                        width: double.infinity,
                        height: 185.h,
                        child: BlocBuilder<ProjectCubit, ProjectState>(
                          builder: (context, state) {
                            if (state is GetProjectFailure) {
                              return Text(state.errMessage);
                            } else if (state is GetProjectSuccess) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return DetailsProjects(
                                              projectModel:
                                                  state.project[index],
                                            );
                                          }));
                                        },
                                        child: buildHorizontalListProject(
                                          context,
                                          state.project[index].iamge!,
                                          state.project[index].category!,
                                          state.project[index].date!,
                                          state.project[index].location!,
                                        ));
                                  });
                            }
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                color: Colors.grey.shade300,
                              ),
                            );
                          },
                        ),
                      ),
                       */

                        const SizedBox(height: AppSize.s5),

                        // label tec support
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s10,
                                  horizontal: AppSize.s8),
                              child: Text(
                                S.of(context).titleOfMonitor,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const AllInstructor();
                                  }));
                                },
                                child: Text(
                                  S.of(context).SeeMore,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // item tec support
                        const SizedBox(height: AppSize.s5),
                        SizedBox(
                          width: double.infinity,
                          height: 160.h,
                          child: BlocBuilder<GetInstructorCubit,
                              GetInstructorState>(
                            builder: (context, state) {
                              if (state is GetInstructorFailure) {
                                return Text(state.errMessage);
                              } else if (state is GetInstructorSuccess) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("all Instructor")
                                                .doc(
                                                  state.instructor[index].id!,
                                                )
                                                .collection("RateOfUser")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get()
                                                .then((value) {
                                              print(
                                                  "my rate is one two ${constantvar.rateUser}");
                                              constantvar.rateUser =
                                                  value.data()?["oldRate"] ?? 0;

                                              print(
                                                  "my rate is ${constantvar.rateUser}");
                                            }).then((value) async {
                                              await Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return DetailsMonitor(
                                                    instructorModel: constantvar
                                                            .instructorModel =
                                                        state.instructor[index],
                                                    id: constantvar
                                                        .instructorModel!.id!,
                                                    numberUserRate: constantvar
                                                        .instructorModel!
                                                        .numberUserRate!);
                                              }));
                                            });
                                          },
                                          child:
                                              buildHorizontalListMonitorTablet(
                                            state.instructor[index].image!,
                                            state.instructor[index].name!,
                                            state.instructor[index].id!,
                                          ));
                                    });
                              } else {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    color: Colors.grey.shade300,
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        //Technical Support section
                        /*
                        // space
                        const SizedBox(height: AppSize.s15),
                        // Technical Support section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[100],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 10.h),
                                    child: Row(
                                      children: [
                                        Showcase(
                                            key: _showTestFour,
                                            targetPadding:
                                                const EdgeInsets.all(5),
                                            descriptionPadding:
                                                const EdgeInsets.all(5),
                                            tooltipBackgroundColor:
                                                Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            targetShapeBorder:
                                                const CircleBorder(),
                                            description:
                                                "you can contact us by click on this button",
                                            onBarrierClick: () {
                                              constantvar.showState = true;
                                              CacheHelper.saveData(
                                                  key: "showLast",
                                                  value: constantvar.showState);
                                            },
                                            child: Text(
                                              "Technical Support",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            launchWhatsAppAhmed();
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .07,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey[200],
                                            ),
                                            child: Center(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .03,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.grey[100],
                                                  ),
                                                  child: const Center(
                                                      child: FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    color: Color(0xff25D366),
                                                  ))),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),

                         */

                        // space
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                      ],
                    ),
                  ))),

          /*
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.white24,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  navigateTo(context, MakeCertification());
                                  Ads().showAdsTwo();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.engineering,size: 30),
                                    SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                     Center(child: Text("Make Certification",style: TextStyle(fontSize: 10.sp),textAlign: TextAlign.center,)),
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*.04),
                              GestureDetector(
                                onTap: (){

                                  navigateTo(context, const AcceptedCertification());
                                  Ads().showAdsTwo();

                                  CertificationCubit.get(context).getCertificateAccpted();

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.9,
                                  height: MediaQuery.of(context).size.height*.2,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      const Icon(Icons.verified,size: 30),
                                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                       Center(child: Text("Approved Certification",style: TextStyle(color: Colors.black,fontSize: 10.sp),textAlign: TextAlign.center)),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  navigateTo(context,  ShareCV());
                                  Ads().showAdsTwo();

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.9,
                                  height: MediaQuery.of(context).size.height*.2,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      const Icon(Icons.post_add,size: 30),
                                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                      Center(child: Text("CV Share",style: TextStyle(color: Colors.black,fontSize: 10.sp),textAlign: TextAlign.center)),
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            navigateTo(context, const ContactUs());
                          },
                          child: Container(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                const Image(image: AssetImage("assets/images/ASEC.png"),),
                                Text("Contact Us",style: TextStyle(fontSize: 10.sp),)
                              ],
                            )
                          ),
                        ),
                        ),
                  ],
                ),
              )),
           */
        ],
      ),
    ));
  }
}

launchWhatsAppAhmed() async {
  const link = WhatsAppUnilink(
    phoneNumber: "+201093460618",
  );
  await launch('$link');
}

launchURL() async {
  final Uri url = Uri.parse('https://shorturl.at/qxPR5');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}

launchURLUpdateLink() async {
  final Uri url = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.asecappcompany.asec_application');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}

launchWhatsApp() async {
  const link = WhatsAppUnilink(
    phoneNumber: "+201124753420",
  );
  await launch('$link');
}

Row buildRowDetails(int index,
    {required String text, required TextStyle style, required IconData icon}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 20,
        color: Colors.black54,
      ),
      SizedBox(
        width: 7.w,
      ),
      Text(
        text,
        style: style,
      ),
    ],
  );
}
