import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Notification/bublic_Notification.dart';
import '../Tablet/Application_User_tablet.dart';

class AppUser extends StatelessWidget {
  const AppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrain) {
        if (constrain.maxWidth < 600) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/images/map.png")),
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const FcmPublic();
                    }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .15,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFFe5e5e5), Colors.white60],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Send public Notification",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (constrain.maxWidth < 900) {
          return const Center(child: AppUserTablet());
        } else {
          return const Center(child: Text("Desktop"));
        }
      }),
    );
  }
}
