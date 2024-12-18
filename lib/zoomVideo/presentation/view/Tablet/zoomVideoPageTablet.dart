import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/model/Collect_model.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../../../presentation/cources Video/presentation/view/landScapePage.dart';
import '../../manager/zoom_meeting_cubit.dart';




class ZoomVideoPageTablet extends StatefulWidget {
  const ZoomVideoPageTablet({super.key});

  @override
  State<ZoomVideoPageTablet> createState() => _ZoomVideoPageTabletState();
}

class _ZoomVideoPageTabletState extends State<ZoomVideoPageTablet> {

  VideoPlayerController? myVideo;
  late ChewieController chewieController;
  bool isVideoIntialized=false;

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
    if (index < 0 || index >= ZoomMeetingCubit.get(context).innerZoomMeetingList[_currentIndex].link!.length) return;

    if (!init) {
      myVideo!.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    myVideo = VideoPlayerController.network(ZoomMeetingCubit.get(context).innerZoomMeetingList[_currentIndex].link!)
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
    _playVideo(init: false);
    //myVideo!.dispose();
    print("video dispose called >>>>>>>>>>>>>>>>>>>>>>");
    chewieController.videoPlayerController.pause();
    chewieController.pause();
    print("video dispose called >>>>>>>>>>>>>>>>>>>>>>////////////////////////");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoomMeetingCubit, ZoomMeetingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(

            body: SingleChildScrollView(

              child: Column(
                children: [

                  //for play video
                  Container(
                    height: 300.h,
                    color: Colors.grey[100],
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

                        //for old time and speed for video

                        /*
                        //space
                        const SizedBox(
                          height: 12,
                        ),

                        //row for line and start , end time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //for start time
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ValueListenableBuilder(
                                  valueListenable: myVideo!,
                                  builder:
                                      (context, VideoPlayerValue value, child) {
                                    return Text(
                                      _videoDuration(value.position),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 10),
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
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                _videoDuration(myVideo!.value.duration),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.black),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              //icon fast time back
                              GestureDetector(
                                onTap: () {
                                  myVideo!.seekTo(Duration(
                                      seconds:
                                      myVideo!.value.position.inSeconds -
                                          15));
                                },
                                child: const Icon(Icons.fast_rewind, size: 20),
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
                                      seconds:
                                      myVideo!.value.position.inSeconds +
                                          15));
                                },
                                child: const Icon(Icons.fast_forward, size: 20),
                              ),
                            ],
                          ),
                        ),

                         */

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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,

                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ZoomMeetingCubit.get(context).zoomMeetingList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            //row for all videos
                            child: Card(
                              elevation: 6,
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _playVideo(index: index);
                                },
                                child: Row(
                                  children: [
                                    //for image
                                    Container(
                                      width: MediaQuery.of(context).size.width*.3,
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: CachedNetworkImage(
                                            imageUrl: ZoomMeetingCubit.get(context).zoomMeetingList[index].image!,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.topCenter,
                                            // width: 134.w,
                                            // height: 92.h,
                                            errorWidget: (context, url, error) =>
                                            const Icon(Icons.cloud_off_outlined),
                                            placeholder: (context, url) => Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[500]!,
                                              child: Container(
                                                width: 50.w,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    ),

                                    //space
                                    SizedBox(
                                      width: 10.w,
                                    ),

                                    // title and description and quiz
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [







                                        // title of video
                                        SizedBox(
                                          width: 200.w,
                                          height: 40.h,
                                          child: Text(
                                            ZoomMeetingCubit.get(context).zoomMeetingList[index].title!,
                                            style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),
                                          ),
                                        ),

                                        //space
                                        SizedBox(height: 20.h,),




                                        SizedBox(
                                            width: 200.w,
                                            height: 40.h,
                                            child: Text("ENGX Training Engineering ",style: TextStyle(fontSize: 12.sp),)),








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

                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),


                  SizedBox(height: 5.h),
                ],
              ),
            ),

          ),
        );
      },
    );
  }
}
