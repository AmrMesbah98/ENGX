import 'package:asec_application/bloc/PodCast/pod_cast_cubit.dart';
import 'package:asec_application/presentation/Settings/settings.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'Tablet/videoPageTablet.dart';
import 'landScapePage.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {

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
    if (index < 0 || index >= PodCastCubit.get(context).podCastList[_currentIndex].link!.length) return;

    if (!init) {
      myVideo!.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    myVideo = VideoPlayerController.network(PodCastCubit.get(context).podCastList[_currentIndex].link!)
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
     print("video dispose called >>>>>>>>>>>>>>>>>>>>>>////////////////////////");
     super.dispose();
   }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PodCastCubit, PodCastState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.white,
                title:  Text(
                  "Podcasts",
                  style: TextStyle(color: Colors.black,fontSize: 18.sp),
                ),
                //iconTheme: const IconThemeData(color: Colors.black54),
                leading: GestureDetector(
                    onTap: (){
                      chewieController.videoPlayerController.dispose();
                      chewieController.dispose();
                      navigateTo(context, Settings());
                    },
                    child: const Icon(Icons.arrow_back_rounded,color: Colors.black54,)),
              ),
            body: LayoutBuilder(
                builder: (context, constrain){
                  if (constrain.maxWidth < 600){
                    return SingleChildScrollView(

                      child: Column(
                        children: [

                          //for play video
                          Container(
                            height: 220.h,
                            //color: Colors.grey[100],
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
                           SizedBox(height: 10.h,),

                          //for listview videos
                          SizedBox(
                            width: 500,

                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: PodCastCubit.get(context).podCastList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.h),
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
                                                child: CachedNetworkImage(
                                                  imageUrl: PodCastCubit.get(context).podCastList[index].image!,
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
                                                      PodCastCubit.get(context).podCastList[index].title!,
                                                      style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),
                                                    ),



                                                    // description
                                                    Container(
                                                      width: 300.w,

                                                      child: Text(
                                                        PodCastCubit.get(context).podCastList[index].des!,
                                                        style: TextStyle(fontSize: 12.sp),
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


                          // text ENGX
                          /*
                   Column(
                     children: [

                       Text("ENGX",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),

                       Text(" Training Services",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                     ],
                   ),


                   */
                          SizedBox(height: 5.h),
                        ],
                      ),
                    );
                  }
                  else if (constrain.maxWidth < 900) {
                    return const Center(child: VideosPageTablet());
                  }

                  else {
                    return const Center(child: Text("Desktop"));
                  }
                }
            )
          ),
        );
      },
    );
  }
}
