import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/get_topFive/top_five_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../bloc/get_information/user_information_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../model/Top_FIveModel.dart';
import '../../../shared/components/components.dart';
import '../../commentsPage/commentPageForTopFive.dart';
import '../../rate_widget/fiveRate.dart';
import '../../rate_widget/fourRate.dart';
import '../../rate_widget/oneRate.dart';
import '../../rate_widget/threeRate.dart';
import '../../rate_widget/twoRate.dart';
import '../../rate_widget/zeroRate.dart';
import '../../resources/values_manager.dart';

class TopFiveDetailsTablet extends StatefulWidget {
  TopFiveDetailsTablet({
    super.key,
    required this.topFiveModel,
    required this.id,
    // required this.rateSkAutoCad,
    // required this.rateSkRevit,
    // required this.rateSkHvac,
    // required this.rateSkFirefighting,
    // required this.rateSkPluming,
    // required this.rateSkNavisworks,
    // required this.rateSkDynamo,
    // required this.rateSkEnScape,
  });

  final TopFiveModel topFiveModel;
  String id;
  // String rateSkAutoCad;
  // String rateSkRevit;
  // String rateSkHvac;
  // String rateSkFirefighting;
  // String rateSkPluming;
  // String rateSkNavisworks;
  // String rateSkDynamo;
  // String rateSkEnScape;

  @override
  State<TopFiveDetailsTablet> createState() => _TopFiveDetailsTabletState();
}

class _TopFiveDetailsTabletState extends State<TopFiveDetailsTablet> {
  @override
  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> reviewKey = GlobalKey();

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  clear() {
    commentController.clear();
  }

