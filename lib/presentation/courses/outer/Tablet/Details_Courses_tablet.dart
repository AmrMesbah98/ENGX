import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/get_courses/courses_cubit.dart';
import 'package:asec_application/presentation/commentsPage/commentPageForCourses.dart';
import 'package:asec_application/presentation/courses/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../ADS/ads.dart';
import '../../../../bloc/get_information/user_information_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/courses_model.dart';
import '../../../../shared/components/components.dart';
import '../../../rate_widget/fiveRate.dart';
import '../../../rate_widget/fourRate.dart';
import '../../../rate_widget/oneRate.dart';
import '../../../rate_widget/threeRate.dart';
import '../../../rate_widget/twoRate.dart';
import '../../../rate_widget/zeroRate.dart';
import '../../../resources/values_manager.dart';
import '../../price/category_price.dart';
import '../Widget_outer_courseDetails.dart';

class DetailsCoursesTablet extends StatefulWidget {
  DetailsCoursesTablet(
      {super.key,
      required this.coursesModel,
      required this.id,
      required this.rate});

  final CoursesModel coursesModel;
  String? id;
  String? rate;

  @override
  State<DetailsCoursesTablet> createState() => _DetailsCoursesTabletState();
}

class _DetailsCoursesTabletState extends State<DetailsCoursesTablet> {
  bool isExpanded = true;
  bool isExpanded2 = true;

  BannerAd? bannerAd;

  bool isLoaded = false;

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

  void load() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AddManger.bannerTwo,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  @override
  void initState() {
    load();
    super.initState();
    print('id>>>> ${widget.id}');
    print('rate>>>> ${widget.rate}');
  }

