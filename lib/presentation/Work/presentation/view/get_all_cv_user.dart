import 'package:asec_application/presentation/Work/presentation/view/showAllCvForJob.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/ineer_response_model.dart';
import '../manager/get_work_cubit.dart';

class GetAllCvUser extends StatefulWidget {
   GetAllCvUser({super.key,required this.innerResponseModel,required this.id});

  List<InnerResponseModel>?  innerResponseModel;
  String? id;


  @override
  State<GetAllCvUser> createState() => _GetAllCvUserState();
}

class _GetAllCvUserState extends State<GetAllCvUser> {
  @override


  void initState() {
    //GetWorkCubit.get(context).getResponseCollection(context);
    print(GetWorkCubit.get(context).innerResponseList.length);
    print("id is >>>>>> ${widget.id}");
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('CV Page',style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w600,),),
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,

      ),
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w,vertical: 6.h),
          child: Column(
            children: [

              // length of cv
               Padding(
                 padding: EdgeInsets.only(right: 4.w),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.person,size: 17,color: Colors.black54,),
                    Text("${widget.innerResponseModel!.length}",style: TextStyle(fontSize: 13.sp,color: Colors.black54),)
                  ],
                 ),
               ),

              SizedBox(height: 5.h),

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: GetWorkCubit.get(context).innerResponseList.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        /*
                        child: GestureDetector(
                          onTap: (){
                            navigateTo(context, ShowAllCvForJob(
                              cvJobModel: GetWorkCubit.get(context).innerResponseList[index],
                              pro: GetWorkCubit.get(context).innerResponseList[index].pro!,
                              stName: GetWorkCubit.get(context).innerResponseList[index].addressStName!,
                              stNum: GetWorkCubit.get(context).innerResponseList[index].addressStNum!,
                            ));
                          },
                          child: Container(
                            width: 250.w,
                            height: 130.h,
                            color: Colors.grey[200],
                            child: Column(
                              children: [
                                Text(widget.innerResponseModel![index].firstname!,style: const TextStyle(fontSize: 20),),
                                SizedBox(height: 10.h,),
                                Text(widget.innerResponseModel![index].lastname!,style: const TextStyle(fontSize: 20),),
                                SizedBox(height: 10.h,),
                                Text(widget.innerResponseModel![index].address!,style: const TextStyle(fontSize: 20),),
                                SizedBox(height: 10.h,),

                              ],
                            ),
                          ),
                        ),

                         */
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context, ShowAllCvForJob(
                              cvJobModel: GetWorkCubit.get(context).innerResponseList[index],
                              pro: GetWorkCubit.get(context).innerResponseList[index].pro!,
                              stName: GetWorkCubit.get(context).innerResponseList[index].addressStName!,
                              stNum: GetWorkCubit.get(context).innerResponseList[index].addressStNum!,
                            ));
                          },
                          child: Card(
                            shadowColor: Colors.white,
                            color: Colors.grey[100],
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .95,

                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.account_circle,color: Colors.grey,),
                                            const SizedBox(width: 3),
                                            Text(
                                              "${widget.innerResponseModel![index].firstname} ${widget.innerResponseModel![index].lastname}".toTitleCase(),

                                              style:  TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_android,color: Colors.grey,),
                                            const SizedBox(width: 3),
                                            Text(
                                              "${widget.innerResponseModel![index].phone}",
                                              style:  TextStyle(
                                                  fontSize: 13.sp,

                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.topic,color: Colors.grey,),
                                            const SizedBox(width: 3),
                                            Text(
                                              "${widget.innerResponseModel![index].specialization} ",
                                              style:  TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.accessibility,color: Colors.grey,),
                                            const SizedBox(width: 3),
                                            Text(
                                              "${widget.innerResponseModel![index].positionCv} ",
                                              style:  TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20 ),
                                      child: Column(
                                        children: [
                                          Icon(Icons.contact_mail_outlined,size: 60,color: Colors.grey,)
                                        ],
                                      ),
                                    )


                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
