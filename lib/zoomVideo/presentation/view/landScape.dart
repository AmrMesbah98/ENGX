

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:video_player/video_player.dart';

class LandScapePage extends StatefulWidget {
  const LandScapePage({super.key,required this.myOrientedVideo});

  final VideoPlayerController myOrientedVideo;

  @override
  State<LandScapePage> createState() => _LandScapePageState();
}

class _LandScapePageState extends State<LandScapePage> {

  //to create oriented video
  Future _landScapeMode() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  Future _setAllOrientation() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  @override
  void initState() {
    super.initState();
    _landScapeMode();


    //for no take screen record or screenShot >>>>>>>
    // if you need to take this use >>>>> FlutterWindowManager.clearFlags

    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  }
  @override
  void dispose() {
    super.dispose();
    _setAllOrientation();
  }

  @override
  Widget build(BuildContext context)  => Stack(
    children: [

      VideoPlayer (widget.myOrientedVideo),
      //for line VideoProgressIndicator
      Expanded(
        child: SizedBox(
          height: 5,
          child: VideoProgressIndicator(
            widget.myOrientedVideo,
            allowScrubbing: true,
            padding:
            const EdgeInsets.symmetric(
                horizontal: 12),
          ),
        ),
      ),
    ],
  );
}




 */



import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TestLandScape extends StatefulWidget {
  TestLandScape({super.key,required this.videoPlayerController});

  VideoPlayerController? videoPlayerController;

  @override
  State<TestLandScape> createState() => _TestLandScapeState();
}

class _TestLandScapeState extends State<TestLandScape> {



  late ChewieController chewieController;
  //bool isVideoIntialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.videoPlayerController =widget.videoPlayerController;
    chewieController = ChewieController(videoPlayerController: widget.videoPlayerController!,autoPlay: true);

    // widget.videoPlayerController!.initialize().then((value) {
    //   isVideoIntialized = true;
    //
    // });

  }


  @override
  Widget build(BuildContext context) {
    // if(isVideoIntialized){
      return AspectRatio(aspectRatio: widget.videoPlayerController!.value.aspectRatio,
        child: Chewie(
          controller: chewieController,
        ),

      );
    // }else
    // {
    //   return const CircularProgressIndicator();
    // }

  }
}
