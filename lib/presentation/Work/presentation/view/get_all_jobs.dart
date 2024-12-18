import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/login/customTextFormField.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/values_manager.dart';
import '../../data/job_model.dart';
import '../manager/get_work_cubit.dart';

class GetAllJobs extends StatefulWidget {
  const GetAllJobs({super.key,});

  @override
  State<GetAllJobs> createState() => _GetAllJobsState();
}

class _GetAllJobsState extends State<GetAllJobs> {
  TextEditingController searchController = TextEditingController();

  GlobalKey<FormState> searchKey = GlobalKey();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  clear() {
    searchController.clear();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      if (constrain.maxWidth < 600) {
        return BlocConsumer<GetWorkCubit, GetWorkState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Find Jobs",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                child: Container(

                 
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                    
                        //search section
                        /*
                                      SizedBox(
                                                  height: 40.h,
                                                  child: TextFormField(
                                                    controller: searchController,
                                                    keyboardType: TextInputType.text,
                    
                    
                                                    decoration: InputDecoration(
                                                      prefixIcon: const Icon(Icons.search),
                                                      suffixIcon: const Icon(Icons.close,color: Colors.black,),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      isDense: true,
                                                      enabledBorder:  OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(17)),
                            borderSide: BorderSide(color: Colors.grey[350]!, width: 1),
                                                      ),
                                                      hintText: "Find Job",
                                                      hintStyle: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                                                      ),
                                                    ),
                    
                                                  ),
                                      ),
                    
                                       */
                    
                        //spase
                        SizedBox(
                          height: 10.h,
                        ),
                    
                        //number of jop
                        //Text(GetWorkCubit.get(context).innerRequestList.length.toString()),
                        Text(
                          "${GetWorkCubit.get(context).jobList.length} Job Found",
                          style:
                          TextStyle(color: Colors.black54, fontSize: 12.sp),
                        ),
                    
                        //spase
                        SizedBox(
                          height: 15.h,
                        ),
                    
                        //list of jobs
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                             // height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: GetWorkCubit.get(context).jobList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        // constantvar.idRequestWorkCollection = GetWorkCubit.get(context).jobList[index].id;
                                        constantvar.idWork = GetWorkCubit.get(context).jobList[index].id;

                                        GetWorkCubit.get(context).getRequestCollection(context);

                                      },
                                      child: Container(
                                        width: 250.w,
                                        height: 220.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey[350]!)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          child: Column(
                                            children: [
                                              //row fol all details
                                              Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  //image

                                                  Container(
                                                      width: 55.w,
                                                      height: 55.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                          color: Colors.grey[200]),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                        //child: Image(image: NetworkImage(widget.jopModel[index].image!,),width: 40.w,height: 40.h,),
                                                        child: CachedNetworkImage(
                                                          imageUrl: GetWorkCubit.get(context).jobList[index]
                                                              .image!,
                                                          fit: BoxFit.cover,
                                                          alignment:
                                                          Alignment.topCenter,
                                                          height: 55.h,
                                                          width: 55.w,
                                                          errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(Icons
                                                              .cloud_off_outlined),
                                                          placeholder: (context,
                                                              url) =>
                                                              Shimmer.fromColors(
                                                                baseColor: Colors
                                                                    .grey.shade400,
                                                                highlightColor: Colors
                                                                    .grey.shade200,
                                                                child: const SizedBox(
                                                                  width: 200,
                                                                  height: 200,
                                                                ),
                                                              ),
                                                        ),
                                                      )),

                                                  //space
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),

