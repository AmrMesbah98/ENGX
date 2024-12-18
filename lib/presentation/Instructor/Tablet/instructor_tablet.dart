import 'package:asec_application/Constant/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_instructor/get_instructor_cubit.dart';
import '../../../master.dart';
import '../../rate_widget/fiveRate.dart';
import '../../rate_widget/fourRate.dart';
import '../../rate_widget/oneRate.dart';
import '../../rate_widget/threeRate.dart';
import '../../rate_widget/twoRate.dart';
import '../../rate_widget/zeroRate.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../detailInstructorr.dart';



class AllInstructorTablet extends StatelessWidget {
  const AllInstructorTablet({super.key,});




  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: BlocBuilder<GetInstructorCubit, GetInstructorState>(
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
        )
    );
  }

//Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 15,);
}
