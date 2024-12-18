import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_information/user_information_cubit.dart';
import '../../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../model/instructor_model.dart';
import '../../commentsPage/commentPageForInstructor.dart';
import '../../resources/values_manager.dart';

class DetailsMonitorTablet extends StatefulWidget {
  DetailsMonitorTablet(
      {super.key,
      required this.instructorModel,
      required this.id,
      required this.numberUserRate});

  // final DocumentSnapshot documentSnapshot;

  final InstructorModel instructorModel;
  String id;
  dynamic numberUserRate;
  //String? rateUser;

  @override
  State<DetailsMonitorTablet> createState() => _DetailsMonitorTabletState();
}

class _DetailsMonitorTabletState extends State<DetailsMonitorTablet> {
  //TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> reviewKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List? userRate=["0"];
  // List? nameUserRate=["0"];

  @override
  void dispose() {
    //nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  clear() {
    //nameController.clear();
    commentController.clear();
  }

  @override
  void initState() {
    // FirebaseFirestore.instance.collection("all Instructor").doc(widget.id).
    // collection("RateOfUser").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
    //
    //   constantvar.rateUser = value.data()?["oldRate"] ?? 0  ;
    //   print(constantvar.rateUser);
    //
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetInstructorCubit, GetInstructorState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          //instructorModel.image!,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.instructorModel.image!,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .42,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.cloud_off_outlined),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.blue.shade400,
                                  highlightColor: Colors.blue.shade200,
                                  child: Container(
                                    height: 200,
                                    color: Colors.blue.shade300,
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
                                          style: TextStyle(
                                              color: Colors.yellowAccent),
                                        ),
                                        Text(
                                          widget.instructorModel.rate!,
                                          style: const TextStyle(
                                              color: Colors.yellowAccent),
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
                                          widget.instructorModel.numberUserRate
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.yellowAccent),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 5.h),

                        CardInfo(
                          name: widget.instructorModel.name!,
                          email: widget.instructorModel.email!,
                          jop: widget.instructorModel.jop!,
                          specialization:
                              widget.instructorModel.specialization!,
                          //experience: widget.instructorModel.experience!,
                          phone: widget.instructorModel.phone!,
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
                                borderRadius:
                                    BorderRadius.circular(AppSize.s15)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFf4f4f4),
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
                                          initialRating:
                                              constantvar.rateUser!.toDouble(),
                                          minRating: 0,
                                          glow: true,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          onRatingUpdate: (
                                            rating,
                                          ) async {
                                            print(
                                                "rate user is ${rating.toInt().toString()}");

                                            GetInstructorCubit.get(context)
                                                .addUserNumber();
                                            widget.instructorModel.rateUser!
                                                .add(FirebaseAuth
                                                    .instance.currentUser!.uid);

                                            FirebaseFirestore.instance
                                                .collection('all Instructor')
                                                .doc(widget.id)
                                                .update({
                                              "rateUser": widget
                                                  .instructorModel.rateUser
                                            });

                                            // for save old rate in innerCollection
                                            FirebaseFirestore.instance
                                                .collection("all Instructor")
                                                .doc(widget.id)
                                                .collection("RateOfUser")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .set({"oldRate": rating});

                                            // nameUserRate=[FirebaseAuth.instance.currentUser!.uid];
                                            // nameUserRate!.add(FirebaseAuth.instance.currentUser!.uid);
                                            // print("id is>>>> $nameUserRate");

                                            //userRate=[rating.toInt()];
                                            // userRate!.add(rating.toInt().toString());
                                            // print("User Rate is >>>> $userRate ");

                                            /*
                                        GetInstructorCubit.get(context).ratingCalculation(collectionName: 'all Instructor',
                                            documentId: widget.id,
                                            rating: rating,
                                            context: context
                                        );

                                         */

                                            widget.instructorModel.rateUser!
                                                    .contains(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid)
                                                ? GetInstructorCubit.get(
                                                        context)
                                                    .editRateCalculation(
                                                        collectionName:
                                                            'all Instructor',
                                                        documentId: widget.id,
                                                        oldRate: constantvar
                                                            .rateUser!,
                                                        rating: rating,
                                                        context: context)
                                                : GetInstructorCubit.get(
                                                        context)
                                                    .ratingCalculation(
                                                        collectionName:
                                                            'all Instructor',
                                                        documentId: widget.id,
                                                        rating: rating,
                                                        context: context);

                                            setState(() {
                                              GetInstructorCubit.get(context)
                                                  .geInstructor();
                                            });

                                            // toast Rate

                                            var snackBar = SnackBar(
                                              content: Text(
                                                "Your Rate is Done",
                                                style:
                                                    TextStyle(fontSize: 15.sp),
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);

                                            print(
                                                'numberUserRate>>>>>${widget.numberUserRate}');

                                            await GetInstructorCubit.get(
                                                    context)
                                                .geInstructor;
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
                                                  backgroundColor:
                                                      Colors.white54,
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
                                                      if (reviewKey
                                                          .currentState!
                                                          .validate()) {
                                                        if (widget
                                                                .instructorModel
                                                                .nameUser!
                                                                .contains(
                                                                    '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}') ||
                                                            widget
                                                                .instructorModel
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
                                                                  'all Instructor')
                                                              .doc(widget
                                                                  .instructorModel
                                                                  .id)
                                                              .update({
                                                            'comment': FieldValue
                                                                .arrayUnion([
                                                              commentController
                                                                  .text
                                                            ]),
                                                            'nameUser':
                                                                FieldValue
                                                                    .arrayUnion([
                                                              //'${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName} ${Random().nextInt(10)}'
                                                              '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'
                                                            ]),

                                                            // 'rateUser': FieldValue
                                                            //     .arrayUnion([
                                                            //   '${rateUser
                                                            //       .toString()}.${Random().nextDouble()*4}'
                                                            // ]),
                                                          }).then((value) async {
                                                            clear();

                                                            await GetInstructorCubit
                                                                    .get(
                                                                        context)
                                                                .geInstructor();

                                                            var snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                "Your Comment is Done",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp),
                                                              ),
                                                            );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          });
                                                          await GetInstructorCubit
                                                                  .get(context)
                                                              .geInstructor();

