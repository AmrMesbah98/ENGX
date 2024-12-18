import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/Free_Courses/free_courses_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../bloc/get_information/user_information_cubit.dart';
import '../../generated/l10n.dart';
import '../../model/free_courses_model/free_courses_model.dart';
import '../../model/free_courses_model/inner_free_courses_model.dart';
import '../commentsPage/commentPageForFreeCourses.dart';
import '../resources/values_manager.dart';

class InnerFreeCoursesPage extends StatefulWidget {
  InnerFreeCoursesPage(
      {super.key,
      required this.innerFreeCoursesModel,
      required this.id,
      required this.freeCoursesModel});

  final FreeCoursesModel freeCoursesModel;
  List<InnerFreeCoursesModel> innerFreeCoursesModel;
  String id;

  @override
  State<InnerFreeCoursesPage> createState() => _InnerFreeCoursesPageState();
}

class _InnerFreeCoursesPageState extends State<InnerFreeCoursesPage> {
  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> reviewKey = GlobalKey();

  clear() {
    commentController.clear();
  }

  VideoPlayerController? myVideo;
  late ChewieController chewieController;
  bool isVideoIntialized = false;

  int _currentIndex = 0;

  //for duration

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  void _playVideo({int index = 0, bool init = false}) {
    if (index < 0 ||
        index >= widget.innerFreeCoursesModel[_currentIndex].link!.length)
      return;

    if (!init) {
      myVideo!.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    myVideo = VideoPlayerController.network(
        widget.innerFreeCoursesModel[_currentIndex].link!)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => myVideo!.play());

    //to display time , line progress and icon full screen
    chewieController = ChewieController(videoPlayerController: myVideo!);
  }

  @override
  void initState() {
    super.initState();
    _playVideo(init: true);

    //for no take screen record or screenShot >>>>>>>
    // if you need to take this use >>>>> FlutterWindowManager.clearFlags

  }

