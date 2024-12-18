import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_information/user_information_cubit.dart';
import '../../../bloc/get_package/get_package_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../model/package_courses.dart';
import '../../commentsPage/commentPageForPackage.dart';
import '../../courses/outer/Widget_outer_courseDetails.dart';
import '../../rate_widget/fiveRate.dart';
import '../../rate_widget/fourRate.dart';
import '../../rate_widget/oneRate.dart';
import '../../rate_widget/threeRate.dart';
import '../../rate_widget/twoRate.dart';
import '../../rate_widget/zeroRate.dart';
import '../../resources/values_manager.dart';
import '../category_packdge.dart';

class DetailsPackageTablet extends StatefulWidget {
  DetailsPackageTablet(
      {super.key, required this.packageCourses, required this.id});

  final PackageCourses packageCourses;
  String? id;

  @override
  State<DetailsPackageTablet> createState() => _DetailsPackageTabletState();
}

class _DetailsPackageTabletState extends State<DetailsPackageTablet> {
  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> reviewKey = GlobalKey();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  clear() {
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    constantvar.packageCourses = widget.packageCourses.price!;
    constantvar.packageCoursesHalf = widget.packageCourses.halfPrice!;
    constantvar.paymentPrice = widget.packageCourses.price!;
    constantvar.halfPaymentPrice = widget.packageCourses.halfPrice!;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print(constantvar.packageCourses);
    return BlocConsumer<GetPackageCubit, GetPackageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image
                  CachedNetworkImage(
                    imageUrl: widget.packageCourses.images!,
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * .32,
                    width: MediaQuery.of(context).size.width * 1,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.cloud_off_outlined),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.blue.shade400,
                      highlightColor: Colors.blue.shade200,
                      child: const SizedBox(
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  BuildCoursesPage(
                    nameCourse: widget.packageCourses.nameCourse!,
                    brife: widget.packageCourses.description!,
                    nameInstructor: widget.packageCourses.nameInstructor!,
                    adv1: widget.packageCourses.moreDetails!,
                    adv2: widget.packageCourses.moreDetails!,
                    adv3: widget.packageCourses.price!,
                  ),
                  SizedBox(height: height * .01),
                  // label
                  Container(
                    height: MediaQuery.of(context).size.height * .04,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text(
                      "What you'll learn ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  // list of what will be you learn
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.packageCourses.learn!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.blue[800],
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    widget.packageCourses.learn![index],
                                  ),
                                )
                              ],
                            );
                          })),
                  SizedBox(height: height * .01),
                  // price
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Text(
                            "price :",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ${widget.packageCourses.price}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                  SizedBox(height: height * .005),
                  // Rate
                  SizedBox(height: height * .01),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).RateThis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        //for rate
                        constantvar.zeroRate
                                .contains(widget.packageCourses.rate)
                            ? zeroRateWidget()
                            :

                            ////////////////////////////////////////////////////////////////////////////

                            constantvar.oneRate
                                    .contains(widget.packageCourses.rate)
                                ? oneRateWidget()
                                :

                                ////////////////////////////////////////////////////////////////////////////

                                constantvar.twoRate
                                        .contains(widget.packageCourses.rate)
                                    ? twoRateWidget()
                                    :

                                    ////////////////////////////////////////////////////////////////////////////

                                    constantvar.threeRate.contains(
                                            widget.packageCourses.rate)
                                        ? threeRateWidget()
                                        :

                                        ////////////////////////////////////////////////////////////////////////////

                                        constantvar.fourRate.contains(
                                                widget.packageCourses.rate)
                                            ? fourRateWidget()
                                            :

                                            ////////////////////////////////////////////////////////////////////////////

                                            constantvar.fiveRate.contains(
                                                    widget.packageCourses.rate)
                                                ? fiveRateWidget()
                                                :

                                                ////////////////////////////////////////////////////////////////////////////

                                                zeroRateWidget(),

                        ////////////////////////////////////////////////////////////////////////////
                      ],
                    ),
                  ), // 0.05
                  const SizedBox(height: AppSize.s15),

                  //review rate and comment

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s15)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .94,
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
                            borderRadius: BorderRadius.circular(AppSize.s15)),
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
                                    radius: 15,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),

                                  //space
                                  SizedBox(width: 20.w),

                                  //rate
                                  RatingBar.builder(
                                    initialRating:
                                        constantvar.rateUserPackage!.toDouble(),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    itemSize: 20,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    onRatingUpdate: (rating) async {
                                      print(rating);

                                      print(
                                          "rate user is ${rating.toInt().toString()}");

                                      GetPackageCubit.get(context)
                                          .addUserNumber();
                                      widget.packageCourses.rateUser!.add(
                                          FirebaseAuth
                                              .instance.currentUser!.uid);

                                      FirebaseFirestore.instance
                                          .collection('package')
                                          .doc(widget.id)
                                          .update({
                                        "rateUser":
                                            widget.packageCourses.rateUser
                                      });

                                      // for save old rate in innerCollection
                                      FirebaseFirestore.instance
                                          .collection("package")
                                          .doc(widget.id)
                                          .collection("RateOfUser")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .set({"oldRate": rating});

                                      print(
                                          'numberUserRate>>>>>${widget.packageCourses.numberUserRate}');

                                      widget.packageCourses.rateUser!.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? GetPackageCubit.get(context)
                                              .editRateCalculation(
                                                  collectionName: "package",
                                                  documentId: widget.id!,
                                                  rating: rating,
                                                  oldRate: constantvar
                                                      .rateUserPackage!,
                                                  context: context)
                                          : GetPackageCubit.get(context)
                                              .ratingCalculation(
                                                  collectionName: 'package',
                                                  documentId: widget.id!,
                                                  rating: rating,
                                                  context: context);

                                      // FirebaseFirestore.instance.collection('package').doc(widget.id).update(
                                      //     {
                                      //       'numberUserRate':widget.packageCourses.numberUserRate +1
                                      //     });

                                      var snackBar = SnackBar(
                                        content: Text(
                                          "Your Rate is Done",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);

                                      setState(() {
                                        GetPackageCubit.get(context)
                                            .getPackdgeFunction();
                                      });

                                      await GetPackageCubit.get(context)
                                          .getPackdgeFunction();
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
                                            radius: 15,
                                            child: Icon(
                                              Icons.comment_outlined,
                                              color: Colors.black,
                                              size: 15,
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
                                                controller: commentController,
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
                                                  if (widget.packageCourses
                                                          .nameUser!
                                                          .contains(
                                                              '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}') ||
                                                      widget.packageCourses
                                                          .comment!
                                                          .contains(
                                                              commentController
                                                                  .text)) {
                                                    Navigator.of(context).pop();
                                                    clear();
                                                  } else {
                                                    FirebaseFirestore.instance
                                                        .collection('package')
                                                        .doc(widget
                                                            .packageCourses.id)
                                                        .update({
                                                      'comment': FieldValue
                                                          .arrayUnion([
                                                        commentController.text
                                                      ]),
                                                      'nameUser': FieldValue
                                                          .arrayUnion([
                                                        //'${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName} ${Random().nextInt(10)}'
                                                        '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'
                                                      ]),
                                                    }).then((value) async {
                                                      clear();

                                                      await GetPackageCubit.get(
                                                              context)
                                                          .getPackdgeFunction();

                                                      var snackBar = SnackBar(
                                                        content: Text(
                                                          "Your Comment is Done",
                                                          style: TextStyle(
                                                              fontSize: 15.sp),
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    });
                                                    await GetPackageCubit.get(
                                                            context)
                                                        .getPackdgeFunction();

                                                    print('ok');
                                                    print(
                                                        commentController.text);
                                                  }
                                                }
                                              },
                                              child: Text(
                                                S.of(context).Send,
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontWeight: FontWeight.bold,
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
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                                //padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //for show rate and comments

                                    GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              CommentPageForPackage(
                                                packageCourseModel:
                                                    widget.packageCourses,
                                                id: widget.id!,
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            //see more
                                            Text(
                                              S.of(context).SeeMore,
                                              style: TextStyle(
                                                  fontSize: 9.sp,
                                                  fontWeight: FontWeight.bold),
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
                                height: 5.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                  // button payment
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, const CategoryPricePackdge());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .05,
                          decoration: BoxDecoration(color: Colors.grey[400]),
                          child: const Center(
                              child: Text(
                            "Payment",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ),
                  ), // 0.07
                  SizedBox(height: 42.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//////////////////////////////////////////////

//FOR TABLET

/*
class DetailsPackageTablet extends StatefulWidget {
  DetailsPackageTablet({super.key, required this.packageCourses,required this.id});

  final PackageCourses packageCourses;
  String? id;

  @override
  _DetailsPackageTabletState createState() => _DetailsPackageTabletState();
}

class _DetailsPackageTabletState extends State<DetailsPackageTablet> {

  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> reviewKey = GlobalKey();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  clear(){
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    constantvar.packageCourses = widget.packageCourses.price!;
    constantvar.packageCoursesHalf = widget.packageCourses.halfPrice!;
    constantvar.paymentPrice = widget.packageCourses.price!;
    constantvar.halfPaymentPrice = widget.packageCourses.halfPrice!;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print(constantvar.packageCourses);
    return BlocConsumer<GetPackageCubit, GetPackageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
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
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black54),
            title: Text(
              S.of(context).packageCourses,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          body: Container(
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image
                  CachedNetworkImage(
                    imageUrl: widget.packageCourses.images!,
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * .32,
                    width: MediaQuery.of(context).size.width * 1,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.cloud_off_outlined),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.blue.shade400,
                      highlightColor: Colors.blue.shade200,
                      child: const SizedBox(
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: height*.01),
                  BuildCoursesPage(
                    nameCourse: widget.packageCourses.nameCourse!,
                    brife: widget.packageCourses.description!,
                    nameInstructor: widget.packageCourses.nameInstructor!,
                    adv1: widget.packageCourses.moreDetails!,
                    adv2: widget.packageCourses.moreDetails!,
                    adv3: widget.packageCourses.price!,
                  ),
                  SizedBox(height: height*.01),
                  // label
                  Container(
                    height: MediaQuery.of(context).size.height * .04,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text(
                      "What you'll learn ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: height*.01),
                  // list of what will be you learn
                  Container(
                      width: MediaQuery.of(context).size.width,

                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.packageCourses.learn!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.blue[800],
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    widget.packageCourses.learn![index],
                                  ),
                                )
                              ],
                            );
                          }
                      )
                  ),
                  SizedBox(height: height*.01),
                  // price
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Text(
                            "price :",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ${widget.packageCourses.price}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                  SizedBox(height: height*.005),
                  // Rate
                  SizedBox(height: height*.01),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).RateThis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        //for rate
                        constantvar.zeroRate.contains(widget.packageCourses.rate)?
                        zeroRateWidget():

                        ////////////////////////////////////////////////////////////////////////////

                        constantvar.oneRate.contains(widget.packageCourses.rate)?
                        oneRateWidget():

                        ////////////////////////////////////////////////////////////////////////////

                        constantvar.twoRate.contains(widget.packageCourses.rate)?
                        twoRateWidget():

                        ////////////////////////////////////////////////////////////////////////////

                        constantvar.threeRate.contains(widget.packageCourses.rate)?
                        threeRateWidget():

                        ////////////////////////////////////////////////////////////////////////////

                        constantvar.fourRate.contains(widget.packageCourses.rate)?
                        fourRateWidget():

                        ////////////////////////////////////////////////////////////////////////////

                        constantvar.fiveRate.contains(widget.packageCourses.rate)?
                        fiveRateWidget():

                        ////////////////////////////////////////////////////////////////////////////

                        zeroRateWidget(),

                        ////////////////////////////////////////////////////////////////////////////


                      ],
                    ),
                  ), // 0.05
                  const SizedBox(height: AppSize.s15),

                  //review rate and comment

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s15)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .94,
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
                            borderRadius: BorderRadius.circular(AppSize.s15)),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              //for rate
                              Row(
                                children: [

                                  //icon
                                  const CircleAvatar(
                                    backgroundColor: Colors.white54,
                                    radius: 15,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),

                                  //space
                                  SizedBox(width: 20.w),

                                  //rate
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    itemSize: 20,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    onRatingUpdate: (rating) async {
                                      print(rating);


                                      print('numberUserRate>>>>>${widget.packageCourses.numberUserRate}');

                                      GetPackageCubit.get(context)
                                          .ratingCalculation(
                                          collectionName: 'package',
                                          documentId: widget.id!,
                                          rating: rating,
                                          context: context);

                                      FirebaseFirestore.instance.collection('package').doc(widget.id).update(
                                          {
                                            'numberUserRate':widget.packageCourses.numberUserRate +1
                                          });


                                      Fluttertoast.showToast(
                                          msg: "Your Rate is Done",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                          fontSize: 15.sp
                                      );


                                      setState(()  {
                                        GetPackageCubit.get(context).getPackdgeFunction();
                                      });

                                      await GetPackageCubit.get(context).getPackdgeFunction();
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
                                            radius: 15,
                                            child: Icon(
                                              Icons.comment_outlined,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),

                                          //space
                                          SizedBox(width: 20.w),

                                          //comment field
                                          SizedBox(
                                            width: 140.w,
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: S
                                                        .of(context)
                                                        .EnterYourComment,
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.sp)),
                                                controller: commentController,
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
                                                  if(widget.packageCourses.nameUser!.contains('${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}')
                                                      || widget.packageCourses.comment!.contains(commentController.text) )
                                                  {
                                                    Navigator.of(context)
                                                        .pop();
                                                    clear();
                                                  }
                                                  else{
                                                    FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        'package')
                                                        .doc(widget
                                                        .packageCourses
                                                        .id)
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

                                                      await GetPackageCubit
                                                          .get(context)
                                                          .getPackdgeFunction();


                                                      Fluttertoast.showToast(
                                                          msg: "Your Comment is Done",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: Colors.grey,
                                                          textColor: Colors.white,
                                                          fontSize: 15.sp
                                                      );



                                                    });
                                                    await GetPackageCubit
                                                        .get(context)
                                                        .getPackdgeFunction();

                                                    print('ok');
                                                    print(commentController
                                                        .text);
                                                  }
                                                }
                                              },
                                              child: Text(
                                                S.of(context).Send,style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold,color: Colors.black),)),

                                        ],
                                      ),
                                    ],
                                  )),

                              //space
                              SizedBox(height: 15.h,),

                              //for button see more
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 60.w),
                                //padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //for show rate and comments


                                    GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              CommentPageForPackage(
                                                packageCourseModel:
                                                widget.packageCourses,
                                                id: widget.id!,
                                              ));
                                        },
                                        child: Row(

                                          children: [
                                            //see more
                                            Text(
                                              S.of(context).SeeMore,
                                              style: TextStyle(
                                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
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
                              SizedBox(height: 5.h,)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSize.s15),
                  // button payment
                  GestureDetector(
                    onTap: (){
                      navigateTo(context, const CategoryPricePackdge());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .05,
                          decoration:  BoxDecoration(
                              color: Colors.grey[400]
                          ),
                          child: const Center(
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                    ),
                  ), // 0.07
                  const SizedBox(height: AppSize.s20),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

 */
