
import 'package:asec_application/presentation/DashBoard/projectControl/homepage_Project.dart';
import 'package:asec_application/presentation/DashBoard/project_order.dart';
import 'package:asec_application/presentation/DashBoard/support_courses.dart';
import 'package:flutter/material.dart';

import 'App_User/Application_User.dart';
import 'CoursesControl/HomePage_Courses.dart';

class DataUser extends StatelessWidget {
  DataUser({super.key});

  List<String> category = [
    "Application user",
    "Courses Control",
    "Project Control",
    "Support Courses",
    "Project Order"
  ];

  List<Widget> screen = [
     const AppUser(),
    const HomePageCourses(),
    const HomePageProject(),
    const SupportCourses(),
    const ProjectOrder(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF3A65A9),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "User Data",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: category.length,
                itemBuilder: (BuildContext ctx, index) {
                  return BuildItemAppUser(
                    itemName: category[index],
                    screenNavigator: screen[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class BuildItemAppUser extends StatelessWidget {
  BuildItemAppUser(
      {super.key, required this.itemName, required this.screenNavigator});

  String itemName;
  Widget screenNavigator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return screenNavigator;
        }));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [
                  Color(0xFF3A65A9),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          itemName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}