  @override
  void dispose() {
    //_playVideo(init: false);
    //myVideo!.dispose();
    print("video dispose called >>>>>>>>>>>>>>>>>>>>>>");
    chewieController.videoPlayerController.dispose();
    chewieController.dispose();
    print(
        "video dispose called >>>>>>>>>>>>>>>>>>>>>>////////////////////////");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FreeCoursesCubit, FreeCoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "Videos",
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black54),
            ),
            body: LayoutBuilder(builder: (context, constrain) {
              if (constrain.maxWidth < 600) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //for play video
                      Container(
                        height: 220.h,
                        //color: Colors.grey[400],
                        color: Colors.white,
                        child: myVideo!.value.isInitialized
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //for play video and icon full screen to landScape
                                  SizedBox(
                                    width: double.infinity,
                                    //height: 220,
                                    height: 220.h,
                                    child: Chewie(
                                      controller: chewieController,
                                    ),
                                  ),
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),

                      //space
                      const SizedBox(
                        height: 15,
                      ),

                      //for listview videos
                      Column(
                        children: [
                          //listview videos
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.innerFreeCoursesModel.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    //row for all videos
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 4),
                                          color: Colors.grey[200]),
                                      child: GestureDetector(
                                        onTap: () {
                                          _playVideo(index: index);
                                        },
                                        child: Column(
                                          children: [
                                            //for image
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 130.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child: CachedNetworkImage(
                                                    imageUrl: widget
                                                        .innerFreeCoursesModel[
                                                            index]
                                                        .image!,
                                                    fit: BoxFit.fill,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    // width: 134.w,
                                                    // height: 92.h,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons
                                                            .cloud_off_outlined),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[500]!,
                                                      child: Container(
                                                        width: 50.w,
                                                        height: 50.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),

                                            //space
                                            SizedBox(
                                              width: 10.w,
                                            ),

                                            // title and description and quiz
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // title of video
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .video_call_outlined,
                                                        size: 20,
                                                      ),
                                                      SizedBox(width: 5.w),
                                                      SizedBox(
                                                        width: 200.w,
                                                        child: Text(
                                                          widget
                                                              .innerFreeCoursesModel[
                                                                  index]
                                                              .title!,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //engx training
                                                  /*
                                                    SizedBox(
                                                        width: 200.w,
                                                        height: 40.h,
                                                        child: Text("ENGX Training Engineering ",style: TextStyle(fontSize: 12.sp),
                                                        ),
                                                    ),

                                                     */

                                                  // description
                                                  /*
                                                  Container(
                                                    width: 300.w,

                                                    child: Text(
                                                      ZoomMeetingCubit.get(context).zoomMeetingList[index].des!,
                                                      style: TextStyle(fontSize: 13.sp),
                                                      overflow: TextOverflow.fade,

                                                    ),
                                                  ),

                                                   */

                                                  // Quiz

                                                  /*
                                                                                      //quiz
                                                                                      GestureDetector(
                                              onTap: (){



                                                if (myVideo!.value.isPlaying) {
                                                  myVideo!.pause();
                                                  constantvar.idCategoryQuiz = ZoomMeetingCubit.get(context).zoomMeetingList[index].id!;
                                                  constantvar.titleCategoryQuiz = ZoomMeetingCubit.get(context).zoomMeetingList[index].title!;
                                                  ZoomMeetingCubit.get(context).getInnerQuiz(context);

                                                }





                                                //constantvar.categoryQuiz = ZoomMeetingCubit.get(context).zoomMeetingList;

                                              },
                                              child: Container(
                                                width: 150.w,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  gradient:    LinearGradient(
                                                      colors: [
                                                        //Color(0xFFE5E4E4),

                                                        Colors.grey[300]!,

                                                        Colors.grey[100]!,
                                                      ],
                                                      begin: FractionalOffset(0.0, 0.0),
                                                      end: FractionalOffset(1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                  //color: Colors.grey[200],
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    ZoomMeetingCubit.get(context).zoomMeetingList[index].quiz!,
                                                    style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),


                                                  ),
                                                ),
                                              ),
                                                                                      ),

                                                                                       */
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),

                          //========================================

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .001),

                          //review rate and comment

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s15)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .94,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFe5e5e5),
                                          Color(0xFFFFFFFF),
                                        ],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s15)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //for rate
                                      Row(
                                        children: [
                                          //icon
                                          const CircleAvatar(
                                            backgroundColor: Colors.white54,
                                            radius: 15,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),

                                          //space
                                          SizedBox(width: 20.w),

                                          //rate
                                          widget.freeCoursesModel.rateUser!
                                                  .contains(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                              ? RatingBar.builder(
                                                  initialRating: constantvar
                                                      .rateUserFreeCourses!
                                                      .toDouble(),
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  itemSize: 20,
                                                  ignoreGestures: true,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  onRatingUpdate:
                                                      (rating) async {},
                                                )
                                              : RatingBar.builder(
                                                  initialRating: constantvar
                                                      .rateUserFreeCourses!
                                                      .toDouble(),
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  itemSize: 20,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  onRatingUpdate:
                                                      (rating) async {
                                                    print(rating);

                                                    FreeCoursesCubit.get(
                                                            context)
                                                        .addUserNumber();
                                                    widget.freeCoursesModel
                                                        .rateUser!
                                                        .add(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid);

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Free Courses')
                                                        .doc(widget.id)
                                                        .update({
                                                      "rateUser": widget
                                                          .freeCoursesModel
                                                          .rateUser
                                                    });

                                                    // for save old rate in innerCollection
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "Free Courses")
                                                        .doc(widget.id)
                                                        .collection(
                                                            "RateOfUser")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .set({
                                                      "oldRate": rating
                                                    });

                                                    widget.freeCoursesModel
                                                            .rateUser!
                                                            .contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                        ? FreeCoursesCubit.get(context)
                                                            .editRateCalculation(
                                                                collectionName:
                                                                    'Free Courses',
                                                                documentId:
                                                                    widget.id!,
                                                                oldRate: constantvar
                                                                    .rateUserFreeCourses!,
                                                                rating: rating,
                                                                context:
                                                                    context)
                                                        : FreeCoursesCubit.get(
                                                                context)
                                                            .ratingCalculation(
                                                                collectionName:
                                                                    'Free Courses',
                                                                documentId:
                                                                    widget.id!,
                                                                rating: rating,
                                                                context:
                                                                    context);

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Free Courses')
                                                        .doc(widget.id)
                                                        .update({
                                                      'numberUserRate': widget
                                                              .freeCoursesModel
                                                              .numberUserRate +
                                                          1
                                                    });

                                                    print(
                                                        'numberUserRate>>>>>${widget.freeCoursesModel.numberUserRate}');

                                                    var snackBar = SnackBar(
                                                      content: Text(
                                                        "Your Rate is Done",
                                                        style: TextStyle(
                                                            fontSize: 15.sp),
                                                      ),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);

                                                    setState(() {
                                                      FreeCoursesCubit.get(
                                                              context)
                                                          .getFreeCoursesVideo();
                                                    });

                                                    await FreeCoursesCubit.get(
                                                            context)
                                                        .getFreeCoursesVideo();
                                                  },
                                                ),
                                        ],
                                      ),

                                      Form(
                                          key: reviewKey,
                                          child: Column(
                                            children: [
                                              //for comment
                                              Row(
                                                children: [
                                                  //icon
                                                  const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white54,
                                                    radius: 15,
                                                    child: Icon(
                                                      Icons.comment_outlined,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  ),

                                                  //space
                                                  SizedBox(width: 20.w),

                                                  //comment field
                                                  SizedBox(
                                                    width: 140.w,
                                                    child: TextFormField(
                                                        decoration: InputDecoration(
                                                            hintText: S
                                                                .of(context)
                                                                .EnterYourComment,
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        12.sp)),
                                                        controller:
                                                            commentController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return S
                                                                .of(context)
                                                                .PleaseEnterYourComment;
                                                          }
                                                        }),
                                                  ),

                                                  const Spacer(),

                                                  //for button send
                                                  TextButton(
                                                      onPressed: () async {
                                                        if (reviewKey
                                                            .currentState!
                                                            .validate()) {
                                                          if (widget
                                                                  .freeCoursesModel
                                                                  .nameUser!
                                                                  .contains(
                                                                      '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}') ||
                                                              widget
                                                                  .freeCoursesModel
                                                                  .comment!
                                                                  .contains(
                                                                      commentController
                                                                          .text)) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            clear();
                                                          } else {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Free Courses')
                                                                .doc(widget
                                                                    .freeCoursesModel
                                                                    .id)
                                                                .update({
                                                              'comment': FieldValue
                                                                  .arrayUnion([
                                                                commentController
                                                                    .text
                                                              ]),
                                                              'nameUser':
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                //'${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName} ${Random().nextInt(10)}'
                                                                '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'
                                                              ]),
                                                            }).then((value) async {
                                                              clear();

                                                              await FreeCoursesCubit
                                                                      .get(
                                                                          context)
                                                                  .getFreeCoursesVideo();

                                                              var snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                  "Your Comment is Done",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            });
                                                            await FreeCoursesCubit
                                                                    .get(
                                                                        context)
                                                                .getFreeCoursesVideo();

                                                            print('ok');
                                                            print(
                                                                commentController
                                                                    .text);
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        S.of(context).Send,
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )),

                                      //space
                                      SizedBox(
                                        height: 15.h,
                                      ),

                                      //for button see more
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 60.w),
                                        //padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //for show rate and comments

                                            GestureDetector(
                                                onTap: () {
                                                  navigateTo(
                                                      context,
                                                      CommentPageForFreeCourses(
                                                        freeCoursesModel: widget
                                                            .freeCoursesModel,
                                                        id: widget.id,
                                                      ));
                                                },
                                                child: Row(
                                                  children: [
                                                    //see more
                                                    Text(
                                                      S.of(context).SeeMore,
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //space
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    //icon
                                                    const Icon(
                                                      Icons
                                                          .double_arrow_outlined,
                                                      size: 15,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 5.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //========================================
                        ],
                      ),

                      SizedBox(height: 5.h),
                    ],
                  ),
                );
              } else if (constrain.maxWidth < 900) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //for play video
                      Container(
                        height: 300.h,
                        //color: Colors.grey[400],
                        color: Colors.white,
                        child: myVideo!.value.isInitialized
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //for play video and icon full screen to landScape
                                  SizedBox(
                                    width: double.infinity,
                                    //height: 220,
                                    height: 300.h,
                                    child: Chewie(
                                      controller: chewieController,
                                    ),
                                  ),

                                  //space
                                  const SizedBox(
                                    height: 12,
                                  ),

                                  //row for line and start , end time
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //for start time
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: ValueListenableBuilder(
                                            valueListenable: myVideo!,
                                            builder: (context,
                                                VideoPlayerValue value, child) {
                                              return Text(
                                                _videoDuration(value.position),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10),
                                              );
                                            }),
                                      ),

                                      //for line VideoProgressIndicator
                                      Expanded(
                                        child: SizedBox(
                                          height: 5,
                                          child: VideoProgressIndicator(
                                            myVideo!,
                                            allowScrubbing: true,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                          ),
                                        ),
                                      ),

                                      //for end time
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          _videoDuration(
                                              myVideo!.value.duration),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //space
                                  const SizedBox(
                                    height: 12,
                                  ),

                                  //row for icon play and pause and fast time
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            //icon fast time back
                                            GestureDetector(
                                              onTap: () {
                                                myVideo!.seekTo(Duration(
                                                    seconds: myVideo!
                                                            .value
                                                            .position
                                                            .inSeconds -
                                                        15));
                                              },
                                              child: const Icon(
                                                  Icons.fast_rewind,
                                                  size: 20),
                                            ),

                                            //spase
                                            SizedBox(
                                              width: 20.w,
                                            ),

                                            //icon play and pause
                                            GestureDetector(
                                              onTap: () {
                                                if (myVideo!.value.isPlaying) {
                                                  myVideo!.pause();
                                                } else {
                                                  myVideo!.play();
                                                }
                                              },
                                              child: Icon(
                                                myVideo!.value.isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),

                                            //spase
                                            SizedBox(
                                              width: 20.w,
                                            ),

                                            //icon fast time forward
                                            GestureDetector(
                                              onTap: () {
                                                myVideo!.seekTo(Duration(
                                                    seconds: myVideo!
                                                            .value
                                                            .position
                                                            .inSeconds +
                                                        15));
                                              },
                                              child: const Icon(
                                                  Icons.fast_forward,
                                                  size: 20),
                                            ),
                                          ],
                                        ),

                                        // speed
                                        Row(
                                          children: [
                                            //1X
                                            GestureDetector(
                                              onTap: () {
                                                myVideo?.setPlaybackSpeed(1.0);
                                              },
                                              child: const Text("1X"),
                                            ),
                                            //space
                                            SizedBox(width: 20.w),
                                            //1.5X
                                            GestureDetector(
                                              onTap: () {
                                                myVideo?.setPlaybackSpeed(1.5);
                                              },
                                              child: const Text("1.5X"),
                                            ),
                                            //space
                                            SizedBox(width: 20.w),
                                            //2X
                                            GestureDetector(
                                              onTap: () {
                                                myVideo?.setPlaybackSpeed(2.0);
                                              },
                                              child: const Text("2X"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),

                      //space
                      const SizedBox(
                        height: 15,
                      ),

                      //for listview videos
                      Column(
                        children: [
                          // listview videos
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.innerFreeCoursesModel.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    //row for all videos
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 4),
                                          color: Colors.grey[200]),
                                      child: GestureDetector(
                                        onTap: () {
                                          _playVideo(index: index);
                                        },
                                        child: Column(
                                          children: [
                                            //for image
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 130.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child: CachedNetworkImage(
                                                    imageUrl: widget
                                                        .innerFreeCoursesModel[
                                                            index]
                                                        .image!,
                                                    fit: BoxFit.fill,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    // width: 134.w,
                                                    // height: 92.h,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons
                                                            .cloud_off_outlined),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[500]!,
                                                      child: Container(
                                                        width: 50.w,
                                                        height: 50.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),

                                            //space
                                            SizedBox(
                                              width: 10.w,
                                            ),

                                            // title and description and quiz
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // title of video
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .video_call_outlined,
                                                        size: 30,
                                                      ),
                                                      SizedBox(width: 5.w),
                                                      SizedBox(
                                                        width: 200.w,
                                                        child: Text(
                                                          widget
                                                              .innerFreeCoursesModel[
                                                                  index]
                                                              .title!,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //engx training
                                                  /*
                                                    SizedBox(
                                                        width: 200.w,
                                                        height: 40.h,
                                                        child: Text("ENGX Training Engineering ",style: TextStyle(fontSize: 12.sp),
                                                        ),
                                                    ),

                                                     */

                                                  // description
                                                  /*
                                                  Container(
                                                    width: 300.w,

                                                    child: Text(
                                                      ZoomMeetingCubit.get(context).zoomMeetingList[index].des!,
                                                      style: TextStyle(fontSize: 13.sp),
                                                      overflow: TextOverflow.fade,

                                                    ),
                                                  ),

                                                   */

                                                  // Quiz

                                                  /*
                                                                                      //quiz
                                                                                      GestureDetector(
                                              onTap: (){



                                                if (myVideo!.value.isPlaying) {
                                                  myVideo!.pause();
                                                  constantvar.idCategoryQuiz = ZoomMeetingCubit.get(context).zoomMeetingList[index].id!;
                                                  constantvar.titleCategoryQuiz = ZoomMeetingCubit.get(context).zoomMeetingList[index].title!;
                                                  ZoomMeetingCubit.get(context).getInnerQuiz(context);

                                                }





                                                //constantvar.categoryQuiz = ZoomMeetingCubit.get(context).zoomMeetingList;

                                              },
                                              child: Container(
                                                width: 150.w,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  gradient:    LinearGradient(
                                                      colors: [
                                                        //Color(0xFFE5E4E4),

                                                        Colors.grey[300]!,

                                                        Colors.grey[100]!,
                                                      ],
                                                      begin: FractionalOffset(0.0, 0.0),
                                                      end: FractionalOffset(1.0, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                  //color: Colors.grey[200],
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    ZoomMeetingCubit.get(context).zoomMeetingList[index].quiz!,
                                                    style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),


                                                  ),
                                                ),
                                              ),
                                                                                      ),

                                                                                       */
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),

                          //========================================

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .001),

                          //review rate and comment

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s15)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .94,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFe5e5e5),
                                          Color(0xFFFFFFFF),
                                        ],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s15)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //for rate
                                      Row(
                                        children: [
                                          //icon
                                          const CircleAvatar(
                                            backgroundColor: Colors.white54,
                                            radius: 15,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),

                                          //space
                                          SizedBox(width: 20.w),

                                          //rate
                                          widget.freeCoursesModel.rateUser!
                                                  .contains(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                              ? RatingBar.builder(
                                                  initialRating: constantvar
                                                      .rateUserFreeCourses!
                                                      .toDouble(),
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  itemSize: 20,
                                                  ignoreGestures: true,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  onRatingUpdate:
                                                      (rating) async {},
                                                )
                                              : RatingBar.builder(
                                                  initialRating: constantvar
                                                      .rateUserFreeCourses!
                                                      .toDouble(),
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  itemSize: 20,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  onRatingUpdate:
                                                      (rating) async {
                                                    print(rating);

                                                    FreeCoursesCubit.get(
                                                            context)
                                                        .addUserNumber();
                                                    widget.freeCoursesModel
                                                        .rateUser!
                                                        .add(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid);

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Free Courses')
                                                        .doc(widget.id)
                                                        .update({
                                                      "rateUser": widget
                                                          .freeCoursesModel
                                                          .rateUser
                                                    });

                                                    // for save old rate in innerCollection
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "Free Courses")
                                                        .doc(widget.id)
                                                        .collection(
                                                            "RateOfUser")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .set({
                                                      "oldRate": rating
                                                    });

                                                    widget.freeCoursesModel
                                                            .rateUser!
                                                            .contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                        ? FreeCoursesCubit.get(context)
                                                            .editRateCalculation(
                                                                collectionName:
                                                                    'Free Courses',
                                                                documentId:
                                                                    widget.id!,
                                                                oldRate: constantvar
                                                                    .rateUserFreeCourses!,
                                                                rating: rating,
                                                                context:
                                                                    context)
                                                        : FreeCoursesCubit.get(
                                                                context)
                                                            .ratingCalculation(
                                                                collectionName:
                                                                    'Free Courses',
                                                                documentId:
                                                                    widget.id!,
                                                                rating: rating,
                                                                context:
                                                                    context);

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Free Courses')
                                                        .doc(widget.id)
                                                        .update({
                                                      'numberUserRate': widget
                                                              .freeCoursesModel
                                                              .numberUserRate +
                                                          1
                                                    });

                                                    print(
                                                        'numberUserRate>>>>>${widget.freeCoursesModel.numberUserRate}');

                                                    var snackBar = SnackBar(
                                                      content: Text(
                                                        "Your Rate is Done",
                                                        style: TextStyle(
                                                            fontSize: 15.sp),
                                                      ),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);

                                                    setState(() {
                                                      FreeCoursesCubit.get(
                                                              context)
                                                          .getFreeCoursesVideo();
                                                    });

                                                    await FreeCoursesCubit.get(
                                                            context)
                                                        .getFreeCoursesVideo();
                                                  },
                                                ),
                                        ],
                                      ),

                                      Form(
                                          key: reviewKey,
                                          child: Column(
                                            children: [
                                              //for comment
                                              Row(
                                                children: [
                                                  //icon
                                                  const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white54,
                                                    radius: 15,
                                                    child: Icon(
                                                      Icons.comment_outlined,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  ),

                                                  //space
                                                  SizedBox(width: 20.w),

                                                  //comment field
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: TextFormField(
                                                        decoration: InputDecoration(
                                                            hintText: S
                                                                .of(context)
                                                                .EnterYourComment,
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        8.sp)),
                                                        controller:
                                                            commentController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return S
                                                                .of(context)
                                                                .PleaseEnterYourComment;
                                                          }
                                                        }),
                                                  ),

                                                  const Spacer(),

                                                  //for button send
                                                  TextButton(
                                                      onPressed: () async {
                                                        if (reviewKey
                                                            .currentState!
                                                            .validate()) {
                                                          if (widget
                                                                  .freeCoursesModel
                                                                  .nameUser!
                                                                  .contains(
                                                                      '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}') ||
                                                              widget
                                                                  .freeCoursesModel
                                                                  .comment!
                                                                  .contains(
                                                                      commentController
                                                                          .text)) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            clear();
                                                          } else {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Free Courses')
                                                                .doc(widget
                                                                    .freeCoursesModel
                                                                    .id)
                                                                .update({
                                                              'comment': FieldValue
                                                                  .arrayUnion([
                                                                commentController
                                                                    .text
                                                              ]),
                                                              'nameUser':
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                //'${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName} ${Random().nextInt(10)}'
                                                                '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'
                                                              ]),
                                                            }).then((value) async {
                                                              clear();

                                                              await FreeCoursesCubit
                                                                      .get(
                                                                          context)
                                                                  .getFreeCoursesVideo();

                                                              var snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                  "Your Comment is Done",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            });
                                                            await FreeCoursesCubit
                                                                    .get(
                                                                        context)
                                                                .getFreeCoursesVideo();

                                                            print('ok');
                                                            print(
                                                                commentController
                                                                    .text);
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        S.of(context).Send,
                                                        style: TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )),

                                      //space
                                      SizedBox(
                                        height: 15.h,
                                      ),

                                      //for button see more
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.w),
                                        //padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //for show rate and comments

                                            GestureDetector(
                                                onTap: () {
                                                  navigateTo(
                                                      context,
                                                      CommentPageForFreeCourses(
                                                        freeCoursesModel: widget
                                                            .freeCoursesModel,
                                                        id: widget.id!,
                                                      ));
                                                },
                                                child: Row(
                                                  children: [
                                                    //see more
                                                    Text(
                                                      S.of(context).SeeMore,
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //space
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    //icon
                                                    const Icon(
                                                      Icons
                                                          .double_arrow_outlined,
                                                      size: 15,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 5.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //========================================
                        ],
                      ),

                      SizedBox(height: 5.h),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("Desktop"));
              }
            }));
      },
    );
  }
}