                                                  //details
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        GetWorkCubit.get(context).jobList[index].code!,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: Colors.black),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text:GetWorkCubit.get(context).jobList[index]
                                                              .company!,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                              FontWeight.w700),
                                                          icon: Icons.apartment),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit.get(context).jobList[index]
                                                              .location!,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors.grey),
                                                          icon: Icons.location_on),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit.get(context).jobList[index]
                                                              .phone!,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors.grey),
                                                          icon:
                                                          Icons.phone_android),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      buildRowDetails(index,
                                                          text: GetWorkCubit.get(context).jobList[index]
                                                              .email!,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors.grey),
                                                          icon: Icons.email),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),

                                                      //row for position and Specialization
                                                      Row(
                                                        children: [
                                                          //Specialization
                                                          Container(
                                                            width: 85.w,
                                                            height: 30.h,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    5),
                                                                color: Colors
                                                                    .grey[200]!),
                                                            child: Center(
                                                                child: Text(
                                                                    GetWorkCubit.get(context).jobList[
                                                                    index]
                                                                        .specialization!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        12.sp,
                                                                        color: Colors
                                                                            .grey))),
                                                          ),

                                                          //spase
                                                          SizedBox(
                                                            width: 20.w,
                                                          ),

                                                          //position
                                                          Container(
                                                            width: 115.w,
                                                            height: 30.h,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    5),
                                                                color: Colors
                                                                    .grey[200]!),
                                                            child: Center(
                                                                child: SizedBox(
                                                                    child: Center(
                                                                        child: Text(
                                                                            GetWorkCubit.get(context).jobList[
                                                                            index]
                                                                                .possition!,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                12.sp,
                                                                                color: Colors.grey))))),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                    ],
                                                  ),

                                                  const Spacer(),

                                                  //icon
                                                  const Icon(
                                                    Icons.bookmark,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),

                                              //row for date
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    GetWorkCubit.get(context).jobList[index].date!,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 11.sp),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
      else if (constrain.maxWidth < 900) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Find Jobs",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),

                  //search section
                  /*
                SizedBox(
                  height: 40.h,
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,


                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.close,color: Colors.black,),
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(17)),
                        borderSide: BorderSide(color: Colors.grey[350]!, width: 1),
                      ),
                      hintText: "Find Job",
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black54,
                      ),
                    ),

                  ),
                ),

                 */

                  //spase
                  SizedBox(
                    height: 10.h,
                  ),

                  //number of jop
                  //Text(GetWorkCubit.get(context).innerRequestList.length.toString()),
                  Text(
                    "${GetWorkCubit.get(context).jobList.length} Job Found",
                    style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                  ),

                  //spase
                  SizedBox(
                    height: 15.h,
                  ),

                  //list of jobs
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: GetWorkCubit.get(context).jobList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: GestureDetector(
                                  onTap: () {
                                    // constantvar.idRequestWorkCollection = GetWorkCubit.get(context).jobList[index].id;
                                    constantvar.idWork = GetWorkCubit.get(context).jobList[index].id;
                                    GetWorkCubit.get(context).getRequestCollection(context,);
                                  },
                                  child: Container(
                                    width: 250.w,
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.grey[350]!)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: Column(
                                        children: [
                                          //row fol all details
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //image
                    
                                              Container(
                                                  width: 55.w,
                                                  height: 85.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(7),
                                                      color: Colors.grey[200]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(6.0),
                                                    //child: Image(image: NetworkImage(widget.jopModel[index].image!,),width: 40.w,height: 40.h,),
                                                    child: CachedNetworkImage(
                                                      imageUrl: GetWorkCubit.get(context).jobList[index].image!,
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.topCenter,
                                                      height: 55.h,
                                                      width: 55.w,
                                                      errorWidget: (context, url,
                                                              error) =>
                                                          const Icon(Icons
                                                              .cloud_off_outlined),
                                                      placeholder: (context, url) =>
                                                          Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey.shade400,
                                                        highlightColor:
                                                            Colors.grey.shade200,
                                                        child: const SizedBox(
                                                          width: 200,
                                                          height: 200,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                    
                                              //space
                                              SizedBox(
                                                width: 15.w,
                                              ),
                    
                                              //details
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    GetWorkCubit.get(context).jobList[index].code!,
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  buildRowDetails(index,
                                                      text: GetWorkCubit.get(context).jobList[index].company!,
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      icon: Icons.apartment),
                                                  SizedBox(
                                                    height: 7.h,
                                                  ),
                                                  buildRowDetails(index,
                                                      text: GetWorkCubit.get(context).jobList[index]
                                                          .location!,
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color: Colors.grey),
                                                      icon: Icons.location_on),
                                                  SizedBox(
                                                    height: 7.h,
                                                  ),
                                                  buildRowDetails(index,
                                                      text: GetWorkCubit.get(context).jobList[index].phone!,
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color: Colors.grey),
                                                      icon: Icons.phone_android),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  buildRowDetails(index,
                                                      text: GetWorkCubit.get(context).jobList[index].email!,
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color: Colors.grey),
                                                      icon: Icons.email),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                    
                                                  //row for position and Specialization
                                                  Row(
                                                    children: [
                                                      //Specialization
                                                      Container(
                                                        height: 30.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            color:
                                                                Colors.grey[200]!),
                                                        child: Center(
                                                            child: Text(
                                                                GetWorkCubit.get(context).jobList[index]
                                                                    .specialization!,
                                                                style: TextStyle(
                                                                    fontSize: 11.sp,
                                                                    color: Colors
                                                                        .grey))),
                                                      ),
                    
                                                      //spase
                                                      SizedBox(
                                                        width: 25.w,
                                                      ),
                    
                                                      //position
                                                      Container(
                                                        height: 30.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            color:
                                                                Colors.grey[200]!),
                                                        child: Center(
                                                            child: SizedBox(
                                                                child: Text(
                                                                    GetWorkCubit.get(context).jobList[
                                                                            index]
                                                                        .possition!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10.sp,
                                                                        color: Colors
                                                                            .grey)))),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                ],
                                              ),
                    
                                              const Spacer(),
                    
                                              //icon
                                              const Icon(
                                                Icons.bookmark,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                    
                                          //row for date
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                GetWorkCubit.get(context).jobList[index].date!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Center(child: Text("Desktop"));
      }
    });
  }

  Row buildRowDetails(int index,
      {required String text,
      required TextStyle style,
      required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.black54,
        ),
        SizedBox(
          width: 7.w,
        ),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
