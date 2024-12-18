//   flutter_staggered_animations:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../bloc/CV/cv_control_cubit.dart';
import '../../shared/components/components.dart';
import 'CV_DETAILS_PAGE.dart';


class CvShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery
        .of(context)
        .size
        .width;
    return BlocConsumer<CvControlCubit, CvControlState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cvModel = CvControlCubit.get(context).cvModelListCv;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Go Back"),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.all(_w / 30),
              physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: cvModel.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: -250,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: GestureDetector(
                        onTap: () {
                          navigateTo(
                              context,
                              CvDetailsView(
                                cvModel: CvControlCubit.get(context)
                                    .cvModelList[index],
                                pro: CvControlCubit.get(context)
                                    .cvModelList[index]
                                    .pro!,
                                stNum: CvControlCubit.get(context)
                                    .cvModelList[index].addressStNum!,
                                stName: CvControlCubit.get(context)
                                    .cvModelList[index].addressStName!,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: MediaQuery.of(context).size.width * .27,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent[100],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${cvModel[index].firstname} ",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Email: ${cvModel[index].email} ",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // Text(
                                  //   "PositionCv: ${cvModel[index].positionCv} ",
                                  //   style: const TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
                                  Text(
                                    "Specialization: ${cvModel[index].specialization} ",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ),
        );
  },
);
  }
}