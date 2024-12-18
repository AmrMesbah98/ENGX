import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';



class VideoPlay extends StatefulWidget{


  final String url ;

  const VideoPlay({super.key, required this.url});


  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {

  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }





  loadVideoPlayer(){

    //controller = VideoPlayerController.asset('assets/video/aa.mp4');
    controller = VideoPlayerController.network(widget.url);
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value){
      setState(() {});
    });

  }


  Future<void> setPlaybackSpeed(double speed) async {
    if (speed < 0) {
      throw ArgumentError.value(
        speed,
        'Negative playback speeds are generally unsupported.',
      );
    } else if (speed == 0) {
      throw ArgumentError.value(
        speed,
        'Zero playback speed is generally unsupported. Consider using [pause].',
      );
    }

    // value = value.copyWith(playbackSpeed: speed);
    // await _applyPlaybackSpeed();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children:[

            // AspectRatio(
            //   aspectRatio: controller.value.aspectRatio,
            //   child: VideoPlayer(controller),
            // ),



          SizedBox(
            width: double.infinity,
            height: 200,
            child: VideoPlayer(controller),
          ),


          Text("Duration: ${controller.value.duration}",style:  TextStyle(fontSize: 16.sp),),

          SizedBox(
            width: double.infinity,
            child: Center(
              child: VideoProgressIndicator(

                  controller,
                  allowScrubbing: true,
                  colors:VideoProgressColors(

                    backgroundColor: Colors.redAccent,
                    playedColor: Colors.green,
                    // bufferedColor: Colors.purple,
                  )
              ),
            ),
          ),
          const SizedBox(height: 3),

          Center(
            child: Container(
              height: 20,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [



                  GestureDetector(

                    child: Container(

                      child: Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow,size: 30,),
                      width: 50,
                      height: 50,
                    ),
                    onTap: (){
                      if(controller.value.isPlaying){
                        controller.pause();
                      }else{
                        controller.play();
                      }

                      setState(() {

                      });
                    },
                  ),
                  GestureDetector(

                    child: Container(

                      width: 50,
                      height: 50,

                      child: const Icon(Icons.loop,size: 30,),
                    ),
                    onTap: (){
                      controller.seekTo(const Duration(seconds: 0));

                      setState(() {

                      });
                    },
                  ),



                  /*
                  IconButton(
                      onPressed: (){
                        if(controller.value.isPlaying){
                          controller.pause();
                        }else{
                          controller.play();
                        }

                        setState(() {

                        });
                      },
                      icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow,size: 30,)
                  ),


                  IconButton(
                      onPressed: (){
                        controller.seekTo(Duration(seconds: 0));

                        setState(() {

                        });
                      },
                      icon:Icon(Icons.stop)
                  ),

                   */


                ],
              ),
            ),
          )
        ]
    );
  }
}