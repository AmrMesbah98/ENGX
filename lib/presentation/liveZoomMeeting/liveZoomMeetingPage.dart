/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'dart:math' as math;

import '../../bloc/get_information/user_information_cubit.dart';
import '../resources/values_manager.dart';


/// Note that the userID needs to be globally unique,
final String localUserID = math.Random().nextInt(10000).toString();


class LiveZoomMeetingPage extends StatelessWidget {
  /// Users who use the same callID can in the same call.
  final callIDTextCtrl = TextEditingController(text: "Enter_id");


  LiveZoomMeetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Image(image: AssetImage("assets/images/desk.jpg"),fit: BoxFit.cover,)),
          Padding(
            padding:  EdgeInsets.only(bottom: 20.w),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s15)),
              child: Container(
                height: 100.h,
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
                    borderRadius: BorderRadius.circular(AppSize.s15)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: callIDTextCtrl,
                          decoration:
                          const InputDecoration(labelText: "join a meeting by id"),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return VideoConferencePage(conferenceID: callIDTextCtrl.text);
                            }),
                          );
                        },
                        child: const Text("join"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1593739020 /*input your AppID*/,
        appSign: "1251c65e6b53a77fcb5ee5a0176c5868458aecc8702fe0c85c756a9adf57714e" /*input your AppSign*/,
        userID: 'user_$localUserID',
        //userName: 'user_name',
        userName: "${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}",
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),

    );
  }
}
 */
