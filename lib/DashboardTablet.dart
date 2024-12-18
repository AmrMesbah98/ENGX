
import 'package:asec_application/bloc/get_topFive/top_five_cubit.dart';
import 'package:asec_application/presentation/DashBoard/App_User/Application_User.dart';
import 'package:asec_application/presentation/Posts/reviewPost.dart';
import 'package:asec_application/presentation/Work/presentation/view/create_job_form.dart';
import 'package:asec_application/presentation/dashdoard/make_news.dart';
import 'package:asec_application/presentation/dashdoard/certification_control.dart';
import 'package:asec_application/presentation/dashdoard/chossesControl.dart';
import 'package:asec_application/presentation/dashdoard/order.dart';
import 'package:asec_application/presentation/dashdoard/quiz_control.dart';
import 'package:asec_application/presentation/dashdoard/support.dart';
import 'package:asec_application/presentation/dashdoard/topFive_control.dart';
import 'package:asec_application/presentation/homepage/homepage.dart';
import 'package:asec_application/presentation/resources/color_manager.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:asec_application/zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'generated/l10n.dart';

class DashBoradTablet extends StatefulWidget {
  @override
  State<DashBoradTablet> createState() => _DashBoradTabletState();
}

class _DashBoradTabletState extends State<DashBoradTablet> {
  late FirebaseAuth _mAuth;
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: [

            // Notification
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return  const AppUser();
                }));
              },
              title: "Notification",
              subTitle: "You Can Send Notification Now",
              iCons: const Icon(Icons.notifications_active_rounded,size: 50,color: Colors.black38,),
              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),

            ),

            // Order
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return  const OrderPage();
                }));
              },
              title: "Order",
              subTitle: "Order for Project ",
              iCons: const Icon(Icons.low_priority,size: 50,color: Colors.black38,),
              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),


            // Support
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return  const SupportPage();
                }));
              },
              title: "Support",
              subTitle: "Support for Make Discount in Courses ",
              iCons:const Icon(Icons.volunteer_activism,size: 50,color: Colors.black38,),

              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),

            // Review post
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return  const ReviewPost();
                }));
              },
              title: "Review Post",
              subTitle: "Review Post for Agree Posts ",
              iCons:const Icon(Icons.post_add,size: 50,color: Colors.black38,),

              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),

            // Certificate
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return  const CertificateControl();
                }));
              },
              title: "Certification",
              subTitle: "Accept or Refuse Certification ",
              iCons:const Icon(Icons.description,size: 50,color: Colors.black38,),

              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),


            // Create Job
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return    CreateJobForm();
                }));
              },
              title: "Create Job",
              subTitle: "Create New Job",
              iCons:const Icon(Icons.work_outline,size: 50,color: Colors.black38,),



              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),

            // News
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return   const NewChooseControl();
                }));
              },
              title: "News",
              subTitle: "Edit and Delete News in HomePage",
              iCons:const Icon(Icons.newspaper,size: 50,color: Colors.black38,),


              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),


            // Top Five Rate
            /*
          buildUiDashBoard(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return    TopFiveControlPage(topFiveModel: GetTopFiveCubit.get(context).TopFiveList,);
                }));
              },
              title: "Rate Top Five",
              subTitle: "Make Edit in The Skills in Top Five",
              iCons:const Icon(Icons.groups,size: 60,color: Colors.black38,),



            colorTwo : Colors.white,
            colorOne: const Color(0xffEADDCA),
          ),


           */

            // Quiz
            buildUiDashBoardTablet(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return    QuizControl(quizDegreeModel: ZoomMeetingCubit.get(context).quizDegreeList,);
                }));
              },
              title: "Quiz",
              subTitle: "Degree of Quiz of Student",
              iCons:const Icon(Icons.quiz,size: 50,color: Colors.black38,),



              colorTwo : Colors.white,
              colorOne: const Color(0xffEADDCA),
            ),


            const Expanded(child: Image(image: AssetImage("assets/images/map.png"),))







          ],
        )
    );
  }



  /*
  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(


          child: SingleChildScrollView(
            child: Column(
              children: [
                // Notification
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return  const AppUser();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Colors.white60
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: double.infinity,
                          height: 100.h,
                          child:  Column(
                            children: [
                              SizedBox(height: 5.h),
                              Text("Notification",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5.h),
                              const Icon(Icons.notifications_active_rounded,size: 60,color: Colors.grey,),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
                // order
                /*
                        Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return  const OrderPage();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFe5e5e5),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              width: double.infinity,
                              height: 80,
                              child: const Center(child: Text("Order",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)),
                            ),
                          ),
                        ),
                      ),
                       */
                // support
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return  const SupportPage();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Colors.white60
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: double.infinity,
                          height: 100.h,
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              Text("Support",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5.h),
                              const Icon(Icons.volunteer_activism,size: 60,color: Colors.grey,),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
                // certification
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return  const CertificateControl();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Colors.white60
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: double.infinity,
                          height: 100.h,
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              Text("certification",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5.h),
                              const Icon(Icons.description,size: 60,color: Colors.grey,),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
                // News
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return   const NewChooseControl();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Colors.white60
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: double.infinity,
                          height: 100.h,
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              Text("News",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5.h),
                              const Icon(Icons.newspaper,size: 60,color: Colors.grey,),
                            ],
                          )
                      ),
                    ),
                  ),
                ),

                // Rate Top Five
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return    TopFiveControlPage(topFiveModel: GetTopFiveCubit.get(context).TopFiveList,);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Colors.white60
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: double.infinity,
                          height: 100.h,
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              Text("Rate",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5.h),
                              Icon(Icons.groups,size: 60,color: Colors.grey,),
                            ],
                          )
                      ),
                    ),
                  ),
                ),


                //  Quiz
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return    QuizControl(quizDegreeModel: ZoomMeetingCubit.get(context).quizDegreeList,);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFe5e5e5),
                                  Colors.white60
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: double.infinity,
                          height: 100.h,
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              Text("Quiz",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5.h),
                              Icon(Icons.quiz,size: 60,color: Colors.grey,),
                            ],
                          )
                      ),
                    ),
                  ),
                ),


                // old quiz
                /*
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return    QuizControl();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFe5e5e5),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              width: double.infinity,
                              height: 80,
                              child: const Center(child: Text("Quiz",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)),
                            ),
                          ),
                        ),
                      ),

                        */
              ],
            ),
          )
        ),
      ),
   */




  buildUiDashBoard({required Function() onTap,required String title , required String subTitle, required Icon iCons, Color colorOne = Colors.white,  Color colorTwo = Colors.white})
  {
    return Container(
      decoration: BoxDecoration(

        gradient:  LinearGradient(
            colors: [colorOne, colorTwo],

            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.9, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),


      ),
      child: ListTile(
        style: ListTileStyle.list,
        onTap: onTap,
        title: Text(title,style: TextStyle(fontSize: 16.sp),),
        subtitle: Text(subTitle,style: TextStyle(fontSize: 12.sp),),
        trailing: iCons,
      ),
    );
  }

  buildUiDashBoardTablet({required Function() onTap,required String title , required String subTitle, required Icon iCons, Color colorOne = Colors.white,  Color colorTwo = Colors.white})
  {
    return Container(
      decoration: BoxDecoration(

      gradient:  LinearGradient(
            colors: [colorOne, colorTwo],

            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.9, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),


      ),
      child: ListTile(
        style: ListTileStyle.list,
        onTap: onTap,
        title: Text(title,style: TextStyle(fontSize: 13.sp),),
        subtitle: Text(subTitle,style: TextStyle(fontSize: 9.sp),),
        trailing: iCons,
      ),
    );
  }

  buildcard(String name, String email, String phone, String reason,
      String type, String uid) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.black12,
              Colors.red,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name : $name ",
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              "Email : $email ",
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              "Phone : $phone ",
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              "reason : $reason ",
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              "Address : $type",
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              "Uid : $uid",
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}







// DataUser();