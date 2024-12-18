import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/news/news_cubit.dart';
import 'package:asec_application/presentation/Work/presentation/manager/get_work_cubit.dart';
import 'package:asec_application/presentation/homepage/profile.dart';
import 'package:asec_application/presentation/homepage/tablet/homepage_tablet.dart';
import 'package:asec_application/presentation/new_Auth/new_login.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../Dashbord.dart';
import '../../Widget/homepageWidget.dart';
import '../../bloc/Auth/auth_cubit.dart';
import '../../bloc/DataId/id_data_cubit.dart';
import '../../bloc/PodCast/pod_cast_cubit.dart';
import '../../bloc/delete_Doc/delete_doc_cubit.dart';
import '../../bloc/get_courses/courses_cubit.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../bloc/get_project/project_cubit.dart';
import '../../bloc/get_topFive/top_five_cubit.dart';
import '../../firebase_services/firestore_service.dart';
import '../../generated/l10n.dart';
import '../../shared_prefrance/shard_prefrance.dart';
import '../../zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import '../CV/cv_share.dart';
import '../CV/cv_view.dart';
import '../DashBoard_Student/presentation/view/screen/loginTrainer.dart';
import '../Download/presentation/view/screen/download_screen.dart';
import '../Instructor/Instructor.dart';
import '../Instructor/detailInstructorr.dart';
import '../Notification/show_notification.dart';
import '../Settings/contact us.dart';
import '../Top_Five/TopFiveDetails.dart';
import '../Work/presentation/view/get_all_jobs.dart';
import '../Work/presentation/view/get_details_job.dart';
import '../one_click/presentation/view/screen/one_click_page.dart';
import '../resources/values_manager.dart';
import '../shorts/presentation/view/listview_shorts_widget.dart';

class MasterHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MasterHomePagee());
  }
}

class MasterHomePagee extends StatefulWidget {
  const MasterHomePagee({super.key});

  @override
  State<MasterHomePagee> createState() => _MasterHomePageeState();
}

bool _loading = true;

