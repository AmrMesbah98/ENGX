import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  Future _setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    super.initState();
    _landScapeMode();

    //for no take screen record or screenShot >>>>>>>
    // if you need to take this use >>>>> FlutterWindowManager.clearFlags

  }

  @override
  void dispose() {
    super.dispose();
    _setAllOrientation();
  }

  @override
  Widget build(BuildContext context)  => VideoPlayer (widget.myOrientedVideo);
}
