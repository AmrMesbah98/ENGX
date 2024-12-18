import 'package:asec_application/zoomVideo/data/quizDegreeModel.dart';
import 'package:asec_application/zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizControl extends StatefulWidget {
  QuizControl({super.key, required this.quizDegreeModel});

  List<QuizDegreeModel> quizDegreeModel;

  @override
  State<QuizControl> createState() => _QuizControlState();
}

class _QuizControlState extends State<QuizControl> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoomMeetingCubit, ZoomMeetingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "QuizPage Control",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),
            // leading: GestureDetector(
            //     onTap: (){
            //       navigateTo(context,  DashBorad());
            //     },
            //     child: const Icon(Icons.arrow_back)),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      ZoomMeetingCubit.get(context).quizDegreeList.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]),
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomBuildItem(
                                        icon: Icons.person_outline,
                                        label: ZoomMeetingCubit.get(context)
                                            .quizDegreeList[index]
                                            .name!),
                                    CustomBuildItem(
                                        icon: Icons.rotate_90_degrees_ccw,
                                        label: ZoomMeetingCubit.get(context)
                                            .quizDegreeList[index]
                                            .degree!),
                                    CustomBuildItem(
                                        icon: Icons.quiz_outlined,
                                        label: ZoomMeetingCubit.get(context)
                                            .quizDegreeList[index]
                                            .quiz!),
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 6),
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.greenAccent)),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Quiz Degree')
                                    .doc(widget.quizDegreeModel[index].id)
                                    .delete()
                                    .then((value) {
                                  var snackBar = SnackBar(
                                    content: Text(
                                      "Delete Done",
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  setState(() {
                                    ZoomMeetingCubit.get(context)
                                        .getQuizDegreeFunction();
                                  });
                                });
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.black),
                              )),
                        )
                      ],
                    );
                  })),
        );
      },
    );
  }
}

class CustomBuildItem extends StatelessWidget {
  CustomBuildItem({super.key, required this.icon, required this.label});

  IconData icon;
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            width: MediaQuery.of(context).size.width * .01,
          ),
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
