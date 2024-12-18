import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'generated/l10n.dart';
import 'model/Collect_model.dart';

class Master extends StatefulWidget {
  const Master({super.key});

  @override
  State<Master> createState() => _MasterState();
}

class _MasterState extends State<Master> {
  void setupInteractedMessage() {
    print("Welcome 1");
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) => print('opening'),
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Welcome 2");
      if (message.notification != null) {
        var snackBar = SnackBar(
          content: Text(
            message.notification!.body!,
            style: TextStyle(fontSize: 15.sp),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int selectPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return Screens[selectPage];
          } else {
            return buildNointernet();
          }
        },
        child: const LinearProgressIndicator(),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white38,
        selectedIndex: selectPage,
        iconSize: 30,
        fontSize: 13,
        fontWeight: FontWeight.w800,
        inactiveColor: Colors.grey[300],
        activeColor: Colors.blueAccent,
        onButtonPressed: (index) {
          setState(() {
            selectPage = index;
          });
        },
        barItems: [
          BarItem(title: S.of(context).Home, icon: Icons.home),
          BarItem(title: S.of(context).post, icon: Icons.post_add_outlined),
          BarItem(title: S.of(context).CV, icon: Icons.engineering),
          //BarItem(title: "Discuss", icon: Icons.mic),
          BarItem(title: "Settings", icon: Icons.settings),
          //  BarItem(title: S.of(context).settings, icon: Icons.settings),
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectPage = index;
    });
  }

  Widget buildNointernet() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(),
                child: Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: Colors.blue,
                    size: 60,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
