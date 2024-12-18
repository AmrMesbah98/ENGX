import 'package:asec_application/bloc/news/news_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../chossesControl.dart';

class ShowNewsControlTablet extends StatelessWidget {
  const ShowNewsControlTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * .05),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: NewsCubit.get(context).newsModel.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Card(
                                      shadowColor: Colors.transparent,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Column(
                                        children: [
                                          Opacity(
                                            opacity: .5,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .09,
                                              decoration: const BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  24),
                                                          topLeft:
                                                              Radius.circular(
                                                                  24))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                child: Text(
                                                  NewsCubit.get(context)
                                                      .newsModel[index]
                                                      .title!,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .009),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .85,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .12,
                                            child: Card(
                                              elevation: 3,
                                              shadowColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              color: Colors.white60,
                                              child: Center(
                                                  child: Text(
                                                NewsCubit.get(context)
                                                    .newsModel[index]
                                                    .description!,
                                                style: TextStyle(
                                                    height: 1.4,
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .009),
                                          Opacity(
                                            opacity: 0.8,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  24),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  24))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .01),
                                                    const Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      NewsCubit.get(context)
                                                          .newsModel[index]
                                                          .date!,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection("NewsCorner")
                                        .doc(NewsCubit.get(context)
                                            .newsModel[index]
                                            .id)
                                        .delete();

                                    navigateTo(
                                        context, const NewChooseControl());

                                    var snackBar = SnackBar(
                                      content: Text(
                                        "Delete Done",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