class _MasterHomePageeState extends State<MasterHomePagee> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  bool showLast = false;

  final GlobalKey _showTestOne = GlobalKey();
  final GlobalKey _showTestTwo = GlobalKey();
  final GlobalKey _showTestThree = GlobalKey();
  final GlobalKey _showTestFour = GlobalKey();

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  /*
  showFunction() {
    if (constantvar.mainShow == null) {
      print(" for test is ===== >>>> ${constantvar.showState}");
      return WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
                _showTestOne,
                _showTestTwo,
                _showTestThree,
                _showTestFour,
              ]));
    } else {}
  }
   */

  delatFuctoon() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      _loading = false;
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    delatFuctoon();
    GetInstructorCubit.get(context).geInstructor();

    IdDataCubit.get(context).getId();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showUpdateDialog());

    print("COde Uodate ====== >>>>>> ${constantvar.updateShowCode}");

    PodCastCubit.get(context).podCastList;
    ZoomMeetingCubit.get(context).zoomMeetingList;
    UserAppInformationCubit.get(context).applicationUser;
  }

  late AnimationController _controller;

  void _showUpdateDialog() {
    if (constantvar.updateShowCode == 1 &&
        constantvar.updateShowCodeUser == 1) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Available'),
            content: const Text(
                'A new version of the app is available. Please update to the latest version.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Update'),
                onPressed: () {
                  launchURLUpdateLink();

                  FirebaseFirestore.instance
                      .collection("User Application")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({"updateCode": 2});
                },
              ),
            ],
          );
        },
      );
    }
  }

  GlobalKey<ScaffoldState> homeKey = GlobalKey();

  var _currentIndex;

  @override
  Widget build(BuildContext context) {
    List<dynamic> model = GetTopFiveCubit.get(context).TopFiveList;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<GetWorkCubit, GetWorkState>(
      listener: (context, state) {
        if (state is GetRequestJobsSuccess) {
          navigateTo(
              context,
              GetDetailsJob(
                innerRequestModel: GetWorkCubit.get(context).innerRequestList,
                id: constantvar.idWork,
              ));
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: _loading,
          child: Scaffold(
            key: homeKey,
            backgroundColor: Colors.white,
            body: LayoutBuilder(
              builder: (context, constrain) {
                if (constrain.maxWidth < 600) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
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
                        child: Column(
                          children: [
                            // appbar
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 4.w),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        homeKey.currentState!.openDrawer();
                                      },
                                      child: const Icon(Icons.menu)),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        navigateTo(
                                            context, const NotificationPage());
                                      },
                                      icon: Icon(
                                        Icons.notifications_active,
                                        size: 25,
                                        color: Colors.grey[600],
                                      )),
                                  /*
                                     IconButton(
                                      onPressed: () {
                                        navigateTo(context, const RunTheme());
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size: 30,
                                        color: Colors.grey[600],
                                      )),
                                   */
                                ],
                              ),
                            ),
                            // space
                            SizedBox(height: 2.h),

                            //space
                            SizedBox(
                              height: 6.h,
                            ),
                            //listview Shorts
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: listviewShortsSection(),
                            ),
                            SizedBox(height: 6.h),
                            // label of the best
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(AppSize.s8),
                                  child: Text("The Best",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
                                      ),
                                ),
                                Spacer(),
                                Center(
                                  child: Shimmer.fromColors(
                                    period: const Duration(
                                        seconds: 2), // Adjust speed
                                    baseColor: Colors.white, // Default color
                                    highlightColor:
                                        Colors.blue, // Flowing color
                                    child: Icon(
                                      Icons.arrow_right_alt, // Arrow icon
                                      size: 50,
                                      color: Colors
                                          .white, // Base color (will be overridden by shimmer)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // space
                            SizedBox(height: 6.h),

                            SizedBox(
                              height: 280,
                              child: Skeletonizer(
                                enabled: _loading,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: model.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("Top Five")
                                                .doc(model[index].id)
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
                                                  topFiveModel:
                                                      constantvar.topFiveModel =
                                                          model[index],
                                                  id: model[index].id!,
                                                );
                                              }));
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: model[index].image!,
                                              fit: BoxFit.fill,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  // borderRadius: BorderRadius.circular(70)
                                                ),
                                              ),
                                              alignment: Alignment.topCenter,
                                              height: AppSize.s100,
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Icon(
                                                      Icons.cloud_off_outlined),
                                            ),
                                            // child: Image.network(
                                            //   imageUrl,
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),

                            ////////////////////////////////////////////////////////////

                            // label of note
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(AppSize.s8),
                                  child: Text("Note",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
                                      ),
                                ),
                              ],
                            ),
                            // slider
                            BlocConsumer<NewsCubit, NewsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .24,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: NewsCubit.get(context)
                                            .newsModel
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .9,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[200]!,
                                                      width: 10),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24)),
                                              child: Column(
                                                children: [
                                                  Opacity(
                                                    opacity: .5,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .9,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .09,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[200]!,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0))),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    15.w,
                                                                vertical: 5.h),
                                                        child: Text(
                                                          NewsCubit.get(context)
                                                              .newsModel[index]
                                                              .title!,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .009),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .85,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .12,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 20.h,
                                                        left: 5.w,
                                                        right: 5.h,
                                                      ),
                                                      child: Text(
                                                        NewsCubit.get(context)
                                                            .newsModel[index]
                                                            .description!,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .009),
                                                  Opacity(
                                                    opacity: 0.8,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          24),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          24))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                              Icons
                                                                  .calendar_month,
                                                              color:
                                                                  Colors.grey,
                                                              size: 20,
                                                            ),
                                                            Text(
                                                              NewsCubit.get(
                                                                      context)
                                                                  .newsModel[
                                                                      index]
                                                                  .date!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .grey,
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
                            // space
                            SizedBox(height: 8.h),
                            // label jobs
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s10,
                                      horizontal: AppSize.s8),
                                  child: Text("Jobs",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
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
                                        return GetAllJobs();
                                      }));
                                    },
                                    child: Text(S.of(context).SeeMore,
                                        style: TextStyle(fontSize: 12.sp)
                                        //Theme.of(context).textTheme.titleSmall,
                                        ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8.h),
                            // item  jobs

                            SizedBox(
                              width: double.infinity,
                              height: 170.h,
                              child: SizedBox(
                                height: 170.h,
                                child: GetWorkCubit.get(context)
                                        .jobList
                                        .isNotEmpty
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
                                                  .getRequestCollection(context)
                                                  .then((val) {});
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //image

                                                      Container(
                                                          width: 55.w,
                                                          height: 55.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: Colors
                                                                  .white10),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            //child: Image(image: NetworkImage(widget.jopModel[index].image!,),width: 40.w,height: 40.h,),
                                                            child: CachedNetworkImage(
                                                                imageUrl: GetWorkCubit
                                                                        .get(
                                                                            context)
                                                                    .jobList[
                                                                        index]
                                                                    .image!,
                                                                fit:
                                                                    BoxFit.fill,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                height: 55.h,
                                                                width: 55.w,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .cloud_off_outlined),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Container()),
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
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          buildRowDetails(index,
                                                              text: GetWorkCubit
                                                                      .get(
                                                                          context)
                                                                  .jobList[
                                                                      index]
                                                                  .company!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                              icon: Icons
                                                                  .apartment),
                                                          SizedBox(
                                                            height: 7.h,
                                                          ),
                                                          buildRowDetails(index,
                                                              text: GetWorkCubit
                                                                      .get(
                                                                          context)
                                                                  .jobList[
                                                                      index]
                                                                  .location!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey),
                                                              icon: Icons
                                                                  .location_on),
                                                          SizedBox(
                                                            height: 7.h,
                                                          ),
                                                          buildRowDetails(index,
                                                              text: GetWorkCubit
                                                                      .get(
                                                                          context)
                                                                  .jobList[
                                                                      index]
                                                                  .phone!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey),
                                                              icon: Icons
                                                                  .phone_android),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          buildRowDetails(index,
                                                              text: GetWorkCubit
                                                                      .get(
                                                                          context)
                                                                  .jobList[
                                                                      index]
                                                                  .email!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .grey),
                                                              icon:
                                                                  Icons.email),
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
                                                        GetWorkCubit.get(
                                                                context)
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

                            ////////////////////////////////////////////////////////////

                            // Data File
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(AppSize.s8),
                                  child: Text("Data File",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
                                      ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSize.s8),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(S.of(context).SeeMore,
                                        style: TextStyle(fontSize: 12.sp)
                                        //Theme.of(context).textTheme.titleSmall,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            // item of RevitFamily
                            SizedBox(height: 125, child: BookListPage()),

                            ////////////////////////////////////////////////////////////

                            /*
                            // label free Courses
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s8,
                                      horizontal: AppSize.s8),
                                  child: Text("Free Courses",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
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
                                    child: Text(S.of(context).SeeMore,
                                        style: TextStyle(fontSize: 12.sp)
                                        //Theme.of(context).textTheme.titleSmall,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            // space
                            SizedBox(height: 3.h),
                            // item  Free Courses
                            SizedBox(
                              width: double.infinity,
                              height: 165.h,
                              child: BlocBuilder<FreeCoursesCubit,
                                  FreeCoursesState>(
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
                                            List<FreeCoursesModel>
                                                freeCoursesList = [];
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
                                              constantvar
                                                      .idFreeCoursesCategory =
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
                                          child: buildHorizontalFreeCoursesList(
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
                                      itemCount: 3,
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            SizedBox(height: 8.h),
                             */

                            // label one click
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s8,
                                      horizontal: AppSize.s8),
                                  child: Text("Services in one click",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
                                      ),
                                ),
                              ],
                            ),
                            // space
                            SizedBox(height: 15.h),
                            // item of one click
                            const OneClick(),

                            /*
                                     // label Content
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s8,
                                      horizontal: AppSize.s8),
                                  child: Text("Paid Courses",
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
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
                                    child: Text(S.of(context).SeeMore,
                                        style: TextStyle(fontSize: 12.sp)
                                        //Theme.of(context).textTheme.titleSmall,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            // space
                            SizedBox(height: 3.h),
                            // item of paid Courses
                            SizedBox(
                              width: double.infinity,
                              height: 165.h,
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
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return DetailsCourses(
                                                  coursesModel:
                                                      constantvar.coursesModel =
                                                          state.courses[index],
                                                  id: GetCoursesCubit.get(
                                                          context)
                                                      .coursesModelList[index]
                                                      .id,
                                                  rate: GetCoursesCubit.get(
                                                          context)
                                                      .coursesModelList[index]
                                                      .rate,
                                                );
                                              }));
                                            });
                                          },
                                          child: buildHorizontalList(
                                            context,
                                            state.courses[index].images!,
                                            state.courses[index].nameCourse!,
                                            state
                                                .courses[index].nameInstructor!,
                                            state.courses[index].price!,
                                            state.courses[index].rate!,
                                          ),
                                        );
                                      },
                                      itemCount: 3,
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // label package
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s5, horizontal: AppSize.s8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(S.of(context).packageCourses,
                                    style: TextStyle(fontSize: 16.sp)
                                    //Theme.of(context).textTheme.titleLarge,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height:
                                        MediaQuery.of(context).size.height * .4,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: state.packageCourses.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("package")
                                                .doc(
                                                  state.packageCourses[index]
                                                      .id!,
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
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return DetailsPackage(
                                                  packageCourses: constantvar
                                                          .packageCoursesModel =
                                                      state.packageCourses[
                                                          index],
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
                                                    .packageCourses[index]
                                                    .images!,
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
                                                    const Icon(Icons
                                                        .cloud_off_outlined),
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade400,
                                                  highlightColor:
                                                      Colors.grey.shade200,
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .3,
                                                    height:
                                                        MediaQuery.of(context)
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
                                  return Container();
                                }
                              },
                            ),
                             */

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

                            // label tec support
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s8,
                                      horizontal: AppSize.s8),
                                  child: Text(S.of(context).titleOfMonitor,
                                      style: TextStyle(fontSize: 16.sp)
                                      //Theme.of(context).textTheme.titleLarge,
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
                                    child: Text(S.of(context).SeeMore,
                                        style: TextStyle(fontSize: 12.sp)
                                        //Theme.of(context).textTheme.titleSmall,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            // item tec support
                            SizedBox(height: 3.h),
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
                                                    .collection(
                                                        "all Instructor")
                                                    .doc(
                                                      state.instructor[index]
                                                          .id!,
                                                    )
                                                    .collection("RateOfUser")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get()
                                                    .then((value) {
                                                  print(
                                                      "my rate is one two ${constantvar.rateUser}");
                                                  constantvar.rateUser = value
                                                          .data()?["oldRate"] ??
                                                      0;

                                                  print(
                                                      "my rate is ${constantvar.rateUser}");
                                                }).then((value) async {
                                                  await Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return DetailsMonitor(
                                                      instructorModel: constantvar
                                                              .instructorModel =
                                                          state.instructor[
                                                              index],
                                                      id: constantvar
                                                          .instructorModel!.id!,
                                                      numberUserRate:
                                                          constantvar
                                                              .instructorModel!
                                                              .numberUserRate!,
                                                    );
                                                  }));
                                                });
                                              },
                                              child: buildHorizontalListMonitor(
                                                state.instructor[index].image!,
                                                state.instructor[index].name!,
                                                state.instructor[index].id!,
                                              ));
                                        });
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),

                            //technical support section

                            // space
                            SizedBox(height: 10.h),
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
                                            Text(
                                              "Technical Support",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                launchWhatsAppAhmed();
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .1,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                child: Center(
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .5,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .04,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.grey[100],
                                                      ),
                                                      child: const Center(
                                                          child: FaIcon(
                                                        FontAwesomeIcons
                                                            .whatsapp,
                                                        color:
                                                            Color(0xff25D366),
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

                            // space
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),

                            /*
                             GestureDetector(
                              onTap: (){
                                navigateTo(context, AnimationTestPage());
                              },
                                child: Text("Animatation Test")),
                             */
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: HomePageTablet());
                }
              },
            ),

            // drawer
            drawer: BlocConsumer<UserAppInformationCubit, UserInformationState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Drawer(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          DrawerHeader(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFffffff),
                                      Colors.grey[200]!,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: UserAccountsDrawerHeader(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFffffff),
                                        Colors.grey[200]!,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
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
                                currentAccountPictureSize:
                                    const Size.square(40),
                                currentAccountPicture: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: (state is LoadingInformationState)
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            "${UserAppInformationCubit.get(context).applicationUser!.firstName[0].toUpperCase()}${UserAppInformationCubit.get(context).applicationUser!.lastName[0].toUpperCase()}",
                                            style: const TextStyle(
                                                color: Colors.black))),

                                //
                              )),

                          // my profile
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text(' My Profile '),
                            onTap: () {
                              navigateTo(context, const PersonalProfilePage());
                              //navigateTo(context, const ProFilePage());
                            },
                          ),
                          // certification
                          /*
                            ListTile(
                            leading: const Icon(Icons.card_membership),
                            title: const Text('Certification'),
                            onTap: () {
                              // Fluttertoast.showToast(
                              //     msg: "Update... Loading Soon",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.white,
                              //     textColor: Colors.black,
                              //     fontSize: 15.sp
                              // );

                              navigateTo(context, const ChoosesState());
                            },
                          ),
                           */
                          // cv share
                          ListTile(
                            leading: const Icon(Icons.contact_page),
                            title: const Text('CV Share'),
                            onTap: () {
                              // if(isAdLoaded)
                              // {
                              //   interstitialAd.show();
                              // }

                              // disable for few time
                              // this is ADS
                              //Ads().showAdsOne();

                              navigateTo(context, ShareCV());
                            },
                          ),
                          // cv search
                          ListTile(
                            leading: const Icon(Icons.find_in_page),
                            title: const Text('CV Search'),
                            onTap: () {
                              navigateTo(context, Search_CV());
                            },
                          ),
                          // dashboard & contact us
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

                          //review post and whats app
                          /*
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

                           */

                          //contact us
                          /*
                          ListTile(
                            leading: const Icon(Icons.account_circle_outlined),
                            title: const Text('Contact us'),
                            onTap: () {
                              navigateTo(context, const ContactUs());
                            },
                          ),

                           */
                          // dashboardStudent
                          checkFoundOrNot(),

                          // logout
                          ListTile(
                            leading: const Icon(Icons.sensor_door_outlined),
                            title: Text(S.of(context).logout),
                            onTap: () async {
                              //for signOut for google

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
                                  return const NewLoginPage();
                                  // return const LoginViewApp();
                                }));
                              });
                            },
                          ),

                          //Theme color

                          /*

                          ListTile(
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Light'),
                                  const SizedBox(width: 10),
                                  Switch(
                                    value:
                                        AdaptiveTheme.of(context).mode.isDark,
                                    onChanged: (value) {
                                      if (value) {
                                        AdaptiveTheme.of(context).setDark();
                                      } else {
                                        AdaptiveTheme.of(context).setLight();
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('Dark'),
                                ],
                              ),
                              onTap: () {
                                // navigateTo(context, ProfileScreen());
                              }),
                           */

                          //space
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    /* drawer: buildDrawer(context),*/
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

  launchWhatsAppAhmed() async {
    const link = WhatsAppUnilink(
      phoneNumber: "+201093460618",
    );
    await launch('$link');
  }

  Row buildRowDetails(int index,
      {required String text,
      required TextStyle style,
      required IconData icon}) {
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

  checkFoundOrNot() {
    return ListTile(
      leading: const Icon(Icons.sensor_door_outlined),
      title: const Text("Dashboard Student"),
      onTap: () async {
        navigateTo(context, const LoginTrainer());

        /*
         final collectionRef =
            FirebaseFirestore.instance.collection('DashBoard User');
        // Fetch all documents in the collection
        final querySnapshot = await collectionRef.get();

        // Extract document IDs (names)
        final docIds = querySnapshot.docs.map((doc) => doc.id).toList();

        if (docIds.contains(constantvar.uid)) {
          try {
            /*
             const snackBar = SnackBar(content: Text('Welcome In DashBoard'));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
             */

            navigateTo(context, const LoginTrainer());

            // create account
            /*
                          FirebaseFirestore.instance
                             .collection("DashBoard User")
                             .doc(constantvar.uid)
                             .set({
                           'email': emailController,
                           'password': passwordController,
                           'code': codeController,
                           'name': UserAppInformationCubit.get(context)
                               .applicationUser!
                               .firstName,
                         });
                          */
          } catch (e) {
            print(e.toString());
          }
        } else {
          var snackBar = const SnackBar(content: Text('Sorry You not Allow '));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
         */
      },
    );
  }
}
