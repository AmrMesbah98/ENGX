import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/CV/cv_control_cubit.dart';
import 'package:asec_application/presentation/Work/presentation/view/share_cv_for_job.dart';
import 'package:asec_application/presentation/Work/presentation/view/update_state_job.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../bloc/DataId/id_data_cubit.dart';
import '../../data/inner_request_model.dart';
import '../manager/get_work_cubit.dart';
import 'get_all_cv_user.dart';

class GetDetailsJob extends StatefulWidget {
  GetDetailsJob({super.key, required this.innerRequestModel, required this.id});

  List<InnerRequestModel>? innerRequestModel;
  String? id;

  // InnerRequestModel innerJob;
  // String id;

  @override
  State<GetDetailsJob> createState() => _GetDetailsJobState();
}

class _GetDetailsJobState extends State<GetDetailsJob> {
  @override
  void initState() {
    print("id is >>>>> ${widget.id}");
    CvControlCubit.get(context).getMyCv();

    super.initState();
  }

  bool? _exists;

  Future<bool> checkIfDocExists(String collectionPath, String docId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(docId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking if document exists: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetWorkCubit, GetWorkState>(
      listener: (context, state) {
        if (state is GetResponseCvSuccess) {
          navigateTo(
              context,
              GetAllCvUser(
                innerResponseModel: GetWorkCubit.get(context).innerResponseList,
                id: constantvar.idWork,
              ));
        }

        if (state is GetResponseCvSuccessLength) {
          print(
              "====================================================${constantvar.innerResponseCounter}");
        }
      },
      builder: (context, state) {
        return BlocConsumer<CvControlCubit, CvControlState>(
          listener: (context, state) {},
          builder: (context, state) {
            var myCv = CvControlCubit.get(context).cvPersonalModel;
            return LayoutBuilder(builder: (context, constrain) {
              if (constrain.maxWidth < 600) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text(
                      "More Details",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  //bottom nav bar
                  bottomNavigationBar: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                          spreadRadius: 0.0,
                          offset: Offset(1.0, 0),
                        ),
                      ],
                    ),
                    child: BottomAppBar(
                      height: 70.h,
                      color: Colors.white,
                      shadowColor: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Apply Now
                                GestureDetector(
                                  onTap: () {
                                    if (widget
                                            .innerRequestModel![index].active ==
                                        "Not Active") {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 20.h),
                                              backgroundColor: Colors.grey[300],
                                              title: const Text("Warning"),
                                              content: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .warning_amber_outlined)),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.h),
                                                        child: Text(
                                                          "Sorry! This Job Is Not Active Now ",
                                                          style: TextStyle(
                                                              fontSize: 10.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .blue[300],
                                                            textStyle: TextStyle(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Ok")),
                                              ],
                                            );
                                          });
                                    } else {
                                      // check for this user make cv to allay to job
                                      if (IdDataCubit.get(context)
                                          .idListData!
                                          .idList!
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 20.h),
                                                backgroundColor:
                                                    Colors.grey[300],
                                                title: const Text(
                                                    "You Will Send Your CV"),
                                                content: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: const Icon(Icons
                                                              .warning_amber_outlined)),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.h),
                                                          child: Text(
                                                            "Warning Do not try to send your CV more than once  ",
                                                            style: TextStyle(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                semanticLabel: "asdasdasd",
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      //ok
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      100],
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () {
                                                            print(
                                                                "568464646464646464646464646464");

                                                            if (widget
                                                                    .innerRequestModel![
                                                                        index]
                                                                    .active ==
                                                                "Active") {
                                                              GetWorkCubit.get(context)
                                                                  .setCvForJob(
                                                                      firstname:
                                                                          myCv!
                                                                              .firstname!,
                                                                      lastname: myCv
                                                                          .lastname!,
                                                                      email: myCv
                                                                          .email!,
                                                                      phone: myCv
                                                                          .phone!,
                                                                      linkedin: myCv
                                                                          .linkedin!,
                                                                      gpa: myCv
                                                                          .gpa!,
                                                                      graduationYear: myCv
                                                                          .graduationYear!,
                                                                      positionCv: myCv
                                                                          .positionCv!,
                                                                      addressStNum:
                                                                          "9",
                                                                      addressStName:
                                                                          "sad",
                                                                      address: myCv
                                                                          .address!,
                                                                      facebook: myCv
                                                                          .facebook!,
                                                                      totalLikeCv: myCv
                                                                          .like!,
                                                                      faculty: myCv
                                                                          .faculty!,
                                                                      startDate: myCv
                                                                          .startDate!,
                                                                      shareProject: myCv
                                                                          .shareProject!,
                                                                      specialization:
                                                                          myCv
                                                                              .specialization!,
                                                                      companyName:
                                                                          myCv
                                                                              .companyName!,
                                                                      state: myCv
                                                                          .state!,
                                                                      military: myCv
                                                                          .military!,
                                                                      pro: myCv
                                                                          .pro!,
                                                                      work: myCv
                                                                          .work!,
                                                                      isTrain: myCv
                                                                          .isTrain!,
                                                                      listHobbies:
                                                                          myCv
                                                                              .listHobbies!)
                                                                  .then(
                                                                      (value) {
                                                                var snackBar =
                                                                    SnackBar(
                                                                  content: Text(
                                                                    "Your Cv Is Applied ${myCv.firstname}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.sp),
                                                                  ),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snackBar);

                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            } else {
                                                              var snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                  "This Job Not Active Now",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            }
                                                          },
                                                          child: Text("OK",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black))),
                                                      //  SizedBox(width: 5.w),
                                                      //cancel
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Cansel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                      //    SizedBox(width: 5.w),
                                                      //create cv
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                          .yellow[
                                                                      200],
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () {
                                                            print(
                                                                "568464646464646464646464646464");

                                                            navigateTo(context,
                                                                ShareCVForJob());
                                                          },
                                                          child: Text(
                                                              "Create CV",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black))),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        navigateTo(context, ShareCVForJob());
                                      }
                                    }
                                  },
                                  child: Container(
                                      width: 140.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.green[300],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Apply Now',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),

                                //All CV
                                GestureDetector(
                                  onTap: () {
                                    // innerResponseList

                                    constantvar.idResponseWorkCollection =
                                        widget.id;
                                    GetWorkCubit.get(context)
                                        .getResponseCollection(context,
                                            id: widget.id!);

                                    /*
                                 if (widget.innerRequestModel![index].email ==
                                    UserAppInformationCubit.get(context)
                                        .applicationUser!
                                        .email) {
                                  //constantvar.idResponseWorkCollection = GetWorkCubit.get(context).innerResponseList[index].id;
                                  constantvar.idResponseWorkCollection =
                                      widget.id;
                                  GetWorkCubit.get(context)
                                      .getResponseCollection(context);
                                }

                                else {
                                  Fluttertoast.showToast(
                                      msg: "You are not the owner of the job",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[300],
                                      textColor: Colors.black54,
                                      fontSize: 16.0);
                                }
                                 */
                                  },
                                  child: Container(
                                      width: 100.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.orange[300],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Show CV',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //spase
                          SizedBox(
                            height: 10.h,
                          ),

                          //details
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: GetWorkCubit.get(context)
                                  .innerRequestList
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //for card details
                                      Card(
                                        elevation: 1,
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]!)),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 270.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey[300]!)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //image
                                                Container(
                                                    width: 100.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      //child: Image(image: NetworkImage(widget.innerRequestModel![index].image!,),width: 30.w,height: 30.h,),
                                                      child: CachedNetworkImage(
                                                        imageUrl: widget
                                                            .innerRequestModel![
                                                                index]
                                                            .image!,
                                                        fit: BoxFit.fill,
                                                        alignment:
                                                            Alignment.topCenter,
                                                        height: 70.h,
                                                        width: 70.w,
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
                                                  height: 10.h,
                                                ),

                                                //name job and activated type
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      widget
                                                          .innerRequestModel![
                                                              index]
                                                          .nameJob
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      "( ${widget.innerRequestModel![index].active!} )",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                //location
                                                Text(
                                                  widget
                                                      .innerRequestModel![index]
                                                      .location!,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        height: 50.h,
                                                        width: 140.w,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .purple[200],
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        50))),
                                                        child: Center(
                                                          child: Text(
                                                              widget
                                                                  .innerRequestModel![
                                                                      index]
                                                                  .time!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white)),
                                                        )),
                                                    Container(
                                                      height: 50.h,
                                                      width: 140.w,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .orange[300],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          50),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          50))),
                                                      child: Center(
                                                        child: Text(
                                                            widget
                                                                .innerRequestModel![
                                                                    index]
                                                                .specialization!,
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //row for time and specialization
                                                /*
                                                  Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //time
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      child: Container(
                                                        height: 70.h,
                                                        width: 140,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                .grey[200]),
                                                        child: Center(
                                                            child: Text(
                                                                widget
                                                                    .innerRequestModel![
                                                                        index]
                                                                    .time!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .grey))),
                                                      ),
                                                    ),

                                                    Spacer(),

                                                    //specialization
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Container(
                                                        height: 70.h,
                                                        width: 180,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                .grey[200]!),
                                                        child: Center(
                                                            child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w),
                                                          child: Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              softWrap: true,
                                                              maxLines: 2,
                                                              widget
                                                                  .innerRequestModel![
                                                                      index]
                                                                  .specialization!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .grey)),
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                 */
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      //for row salary section
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //salary
                                          Column(
                                            //crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //icon
                                              Container(
                                                width: 45.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Colors.green[50]),
                                                child: Icon(
                                                  Icons.payments,
                                                  color: Colors.green[300],
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              //text Salary
                                              Text(
                                                "salary",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.grey),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              // Salary
                                              Text(
                                                widget.innerRequestModel![index]
                                                    .salary!,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),

                                          //job type
                                          Column(
                                            children: [
                                              //icon
                                              Container(
                                                width: 45.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Colors.purple[50]),
                                                child: Icon(
                                                  Icons.work_history,
                                                  color: Colors.purple[200],
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              //text jop type
                                              Text(
                                                "Jop Type",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.grey),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              // jop type
                                              Text(
                                                widget.innerRequestModel![index]
                                                    .jopType!,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),

                                          //position
                                          Column(
                                            children: [
                                              //icon
                                              Container(
                                                width: 45.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Colors.orange[50]),
                                                child: Icon(
                                                  Icons.radar,
                                                  color: Colors.orange[300],
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              //text position
                                              Text(
                                                "Position",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.grey),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              // position
                                              Text(
                                                widget.innerRequestModel![index]
                                                    .possition!,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),

                                      //space
                                      SizedBox(
                                        height: 25.h,
                                      ),

                                      //for container experience
                                      Container(
                                        width: 130.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200]),
                                        child: Center(
                                            child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Experience",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Spacer(),
                                              Text(
                                                  widget
                                                      .innerRequestModel![index]
                                                      .experience!,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),
                                        )),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 15.h,
                                      ),

                                      //for container job description
                                      Container(
                                        width: 130.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200]),
                                        child: Center(
                                            child: Text(
                                          "Job Description",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //for job description
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Flexible(
                                              child: Text(
                                            widget.innerRequestModel![index]
                                                .desc!,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ))
                                        ],
                                      ),

                                      //space
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      //for container job skills
                                      Container(
                                        width: 130.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200]),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 7.h),
                                          child: Text(
                                            "Job Skills",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //for job skills
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Flexible(
                                              child: Text(
                                            widget.innerRequestModel![index]
                                                .skills!,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ))
                                        ],
                                      ),

                                      //spase
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                      ),

                                      //button update state job
                                      FirebaseAuth.instance.currentUser!
                                                  .email ==
                                              "admin@gmail.com"
                                          ? defaultButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .9,
                                              isUpperCase: true,
                                              sizeText: 18,
                                              background: Colors.grey[200]!,
                                              radius: 10,
                                              function: () {
                                                navigateTo(
                                                    context,
                                                    UpdateStateOfJob(
                                                      id: widget.id,
                                                      innerDoc: widget
                                                          .innerRequestModel![
                                                              index]
                                                          .id,
                                                    ));
                                              },
                                              text: "Update State of Job",
                                            )
                                          : Container(
                                              height: 0.1.h,
                                              child: const Text(""),
                                            ),

                                      //space
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .12,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (constrain.maxWidth < 900) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text(
                      "More Details",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  //bottom nav bar
                  bottomNavigationBar: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                          spreadRadius: 0.0,
                          offset: Offset(1.0, 0),
                        ),
                      ],
                    ),
                    child: BottomAppBar(
                      height: 40.h,
                      color: Colors.white,
                      shadowColor: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 7.h, left: 30.w, right: 30.w),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Apply Now
                                GestureDetector(
                                  onTap: () {
                                    if (widget
                                            .innerRequestModel![index].active ==
                                        "Not Active") {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 20.h),
                                              backgroundColor: Colors.grey[300],
                                              title: const Text("Warning"),
                                              content: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .warning_amber_outlined)),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.h),
                                                        child: const Text(
                                                            "Sorry! This Job Is Not Active Now "),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              semanticLabel: "asdasdasd",
                                              actions: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.w),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue[
                                                                      300],
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Ok")),
                                                ),
                                              ],
                                            );
                                          });
                                    } else {
                                      // check for this user make cv to allay to job
                                      if (IdDataCubit.get(context)
                                          .idListData!
                                          .idList!
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 20.h),
                                                backgroundColor:
                                                    Colors.grey[300],
                                                title: const Text(
                                                    "You Will Send Your CV"),
                                                content: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: const Icon(Icons
                                                              .warning_amber_outlined)),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.h),
                                                          child: const Text(
                                                              "Warning Do not try to send your CV more than once  "),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      300],
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () {
                                                            print(
                                                                "568464646464646464646464646464");

                                                            if (widget
                                                                    .innerRequestModel![
                                                                        index]
                                                                    .active ==
                                                                "Active") {
                                                              GetWorkCubit.get(context)
                                                                  .setCvForJob(
                                                                      firstname:
                                                                          myCv!
                                                                              .firstname!,
                                                                      lastname: myCv
                                                                          .lastname!,
                                                                      email: myCv
                                                                          .email!,
                                                                      phone: myCv
                                                                          .phone!,
                                                                      linkedin: myCv
                                                                          .linkedin!,
                                                                      gpa: myCv
                                                                          .gpa!,
                                                                      graduationYear: myCv
                                                                          .graduationYear!,
                                                                      positionCv: myCv
                                                                          .positionCv!,
                                                                      addressStNum:
                                                                          "9",
                                                                      addressStName:
                                                                          "sad",
                                                                      address: myCv
                                                                          .address!,
                                                                      facebook: myCv
                                                                          .facebook!,
                                                                      totalLikeCv: myCv
                                                                          .like!,
                                                                      faculty: myCv
                                                                          .faculty!,
                                                                      startDate: myCv
                                                                          .startDate!,
                                                                      shareProject: myCv
                                                                          .shareProject!,
                                                                      specialization:
                                                                          myCv
                                                                              .specialization!,
                                                                      companyName:
                                                                          myCv
                                                                              .companyName!,
                                                                      state: myCv
                                                                          .state!,
                                                                      military: myCv
                                                                          .military!,
                                                                      pro: myCv
                                                                          .pro!,
                                                                      work: myCv
                                                                          .work!,
                                                                      isTrain: myCv
                                                                          .isTrain!,
                                                                      listHobbies:
                                                                          myCv
                                                                              .listHobbies!)
                                                                  .then(
                                                                      (value) {
                                                                var snackBar =
                                                                    SnackBar(
                                                                  content: Text(
                                                                    "Your Cv Is Applied ${myCv.firstname}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.sp),
                                                                  ),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snackBar);

                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            } else {
                                                              var snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                  "This Job Not Active Now",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            }
                                                          },
                                                          child: Text("OK")),
                                                      //  SizedBox(width: 5.w),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .red[300],
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Cansel")),
                                                      //    SizedBox(width: 5.w),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue[
                                                                      300],
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () {
                                                            print(
                                                                "568464646464646464646464646464");

                                                            navigateTo(context,
                                                                ShareCVForJob());
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              "Create CV")),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        navigateTo(context, ShareCVForJob());
                                      }
                                    }
                                  },
                                  child: Container(
                                      width: 140.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          'Apply Now',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),

                                //All CV
                                GestureDetector(
                                  onTap: () {
                                    constantvar.idResponseWorkCollection =
                                        widget.id;
                                    GetWorkCubit.get(context)
                                        .getResponseCollection(context,
                                            id: widget.id!);

                                    /*
                                 if (widget.innerRequestModel![index].email ==
                                    UserAppInformationCubit.get(context)
                                        .applicationUser!
                                        .email) {
                                  //constantvar.idResponseWorkCollection = GetWorkCubit.get(context).innerResponseList[index].id;
                                  constantvar.idResponseWorkCollection =
                                      widget.id;
                                  GetWorkCubit.get(context)
                                      .getResponseCollection(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "You are not the owner of the job",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[300],
                                      textColor: Colors.black54,
                                      fontSize: 16.0);
                                }
                                 */
                                  },
                                  child: Container(
                                      width: 140.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.blueGrey),
                                      child: Center(
                                        child: Text(
                                          'Show CV',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //spase
                          SizedBox(
                            height: 10.h,
                          ),

                          //details
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemCount: GetWorkCubit.get(context)
                                  .innerRequestList
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //for card details
                                      Card(
                                        elevation: 1,
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]!)),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 220.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey[300]!)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //image
                                                Container(
                                                    width: 40.w,
                                                    height: 60.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color:
                                                            Colors.grey[100]),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      //child: Image(image: NetworkImage(widget.innerRequestModel![index].image!,),width: 30.w,height: 30.h,),
                                                      child: CachedNetworkImage(
                                                        imageUrl: widget
                                                            .innerRequestModel![
                                                                index]
                                                            .image!,
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.topCenter,
                                                        height: 45.h,
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
                                                  height: 10.h,
                                                ),

                                                //name job and activated type
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      widget
                                                          .innerRequestModel![
                                                              index]
                                                          .nameJob
                                                          .toString()!,
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      "( ${widget.innerRequestModel![index].active!} )",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                //location
                                                Text(
                                                  widget
                                                      .innerRequestModel![index]
                                                      .location!,
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),

                                                //row for time and specialization
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //time
                                                    Container(
                                                      width: 85.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors
                                                              .grey[200]!),
                                                      child: Center(
                                                          child: Text(
                                                              widget
                                                                  .innerRequestModel![
                                                                      index]
                                                                  .time!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .grey))),
                                                    ),

                                                    //spase
                                                    SizedBox(
                                                      width: 25.w,
                                                    ),

                                                    //position
                                                    Container(
                                                      width: 85.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors
                                                              .grey[200]!),
                                                      child: Center(
                                                          child: Text(
                                                              widget
                                                                  .innerRequestModel![
                                                                      index]
                                                                  .specialization!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .grey))),
                                                    ),
                                                  ],
                                                ),

                                                //show cv
                                                /*
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                //GetWorkCubit.get(context).innerResponseList;

                                                //constantvar.idWorkCollection = GetWorkCubit.get(context).jobList[index].id;
                                                //constantvar.idResponseWorkCollection = GetWorkCubit.get(context).innerResponseList[index].id;
                                                constantvar.idResponseWorkCollection = widget.id;
                                                await GetWorkCubit.get(context).getResponseCollection(context);




                                              },
                                              child: const Text("See CV Users")
                                          )
                                        ],
                                      )

                                       */
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      //for row salary section
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //salary
                                          Column(
                                            //crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //icon
                                              Container(
                                                width: 45.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Colors.green[50]),
                                                child: Icon(
                                                  Icons.payments,
                                                  color: Colors.green[300],
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              //text Salary
                                              Text(
                                                "salary",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              // Salary
                                              Text(
                                                widget.innerRequestModel![index]
                                                    .salary!,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),

                                          //job type
                                          Column(
                                            children: [
                                              //icon
                                              Container(
                                                width: 45.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Colors.purple[50]),
                                                child: Icon(
                                                  Icons.work_history,
                                                  color: Colors.purple[200],
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              //text jop type
                                              Text(
                                                "Jop Type",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              // jop type
                                              Text(
                                                widget.innerRequestModel![index]
                                                    .jopType!,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),

                                          //position
                                          Column(
                                            children: [
                                              //icon
                                              Container(
                                                width: 45.w,
                                                height: 45.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Colors.orange[50]),
                                                child: Icon(
                                                  Icons.radar,
                                                  color: Colors.orange[300],
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              //text position
                                              Text(
                                                "Position",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              ),
                                              //space
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              // position
                                              Text(
                                                widget.innerRequestModel![index]
                                                    .possition!,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),

                                      //space
                                      SizedBox(
                                        height: 25.w,
                                      ),

                                      //for container job description
                                      Container(
                                        width: 130.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red[200]),
                                        child: Center(
                                            child: Text(
                                          "Job Description",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //for job description
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Flexible(
                                              child: Text(
                                            widget.innerRequestModel![index]
                                                .desc!,
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ))
                                        ],
                                      ),

                                      //space
                                      SizedBox(
                                        height: 20.w,
                                      ),

                                      //for container job skills
                                      Container(
                                        width: 130.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200]),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 7.h),
                                          child: Text(
                                            "Job Skills",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),

                                      //space
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //for job skills
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Flexible(
                                              child: Text(
                                            widget.innerRequestModel![index]
                                                .skills!,
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ))
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Desktop"),
                );
              }
            });
          },
        );
      },
    );
  }
}