  void initState() {
    print("id is >>> ${widget.id}");

    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<GetTopFiveCubit, TopFiveState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFe5e5e5),
                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.topFiveModel.image!,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      //height: MediaQuery.of(context).size.height * .38,
                      height: MediaQuery.of(context).size.height * .45,
                      width: double.infinity,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.cloud_off_outlined),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        child: const SizedBox(
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Rate  ",
                                style: TextStyle(color: Colors.yellowAccent),
                              ),
                              Text(
                                widget.topFiveModel.rate!,
                                style:
                                    const TextStyle(color: Colors.yellowAccent),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 17,
                                color: Colors.yellowAccent,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                widget.topFiveModel.numberUserRate.toString(),
                                style:
                                    const TextStyle(color: Colors.yellowAccent),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopFiveCard(
                        name: widget.topFiveModel.name!,
                        email: widget.topFiveModel.email!,
                        phone: widget.topFiveModel.phone!,
                        address: widget.topFiveModel.address!,
                        experience: widget.topFiveModel.skill1!,
                        ex: widget.topFiveModel.exp!,
                        linkedIn: widget.topFiveModel.linkedin!,
                        nameLinkedin: widget.topFiveModel.name!,

                        //for skills>>>>>>>>>>>>>>>>>>>>>>>

                        /*
                        skills:

                        //for skills>>>>>>>>>>>>>>>>>>>>>>>

                        widget.topFiveModel.rateSkAutoCad!.isNotEmpty ||
                            widget.topFiveModel.rateSkRevit!.isNotEmpty ||
                            widget.topFiveModel.rateSkHvac!.isNotEmpty ||
                            widget.topFiveModel.rateSkFirefighting!.isNotEmpty ||
                            widget.topFiveModel.rateSkPluming!.isNotEmpty ||
                            widget.topFiveModel.rateSkNavisworks!.isNotEmpty ||
                            widget.topFiveModel.rateSkDynamo!.isNotEmpty ||
                            widget.topFiveModel.rateSkEnScape!.isNotEmpty
                            ? skillsWidget(context)
                            :  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60.h),
                            const Text('Loading Skills ...'),
                          ],
                        )


                         */
                      ),

                      //space
                      SizedBox(
                        height: 10.h,
                      ),

                      /////////////////////////////////////////////////

                      //for review rate and comment
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
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
                                borderRadius:
                                    BorderRadius.circular(AppSize.s15)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //for rate
                                  Row(
                                    children: [
                                      //icon
                                      const CircleAvatar(
                                        backgroundColor: Colors.white54,
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 22,
                                        ),
                                      ),

                                      //space
                                      SizedBox(width: 20.w),

                                      //rate
                                      RatingBar.builder(
                                        initialRating: constantvar
                                            .rateUserTopFive!
                                            .toDouble(),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        onRatingUpdate: (rating) async {
                                          print(rating.toInt().toString());

                                          GetTopFiveCubit.get(context)
                                              .addUserNumber();

                                          widget.topFiveModel.rateUser!.add(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);

                                          FirebaseFirestore.instance
                                              .collection('Top Five')
                                              .doc(widget.id)
                                              .update({
                                            "rateUser":
                                                widget.topFiveModel.rateUser
                                          });

                                          // for save old rate in innerCollection
                                          FirebaseFirestore.instance
                                              .collection("Top Five")
                                              .doc(widget.id)
                                              .collection("RateOfUser")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .set({"oldRate": rating});

                                          widget.topFiveModel.rateUser!
                                                  .contains(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                              ? GetTopFiveCubit.get(context)
                                                  .editRateCalculation(
                                                      collectionName:
                                                          'Top Five',
                                                      documentId: widget.id,
                                                      oldRate: constantvar
                                                          .rateUserTopFive!,
                                                      rating: rating,
                                                      context: context)
                                              : GetTopFiveCubit.get(context)
                                                  .ratingCalculation(
                                                      collectionName:
                                                          'Top Five',
                                                      documentId: widget.id,
                                                      rating: rating,
                                                      context: context);

                                          // FirebaseFirestore.instance.collection('Top Five').doc(widget.id).update(
                                          //     {
                                          //       'numberUserRate':widget.topFiveModel.numberUserRate +1
                                          //     });

                                          setState(() {
                                            GetTopFiveCubit.get(context)
                                                .getTopFiveSnap();
                                          });

                                          var snackBar = SnackBar(
                                            content: Text(
                                              "Your Rate is Done",
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                          print(
                                              'numberUserRate>>>>>${widget.topFiveModel.numberUserRate}');

                                          await GetTopFiveCubit.get(context)
                                              .getTopFiveSnap();
                                        },
                                      ),
                                    ],
                                  ),

                                  Form(
                                      key: reviewKey,
                                      child: Column(
                                        children: [
                                          //for comment
                                          Row(
                                            children: [
                                              //icon
                                              const CircleAvatar(
                                                backgroundColor: Colors.white54,
                                                child: Icon(
                                                  Icons.comment_outlined,
                                                  color: Colors.black,
                                                  size: 22,
                                                ),
                                              ),

                                              //space
                                              SizedBox(width: 20.w),

                                              //comment field
                                              SizedBox(
                                                width: 90.w,
                                                child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintText: S
                                                            .of(context)
                                                            .EnterYourComment,
                                                        hintStyle: TextStyle(
                                                            fontSize: 8.sp)),
                                                    controller:
                                                        commentController,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return S
                                                            .of(context)
                                                            .PleaseEnterYourComment;
                                                      }
                                                    }),
                                              ),

                                              const Spacer(),

                                              //for button send
                                              TextButton(
                                                  onPressed: () async {
                                                    if (reviewKey.currentState!
                                                        .validate()) {
                                                      if (widget.topFiveModel
                                                              .nameUser!
                                                              .contains(
                                                                  '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}') ||
                                                          widget.topFiveModel
                                                              .comment!
                                                              .contains(
                                                                  commentController
                                                                      .text)) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        clear();
                                                      } else {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Top Five')
                                                            .doc(widget.id)
                                                            .update({
                                                          'comment': FieldValue
                                                              .arrayUnion([
                                                            commentController
                                                                .text
                                                          ]),
                                                          'nameUser': FieldValue
                                                              .arrayUnion([
                                                            //'${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName} ${Random().nextInt(10)}'
                                                            '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'
                                                          ]),
                                                        }).then((value) async {
                                                          clear();

                                                          await GetTopFiveCubit
                                                                  .get(context)
                                                              .getTopFiveSnap();

                                                          var snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                              "Your Comment is Done",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp),
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        });
                                                        await GetTopFiveCubit
                                                                .get(context)
                                                            .getTopFiveSnap();

                                                        print('ok');
                                                        print(commentController
                                                            .text);
                                                      }
                                                    }
                                                  },
                                                  child: Text(
                                                    S.of(context).Send,
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )),

                                  //space
                                  SizedBox(
                                    height: 15.h,
                                  ),

                                  //for button see more
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40.w),
                                    //padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //for show rate and comments

                                        GestureDetector(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  CommentPageForTopFive(
                                                    topFiveModelModel:
                                                        widget.topFiveModel,
                                                    id: widget.id,
                                                  ));
                                            },
                                            child: Row(
                                              children: [
                                                //see more
                                                Text(
                                                  S.of(context).SeeMore,
                                                  style: TextStyle(
                                                      fontSize: 9.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                //space
                                                SizedBox(
                                                  width: 7.w,
                                                ),
                                                //icon
                                                const Icon(
                                                  Icons.double_arrow_outlined,
                                                  size: 15,
                                                  color: Colors.black,
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),

                                  //space
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      /////////////////////////////////////////////////

                      //space
                      SizedBox(height: 8.h),
                      //tex All Comments
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Comment",
                          style: TextStyle(
                              fontSize: 9.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      //space
                      SizedBox(height: 5.h),

                      //view comment
                      widget.topFiveModel.comment!.isEmpty
                          ? Center(
                              child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                "No Comments Yet .......",
                                style: TextStyle(fontSize: 9.sp),
                              ),
                            ))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              //itemCount: widget.instructorModel.comment!.length,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Card(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .94,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //row for name

                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                top: 5.h,
                                                bottom: 5.h),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  size: 20,
                                                ),
                                                //space
                                                SizedBox(
                                                  width: 7.w,
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      //name user
                                                      Text(
                                                        widget.topFiveModel
                                                            .nameUser![index],
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),

                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //row for comment

                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w, bottom: 5.h),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.comment,
                                                  size: 17,
                                                ),
                                                //space
                                                SizedBox(
                                                  width: 7.w,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    widget.topFiveModel
                                                        .comment![index],
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                      /////////////////////////////////////////////////
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding skillsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s7),
      child: Column(
        children: [
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: const Row(
              children: [
                Text(
                  "Skills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s20)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFFe5e5e5),
                              Color(0xFFFFFFFF),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(AppSize.s20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),

                        //rateSkAutoCad

                        widget.topFiveModel.rateSkAutoCad!.isNotEmpty
                            ? itemSkills(
                                "AutoCad", widget.topFiveModel.rateSkAutoCad!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkRevit

                        widget.topFiveModel.rateSkRevit!.isNotEmpty
                            ? itemSkills(
                                "Revit", widget.topFiveModel.rateSkRevit!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkHvac

                        widget.topFiveModel.rateSkHvac!.isNotEmpty
                            ? itemSkills(
                                "HVAC", widget.topFiveModel.rateSkHvac!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkFirefighting

                        widget.topFiveModel.rateSkFirefighting!.isNotEmpty
                            ? itemSkills("Firefighting",
                                widget.topFiveModel.rateSkFirefighting!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkPluming

                        widget.topFiveModel.rateSkPluming!.isNotEmpty
                            ? itemSkills(
                                "Plumbing", widget.topFiveModel.rateSkPluming!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkNavisworks

                        widget.topFiveModel.rateSkNavisworks!.isNotEmpty
                            ? itemSkills("Navisworks",
                                widget.topFiveModel.rateSkNavisworks!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkDynamo

                        widget.topFiveModel.rateSkDynamo!.isNotEmpty
                            ? itemSkills(
                                "Dynamo", widget.topFiveModel.rateSkDynamo!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        //rateSkEnScape

                        widget.topFiveModel.rateSkEnScape!.isNotEmpty
                            ? itemSkills(
                                "EnScape", widget.topFiveModel.rateSkEnScape!)
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * .0001,
                              ),

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                )),
          ),

          /*
                                            const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Row(
                                                  children: [
                                                    Text("Skills",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                                                  ],
                                              ),
                                            ),

                                            const SizedBox(height: 10),

                                             */

          /*

                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(AppSize.s20),

                                              ),
                                              width: MediaQuery.of(context).size.width * 1,

                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  child: Card(
                                                    elevation: 10,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(AppSize.s20)),
                                                    child: Container(
                                                      decoration:  BoxDecoration(
                            gradient:  const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Color(0xFFFFFFFF),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(AppSize.s20)),
                                                      child: SingleChildScrollView(
                                                        physics: NeverScrollableScrollPhysics(),

                                                        child: Column(

                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star,color: Colors.grey,),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "$skills1 ",

                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star,color: Colors.grey,),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "$skills2 ",

                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                            ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ),
                                            ),

                                             */
        ],
      ),
    );
  }

  Padding itemSkills(String titleName, String rateSkillName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            // "$skills1 ",
            titleName,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const Spacer(),

          //for rate
          constantvar.zeroRate.contains(rateSkillName)
              ? zeroRateWidget()
              :

              ////////////////////////////////////////////////////////////////////////////

              constantvar.oneRate.contains(rateSkillName)
                  ? oneRateWidget()
                  :

                  ////////////////////////////////////////////////////////////////////////////

                  constantvar.twoRate.contains(rateSkillName)
                      ? twoRateWidget()
                      :

                      ////////////////////////////////////////////////////////////////////////////

                      constantvar.threeRate.contains(rateSkillName)
                          ? threeRateWidget()
                          :

                          ////////////////////////////////////////////////////////////////////////////

                          constantvar.fourRate.contains(rateSkillName)
                              ? fourRateWidget()
                              :

                              ////////////////////////////////////////////////////////////////////////////

                              constantvar.fiveRate.contains(rateSkillName)
                                  ? fiveRateWidget()
                                  :

                                  ////////////////////////////////////////////////////////////////////////////

                                  zeroRateWidget()

          ////////////////////////////////////////////////////////////////////////////
        ],
      ),
    );
  }
}

