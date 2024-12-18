
import 'package:flutter/material.dart';

class BuildItemHome extends StatelessWidget {
  BuildItemHome(
      {super.key,
        required this.name,
        required this.email,
        required this.phone,
        required this.uid});

  String name;

  String email;

  String phone;

  String uid;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .22,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [
                  Color(0xFFe5e5e5),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(25)
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image(
                        image: const AssetImage("assets/images/notification.png"),
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.width * .3,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        phone,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        uid,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}