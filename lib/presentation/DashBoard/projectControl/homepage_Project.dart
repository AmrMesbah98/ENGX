import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_project/project_cubit.dart';
import '../../resources/values_manager.dart';
import 'addproject.dart';
import 'control project.dart';
import 'itemProjectControl.dart';

class HomePageProject extends StatelessWidget {
  const HomePageProject({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetProjectFailure) {
          return Text(state.errMessage);
        } else if (state is GetProjectSuccess) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
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
              iconTheme: const IconThemeData(color: Colors.black54),
              title: const Text(
                "Project Controller ",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppSize.s8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const AppProject();
                        }));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .1,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Text(
                          "Add Project",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.project.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return ControlProject(
                                      projectModel: state.project[index]);
                                }));
                              },
                              child: ItemProjectCard(
                                  image: state.project[index].iamge!,
                                  category: state.project[index].category!,
                                  date: state.project[index].date!,
                                  details: state.project[index].details!,
                                  location: state.project[index].location!,
                                  photo: state.project[index].photo!,
                                  id: state.project[index].id!));
                        })
                  ],
                ),
              ),
            ),
          );
        }
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .26,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height: MediaQuery.of(context).size.width * .3,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
