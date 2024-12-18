import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Notification/bublic_Notification.dart';


class AppUserTablet extends StatelessWidget {
  const AppUserTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage("assets/images/map.png")),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return const FcmPublic();
                }));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .10,
                decoration:  BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFFe5e5e5),
                          Colors.white60
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(20)
                ),
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
      ),
    );
  }
}
