
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../data/shorts_model.dart';
import '../manager/shorts_cubit.dart';



class ShortsVideosPage extends StatefulWidget {
  ShortsVideosPage({super.key,required this.shortsModel,required this.id,required this.link});

  List<ShortsModel> shortsModel;
  String id;
  String link;

  @override
  State<ShortsVideosPage> createState() => _ShortsVideosPageState();
}

class _ShortsVideosPageState extends State<ShortsVideosPage> {


  VideoPlayerController? myVideo;
  late ChewieController chewieController;
  bool isVideoIntialized=false;

  int _currentIndex = 0;



  void _playVideo({int index = 0, bool init = false}) {
    if (index < 0 ||
        index >=
            widget.shortsModel[_currentIndex]
                .link!
                .length) return;

    if (!init) {
      myVideo!.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    myVideo = VideoPlayerController.network(
        widget.shortsModel[_currentIndex].link!)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => myVideo!.play());

    //to display time , line progress and icon full screen
    chewieController = ChewieController(videoPlayerController: myVideo!);
  }

  @override
  void initState() {
    super.initState();
    //_playVideo(init: true);
    myVideo = VideoPlayerController.network(
        widget.link)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => myVideo!.play());

    //to display time , line progress and icon full screen
    chewieController = ChewieController(videoPlayerController: myVideo!);
  }

  @override



  void dispose() {
    print("video dispose called >>>>>>>>>>>>>>>>>>>>>>");
    chewieController.videoPlayerController.dispose();
    chewieController.dispose();
    print("video dispose called >>>>>>>>>>>>>>>>>>>>>>////////////////////////");

    super.dispose();
  }







  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShortsCubit, ShortsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(

              body:Column(
                children: [

                  //for play video
                  Container(
                    height: MediaQuery.of(context).size.height*0.94,
                    child: myVideo!.value.isInitialized
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //for play video
                        Container(
                          height: MediaQuery.of(context).size.height*0.94,
                          color: Colors.black,
                          child: myVideo!.value.isInitialized
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //for play video and icon full screen to landScape
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.94,
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


                      ],
                    )
                        : const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),


                ],
              )
          ),
        );
      },
    );
  }
}