  @override
  Widget build(BuildContext context) {
    constantvar.paymentPrice = widget.coursesModel.price!;
    constantvar.halfPaymentPrice = widget.coursesModel.priceHalf!;
    return Scaffold(
      body: Container(
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
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
                width: double.infinity,

                //coursesModel.link!
                //Youtube(path: coursesModel.link!)
                child: VideoPlay(
                  url: widget.coursesModel.link!,
                )), // .26
            BuildCoursesPageTablet(
              nameCourse: widget.coursesModel.nameCourse!,
              brife: widget.coursesModel.description!,
              nameInstructor: widget.coursesModel.nameInstructor!,
              adv1: widget.coursesModel.moreDetails!,
              adv2: widget.coursesModel.moreDetails!,
              adv3: widget.coursesModel.price!,
            ),

            // what your will learn
            //========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: AnimatedContainer(
                  margin: EdgeInsets.symmetric(
                    horizontal: isExpanded ? 10 : 0,
                    vertical: 10,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //height: isExpanded ? 50 : 420,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1200),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(isExpanded ? 20 : 20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "What will be Learn",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.black54,
                            size: 27,
                          ),
                        ],
                      ),
                      isExpanded ? SizedBox() : SizedBox(height: 20),
                      AnimatedCrossFade(
                        firstChild: const Text(
                          '',
                          style: TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        secondChild: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.coursesModel.learn!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // ignore: prefer_const_constructors
                                      Icon(Icons.star),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          widget.coursesModel.learn![index],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: Duration(milliseconds: 1200),
                        reverseDuration: Duration.zero,
                        sizeCurve: Curves.fastLinearToSlowEaseIn,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //========================================

            SizedBox(height: MediaQuery.of(context).size.height * .01),

            //price
            Container(
                height: MediaQuery.of(context).size.height * .03,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      "Price :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " ${widget.coursesModel.price}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                )),

            //========================================

            SizedBox(height: MediaQuery.of(context).size.height * .01),

            //rate
            Container(
              height: MediaQuery.of(context).size.height * .05,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        S.of(context).RateThis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      // old rate
                      /*
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),

                     */

                      //new rate

                      //for rate
                      constantvar.zeroRate.contains(widget.rate)
                          ? zeroRateWidget()
                          :

                          ////////////////////////////////////////////////////////////////////////////

                          constantvar.oneRate.contains(widget.rate)
                              ? oneRateWidget()
                              :

                              ////////////////////////////////////////////////////////////////////////////

                              constantvar.twoRate.contains(widget.rate)
                                  ? twoRateWidget()
                                  :

                                  ////////////////////////////////////////////////////////////////////////////

                                  constantvar.threeRate.contains(widget.rate)
                                      ? threeRateWidget()
                                      :

                                      ////////////////////////////////////////////////////////////////////////////

                                      constantvar.fourRate.contains(widget.rate)
                                          ? fourRateWidget()
                                          :

                                          ////////////////////////////////////////////////////////////////////////////

                                          constantvar.fiveRate
                                                  .contains(widget.rate)
                                              ? fiveRateWidget()
                                              :

                                              ////////////////////////////////////////////////////////////////////////////

                                              zeroRateWidget(),

                      ////////////////////////////////////////////////////////////////////////////
                    ],
                  );
                },
              ),
            ), // 0.05

            //========================================

            SizedBox(height: MediaQuery.of(context).size.height * .001),

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                                  constantvar.rateUserCourses!.toDouble(),
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

                                GetCoursesCubit.get(context).addUserNumber();
                                widget.coursesModel.rateUser!.add(
                                    FirebaseAuth.instance.currentUser!.uid);

                                FirebaseFirestore.instance
                                    .collection('all courses')
                                    .doc(widget.id)
                                    .update({
                                  "rateUser": widget.coursesModel.rateUser
                                });

                                // for save old rate in innerCollection
                                FirebaseFirestore.instance
                                    .collection("all courses")
                                    .doc(widget.id)
                                    .collection("RateOfUser")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({"oldRate": rating});

                                // widget.coursesModel.rateUser!.contains(FirebaseAuth.instance.currentUser!.uid)?
                                // FirebaseFirestore.instance.collection('all courses').doc(widget.id).update(
                                //     {
                                //       'numberUserRate':widget.coursesModel.numberUserRate +0
                                //     }):
                                // FirebaseFirestore.instance.collection('all courses').doc(widget.id).update(
                                //     {
                                //       'numberUserRate':widget.coursesModel.numberUserRate +1
                                //     });

                                widget.coursesModel.rateUser!.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? GetCoursesCubit.get(context)
                                        .editRateCalculation(
                                            collectionName: 'all courses',
                                            documentId: widget.id!,
                                            oldRate:
                                                constantvar.rateUserCourses!,
                                            rating: rating,
                                            context: context)
                                    : GetCoursesCubit.get(context)
                                        .ratingCalculation(
                                            collectionName: 'all courses',
                                            documentId: widget.id!,
                                            rating: rating,
                                            context: context);

                                FirebaseFirestore.instance
                                    .collection('all courses')
                                    .doc(widget.id)
                                    .update({
                                  'numberUserRate':
                                      widget.coursesModel.numberUserRate + 1
                                });

                                print(
                                    'numberUserRate>>>>>${widget.coursesModel.numberUserRate}');

                                // GetCoursesCubit.get(context)
                                //     .ratingCalculation(
                                //     collectionName: 'all courses',
                                //     documentId: widget.id!,
                                //     rating: rating,
                                //     context: context);

                                var snackBar = SnackBar(
                                  content: Text(
                                    "Your Rate is Done",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                setState(() {
                                  GetCoursesCubit.get(context).getCourses();
                                });

                                await GetCoursesCubit.get(context).getCourses();
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
                                              hintStyle:
                                                  TextStyle(fontSize: 8.sp)),
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
                                            if (widget.coursesModel.nameUser!
                                                    .contains(
                                                        '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}') ||
                                                widget.coursesModel.comment!
                                                    .contains(commentController
                                                        .text)) {
                                              Navigator.of(context).pop();
                                              clear();
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection('all courses')
                                                  .doc(widget.coursesModel.id)
                                                  .update({
                                                'comment':
                                                    FieldValue.arrayUnion([
                                                  commentController.text
                                                ]),
                                                'nameUser':
                                                    FieldValue.arrayUnion([
                                                  //'${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName} ${Random().nextInt(10)}'
                                                  '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'
                                                ]),
                                              }).then((value) async {
                                                clear();

                                                await GetCoursesCubit.get(
                                                        context)
                                                    .getCourses();

                                                var snackBar = SnackBar(
                                                  content: Text(
                                                    "Your Rate is Done",
                                                    style: TextStyle(
                                                        fontSize: 15.sp),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                              await GetCoursesCubit.get(context)
                                                  .getCourses();

                                              print('ok');
                                              print(commentController.text);
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
                                        CommentPageForCourses(
                                          coursesModel: widget.coursesModel,
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

            //========================================

            const SizedBox(height: AppSize.s15),

            Center(
                child: isLoaded
                    ? SizedBox(
                        width: bannerAd!.size.width.toDouble(),
                        height: bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: bannerAd!),
                      )
                    : SizedBox()),

            SizedBox(height: MediaQuery.of(context).size.height * .03),

            Container(
              height: MediaQuery.of(context).size.height * .05,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const CategoryPrice();
                    }));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width * .1,
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
                    child: const Center(
                        child: Text(
                      "Payment",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .01),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      required this.colorButton,
      required this.sizeLabel,
      required this.fontWight,
      required this.colorButtonText,
      required this.onTapFunction,
      required this.wid,
      required this.hei});

  final String label;
  final Color colorButton;
  final Color colorButtonText;
  final double sizeLabel;
  final double wid;
  final double hei;
  final FontWeight fontWight;
  final Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: wid,
        height: hei,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: colorButton),
        child: Center(
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: colorButtonText,
                  fontSize: sizeLabel,
                  fontWeight: fontWight),
            ),
          ),
        ),
      ),
    );
  }
}