class TopFiveCard extends StatelessWidget {
  TopFiveCard(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.experience,
      required this.ex,
      //required this.skills
      required this.linkedIn,
      required this.nameLinkedin});

  final String name;

  //final String image;

  final String email;

  final String phone;

  final String address;

  final String experience;

  final List ex;

  TopFiveModel? topFiveModel;

  //final Widget skills;

  final String linkedIn;
  final String nameLinkedin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s7),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s20)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFFe5e5e5),
                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(AppSize.s20)),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    BuildCard(
                      iconData: Icons.person,
                      data: name,
                    ),
                    BuildCard(
                      iconData: Icons.email_outlined,
                      data: email,
                    ),
                    BuildCard(
                      iconData: Icons.phone,
                      data: phone,
                    ),
                    BuildCard(
                      iconData: Icons.location_on_outlined,
                      data: address,
                    ),
                    //linked in
                    GestureDetector(
                      onTap: () {
                        launchURL(urlLink: linkedIn);
                      },
                      child: BuildCard(
                        iconData: FontAwesomeIcons.linkedin,
                        data: nameLinkedin,
                      ),
                    ),

                    //for experience
                    /*
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .02),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text(
                            "Experience",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.s20)),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFe5e5e5),
                                    Color(0xFFFFFFFF),
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20)),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .28,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ex.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .02),
                                      Expanded(child: Text(ex[index])),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),

                     */

                    //skills,

                    //for old skills
                    /*
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("Skills",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                     */

                    /*

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s20),

                      ),
                      width: MediaQuery.of(context).size.width * 1,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s20)),
                          child: Container(
                            decoration:  BoxDecoration(
                                gradient:  const LinearGradient(
                                    colors: [
                                      Color(0xFFe5e5e5),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(AppSize.s20)),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),

                              child: Column(

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star,color: Colors.grey,),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "$skills1 ",

                                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star,color: Colors.grey,),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "$skills2 ",

                                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                     */

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({
    super.key,
    required this.iconData,
    required this.data,
  });

  final IconData iconData;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white54,
              child: Icon(iconData)),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              data,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

launchURL({required String urlLink}) async {
  final Uri url = Uri.parse(urlLink);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}
