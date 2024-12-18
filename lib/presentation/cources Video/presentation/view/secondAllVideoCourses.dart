

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../data/innerCategoryModel.dart';
import '../manager/get_courses_cubit.dart';
import 'landScapePage.dart';


class SecondAllVideoCourses extends StatefulWidget {
  SecondAllVideoCourses({super.key , required this.innerCategoryModel, required this.id,required this.promoCode});

  List<InnerCategoryModel> innerCategoryModel;
  String id;
  List<dynamic> promoCode;

  @override
  State<SecondAllVideoCourses> createState() => _SecondAllVideoCoursesState();
}

class _SecondAllVideoCoursesState extends State<SecondAllVideoCourses> {


  TextEditingController promoCodeController = TextEditingController();

  VideoPlayerController? myVideo;

  int _currentIndex = 0;

  //for duration

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  void _playVideo({int index = 0, bool init = false}) {
    if (index < 0 || index >= GetCoursesVideoCubit.get(context).innerCategoryList[_currentIndex].link!.length) return;

    if (!init) {
      myVideo!.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    myVideo = VideoPlayerController.network(GetCoursesVideoCubit.get(context).innerCategoryList[_currentIndex].link!)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => myVideo!.play());
  }

  @override
  void initState() {
    print(widget.id);
    print(widget.promoCode);
    super.initState();
    _playVideo(init: true);

    //for no take screen record or screenShot >>>>>>>
    // if you need to take this use >>>>> FlutterWindowManager.clearFlags

    //FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void dispose() {
    myVideo!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCoursesVideoCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(

              child: Column(
                children: [

                  //for play video
                  Container(
                    height: 260,
                    color: Colors.grey[100],
                    child: myVideo!.value.isInitialized
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //for play video and icon full screen to landScape
                        Stack(
                          children: [
                            //play video
                            SizedBox(
                              height: 200,
                              child: VideoPlayer(myVideo!),
                            ),

                            //icon full screen
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LandScapePage(
                                                  myOrientedVideo: myVideo!)),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                          ],
                        ),

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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Row(
                                children: [
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
                                              5));
                                    },
                                    child: const Icon(Icons.fast_forward, size: 20),
                                  ),
                                ],
                              ),



                              // speed
                              Row(
                                children: [
                                  //1x
                                  GestureDetector(
                                    onTap: (){
                                      myVideo?.setPlaybackSpeed(1.0);
                                    },
                                    child: const Text("1X"),
                                  ),
                                  //space
                                  SizedBox(width: 20.w),
                                  //1.5
                                  GestureDetector(
                                    onTap: (){
                                      myVideo?.setPlaybackSpeed(1.5);
                                    },
                                    child: const Text("1.5X"),
                                  ),
                                  //space
                                  SizedBox(width: 20.w),
                                  //1x
                                  GestureDetector(
                                    onTap: (){
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
                  Stack(
                    children: [
                      SizedBox(
                        width: 500,

                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: GetCoursesVideoCubit.get(context).innerCategoryList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                //row for all videos
                                child: GestureDetector(
                                  onTap: () {
                                    _playVideo(index: index);
                                  },
                                  child: Column(
                                    children: [
                                      //for image
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 200.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: Image.network(
                                            GetCoursesVideoCubit.get(context).innerCategoryList[index].image!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //for text
                                      SizedBox(

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            // image icon
                                            Container(

                                                width: 35.w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(35),
                                                    color: Colors.grey[300]
                                                ),

                                                child: Image(image: AssetImage("assets/images/ASEC.png"))


                                            ),


                                            SizedBox(width: 10.w),


                                            // title and description
                                            Column(

                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                // title of video
                                                Text(
                                                  GetCoursesVideoCubit.get(context).innerCategoryList[index].title!,
                                                  style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),
                                                ),



                                                // description
                                                Container(
                                                  width: 300.w,

                                                  child: Text(
                                                    GetCoursesVideoCubit.get(context).innerCategoryList[index].des!,
                                                    style: TextStyle(fontSize: 13.sp),
                                                    overflow: TextOverflow.fade,

                                                  ),
                                                ),






                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),


                    ],
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




//////////////////////////////////////////////////////////



