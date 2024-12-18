import 'package:asec_application/Constant/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../generated/l10n.dart';
import '../../master.dart';
import '../../model/instructor_model.dart';
import '../rate_widget/fiveRate.dart';
import '../rate_widget/fourRate.dart';
import '../rate_widget/oneRate.dart';
import '../rate_widget/threeRate.dart';
import '../rate_widget/twoRate.dart';
import '../rate_widget/zeroRate.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'Tablet/instructor_tablet.dart';
import 'detailInstructorr.dart';

class AllInstructor extends StatelessWidget {
   const AllInstructor({super.key,});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient:  LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),

                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return const Master();
            }));
          },
          color: ColorManager.Black,
        ),
        title:  const Text(
          "Technical Support",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black54),
        ),
      ),
      body: LayoutBuilder(
          builder: (context, constrain){
            if (constrain.maxWidth < 600){
              return BlocBuilder<GetInstructorCubit, GetInstructorState>(
                builder: (context, state) {
                  if (state is GetInstructorFailure) {
                    return Text(state.errMessage);
                  }
                  else if(state is GetInstructorSuccess)
                  {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient:    LinearGradient(
                            colors: [
                              Color(0xFFFFFFFF),

                              Color(0xFFFFFFFF),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                childAspectRatio: 3 / 2.8,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 10
                            ),
                            itemCount: state.instructor.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: (){

                                  FirebaseFirestore.instance.collection("all Instructor").doc(state.instructor[index].id!,).
                                  collection("RateOfUser").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
                                    print("my rate is one two ${constantvar.rateUser}");
                                    constantvar.rateUser = value.data()?["oldRate"]  ?? 0  ;
                                    print("my rate is ${constantvar.rateUser}");

                                  }).then((value) {

                                    Navigator.push(ctx, MaterialPageRoute(builder: (_){
                                      return DetailsMonitor(
                                        instructorModel: constantvar.instructorModel=state.instructor[index],
                                        id: constantvar.instructorModel!.id!,
                                        numberUserRate: constantvar.instructorModel!.numberUserRate!,
                                      );
                                    }));

                                  });



                                },
                                child: Card(
                                  shadowColor: Colors.white, //ToDO
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppSize.s20),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient:   const LinearGradient(
                                            colors: [
                                              Color(0xFFe5e5e5),

                                              Color(0xFFFFFFFF),
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Stack(
                                        alignment: Alignment.bottomLeft,
                                      children: [
                                        ClipRRect(
                                          borderRadius:  const BorderRadius.only(
                                            topRight: Radius.circular(20) ,
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: state.instructor[index].image!,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                            height: 177.h,
                                            width: AppSize.s200,
                                            errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                                            placeholder: (context, url) => Shimmer.fromColors(

                                              baseColor: Colors.grey.shade400,
                                              highlightColor: Colors.grey.shade200,

                                              child: const SizedBox(
                                                width: 200,
                                                height: 200,
                                              ),
                                            ),
                                          ),

                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 2 ),
                                            child: Container(
                                              decoration: const BoxDecoration(

                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  //for name instructor
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.black45
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.only(left: 2.w),
                                                      child: Text(
                                                        state.instructor[index].name!,
                                                        //  DummyAllCourses[index].nameCourse,
                                                        style:  TextStyle(
                                                            fontSize: 10.sp, fontWeight: FontWeight.w900,color: Colors.white),
                                                      ),
                                                    ),
                                                  ),



                                                  //row for position and rate
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black38,
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.only(right: 7.w,bottom: 4.h,left: 2.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          //for position
                                                          Text(state.instructor[index].specialization!,style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w600,color: Colors.white),),

                                                          const Spacer(),

                                                          //for rate
                                                          constantvar.zeroRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                          zeroRateWidget():

                                                          ////////////////////////////////////////////////////////////////////////////

                                                          constantvar.oneRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                          oneRateWidget():

                                                          ////////////////////////////////////////////////////////////////////////////

                                                          constantvar.twoRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                          twoRateWidget():

                                                          ////////////////////////////////////////////////////////////////////////////

                                                          constantvar.threeRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                          threeRateWidget():

                                                          ////////////////////////////////////////////////////////////////////////////

                                                          constantvar.fourRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                          fourRateWidget():

                                                          ////////////////////////////////////////////////////////////////////////////

                                                          constantvar.fiveRate.contains(GetInstructorCubit.get(context).userModelList[index].rate )?
                                                          fiveRateWidget():

                                                          ////////////////////////////////////////////////////////////////////////////

                                                          zeroRateWidget()

                                                          ////////////////////////////////////////////////////////////////////////////

                                                        ],
                                                      ),
                                                    ),
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
                              );
                            }),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              );
            }
            else if (constrain.maxWidth < 900) {
              return BlocBuilder<GetInstructorCubit, GetInstructorState>(
                builder: (context, state) {
                  if (state is GetInstructorFailure) {
                    return Text(state.errMessage);
                  }
                  else if(state is GetInstructorSuccess)
                  {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient:    LinearGradient(
                            colors: [
                              Color(0xFFFFFFFF),

                              Color(0xFFFFFFFF),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 3 / 3.3,
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: state.instructor.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: (){

                                  FirebaseFirestore.instance.collection("all Instructor").doc(state.instructor[index].id!,).
                                  collection("RateOfUser").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
                                    print("my rate is one two ${constantvar.rateUser}");
                                    constantvar.rateUser = value.data()?["oldRate"]  ?? 0  ;
                                    print("my rate is ${constantvar.rateUser}");

                                  }).then((value) {

                                    Navigator.push(ctx, MaterialPageRoute(builder: (_){
                                      return DetailsMonitor(
                                        instructorModel: constantvar.instructorModel= state.instructor[index],
                                        id: constantvar.instructorModel!.id!,
                                        numberUserRate: constantvar.instructorModel!.numberUserRate!,
                                      );
                                    }));

                                  });



                                },
                                child: Card(
                                  shadowColor: Colors.white, //ToDO
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppSize.s20),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient:   const LinearGradient(
                                            colors: [
                                              Color(0xFFe5e5e5),

                                              Color(0xFFFFFFFF),
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:  const BorderRadius.only(
                                            topRight: Radius.circular(20) ,
                                            topLeft: Radius.circular(20),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: state.instructor[index].image!,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                            height: 155,
                                            width: 210,
                                            errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                                            placeholder: (context, url) => Shimmer.fromColors(

                                              baseColor: Colors.grey.shade400,
                                              highlightColor: Colors.grey.shade200,

                                              child: const SizedBox(
                                                width: 200,
                                                height: 200,
                                              ),
                                            ),
                                          ),

                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height*.009),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //for name instructor
                                              Text(
                                                state.instructor[index].name!,
                                                //  DummyAllCourses[index].nameCourse,
                                                style:  TextStyle(
                                                    fontSize: 9.sp, fontWeight: FontWeight.w900),
                                              ),

                                              //space
                                              SizedBox(height: 5.h,),

                                              //row for position and rate
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  //for position
                                                  Text(state.instructor[index].specialization!,style: TextStyle(fontSize: 8.sp,fontWeight: FontWeight.w600),),

                                                  const Spacer(),

                                                  //for rate
                                                  constantvar.zeroRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                  zeroRateWidget():

                                                  ////////////////////////////////////////////////////////////////////////////

                                                  constantvar.oneRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                  oneRateWidget():

                                                  ////////////////////////////////////////////////////////////////////////////

                                                  constantvar.twoRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                  twoRateWidget():

                                                  ////////////////////////////////////////////////////////////////////////////

                                                  constantvar.threeRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                  threeRateWidget():

                                                  ////////////////////////////////////////////////////////////////////////////

                                                  constantvar.fourRate.contains(GetInstructorCubit.get(context).userModelList[index].rate)?
                                                  fourRateWidget():

                                                  ////////////////////////////////////////////////////////////////////////////

                                                  constantvar.fiveRate.contains(GetInstructorCubit.get(context).userModelList[index].rate )?
                                                  fiveRateWidget():

                                                  ////////////////////////////////////////////////////////////////////////////

                                                  zeroRateWidget()

                                                  ////////////////////////////////////////////////////////////////////////////

                                                ],
                                              ),

                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              );
            }

            else {
              return const Center(child: Text("Desktop"));
            }
          }
      )
    );
  }

  //Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 15,);
}