                                                          print('ok');
                                                          print(
                                                              commentController
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w),
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
                                                    CommentPageForInstructor(
                                                      instructorModel: widget
                                                          .instructorModel,
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

                        ////////////////////////////////////////////

                        //space
                        SizedBox(height: 15.h),
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
                        widget.instructorModel.comment!.isEmpty
                            ? Center(
                                child: Padding(
                                padding: EdgeInsets.only(top: 15.h),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .94,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFf4f4f4),
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
                                                          widget.instructorModel
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
                                                      //"good",
                                                      widget.instructorModel
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

                        //////////////////////////////////////////////////////////

                        //////////////////////////////////////////////////////////

                        //space
                        SizedBox(
                          height: 15.h,
                        ),

                        //Spacer(),

                        /*

                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .05,
                          child: const Column(
                            children: [
                              Center(
                                  child: Text(
                                "ENGX ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                              Center(
                                  child: Text(
                                "Training Services ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        )

                         */
                      ]),
                ),
              ),
            ));
      },
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.name,
    required this.email,
    required this.jop,
    required this.specialization,
    //required this.experience,
    required this.phone,
  });

  final String name;

  final String email;
  final String phone;

  final String jop;

  final String specialization;

  //final String experience;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s15)),
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
              borderRadius: BorderRadius.circular(AppSize.s15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                iconData: FontAwesomeIcons.personBreastfeeding,
                data: jop,
              ),
              BuildCard(
                iconData: Icons.stars_sharp,
                data: specialization,
              ),
              // BuildCard(
              //   iconData: Icons.work_outline_outlined,
              //   data: experience,
              // ),
              BuildCard(
                iconData: Icons.phone,
                data: phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({super.key, required this.iconData, required this.data});

  final IconData iconData;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white54,
            child: Icon(
              iconData,
              color: Colors.black,
              size: 22,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            data,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
