

import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/model/quiz_model.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:asec_application/zoomVideo/data/zoomMeetingModel.dart';
import 'package:asec_application/zoomVideo/presentation/view/innerZoomVideoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/get_information/user_information_cubit.dart';
import '../../data/innerQuizModel.dart';
import '../manager/zoom_meeting_cubit.dart';





class InnerQuizPage extends StatefulWidget {
  InnerQuizPage({Key? key,required this.innerQuizModel,required this.id,required this.title}) : super(key: key);

  List<InnerQuizModel> innerQuizModel;
  //List<ZoomMeetingModel> zoomMeetingModel;
  String id;
  String title;

  @override
  State<InnerQuizPage> createState() => _InnerQuizPageState();
}

class _InnerQuizPageState extends State<InnerQuizPage> {

  List<String?>? selectedAnswers; // List to store selected answers for each question

  double totalDegree = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the list of selected answers with null values
    selectedAnswers = List.generate(10,(_) => null,);
    //to make total degree equal 0
    constantvar.total='0';

  }

  void calculateTotalDegree() {
    totalDegree = 0;
    for (int i = 0; i < selectedAnswers!.length; i++) {
      if (selectedAnswers![i] != null) {
        totalDegree += double.parse(selectedAnswers![i]!);
      }

      // for final degree
      constantvar.total = totalDegree;



    }
  }

  @override
  Widget build(BuildContext context) {
    // for final degree
    print(" final degree ${constantvar.total}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quiz",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: GestureDetector(
            onTap: (){
              navigateTo(context, InnerZoomVideoPage(
                innerZoomMeetingModel:ZoomMeetingCubit.get(context).innerZoomMeetingList,
                id: constantvar.idZoomVideoCategory!,
              ));
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<ZoomMeetingCubit, ZoomMeetingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [

                //space
                SizedBox(height: 15.h,),

                //for quiz
                SizedBox  (
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ZoomMeetingCubit.get(context).innerQuizList.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              //for question
                              SizedBox(
                                width:double.infinity,
                                child: Card(
                                    elevation: 8,
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      //borderSide: const BorderSide(color: Color(0xff0f0e3d),)
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient:    const LinearGradient(
                                            colors: [
                                              Color(0xff0f0e3d),
                                              Color(0xff323381)
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                        //color: const Color(0xff0f0e3d),
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                        child: Text(widget.innerQuizModel[index].question!,style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.white),),
                                      ),
                                    )),
                              ),

                              //space
                              SizedBox(height: 10.h,),


                              //for first answer
                              containerAndCard(
                                RadioListTile(
                                  title: Text(
                                    widget.innerQuizModel[index].answers![0],
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  value: widget.innerQuizModel[index].degree![0],
                                  groupValue: selectedAnswers![index],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers![index] = value.toString();
                                      print(selectedAnswers![index]);

                                      calculateTotalDegree();
                                      print("Total Degree: $totalDegree");



                                    });
                                  },
                                ),
                              ),

                              //space
                              SizedBox(height: 5.h,),

                              //for second answer
                              containerAndCard(
                                RadioListTile(
                                  title: Text(
                                    widget.innerQuizModel[index].answers![1],
                                  ),
                                  value: widget.innerQuizModel[index].degree![1],
                                  groupValue: selectedAnswers![index],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers![index] = value.toString();
                                      print(selectedAnswers![index]);

                                      calculateTotalDegree();
                                      print("Total Degree: $totalDegree");


                                    });
                                  },
                                ),
                              ),

                              //space
                              SizedBox(height: 5.h,),

                              //for third answer
                              containerAndCard(
                                RadioListTile(
                                title: Text(
                                  widget.innerQuizModel[index].answers![2],
                                ),
                                value: widget.innerQuizModel[index].degree![2],
                                groupValue: selectedAnswers![index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswers![index] = value.toString();
                                    print(selectedAnswers![index]);

                                    calculateTotalDegree();
                                    print("Total Degree: $totalDegree");


                                  });
                                },
                              ),
                              ),


                              //space
                              SizedBox(height: 5.h,),

                              //for fourth answer
                              containerAndCard(
                                RadioListTile(
                                  title: Text(
                                    widget.innerQuizModel[index].answers![3],
                                  ),
                                  value: widget.innerQuizModel[index].degree![3],
                                  groupValue: selectedAnswers![index],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers![index] = value.toString();
                                      print(selectedAnswers![index]);


                                      calculateTotalDegree();
                                      print("Total Degree: $totalDegree");


                                    });
                                  },
                                ),
                              ),

                              //space
                              SizedBox(height: 5.h,),



                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),




                //space
                SizedBox(height: 20.h,),

                //for button finish
                SizedBox(
                  width: 215.w,
                  height: 40.h,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){

                          ZoomMeetingCubit.get(context).setQuizDegreeFunction(
                            name: '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}',
                            degree: '${totalDegree.toInt().toString()} / ${ZoomMeetingCubit.get(context).innerQuizList.length.toString()}',
                            //quiz: ZoomMeetingCubit.get(context).zoomMeetingList[index].title!,
                            quiz: widget.title!,
                          ).then((value) {
                            print('done degree send');
                            navigateTo(context, InnerZoomVideoPage(
                              innerZoomMeetingModel:ZoomMeetingCubit.get(context).innerZoomMeetingList,
                              id: constantvar.idZoomVideoCategory!,
                            ));

                            setState(() {
                              ZoomMeetingCubit.get(context).getQuizDegreeFunction();
                            });


                            showDialog(
                                context: context,
                                builder: (context)
                                {
                                  return AlertDialog(
                                    elevation: 10,
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    title:
                                     Row(
                                      children: [
                                        const Text('Congratulation'),
                                        SizedBox(width: 5.w,),
                                        const Icon(Icons.favorite,size: 20,color: Colors.black,)
                                      ],
                                    ),
                                    content: Text('Degree : ${totalDegree.toInt().toString()} / ${ZoomMeetingCubit.get(context).innerQuizList.length}'),
                                  );
                                }
                            );

                          });

                        },
                        child: Container(
                          width: 215.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            gradient:    const LinearGradient(
                                colors: [
                                  Color(0xff0f0e3d),
                                  Color(0xff323381)
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: const Center(child: Text('Finish',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),)),
                        ),
                      );
                    },
                  ),
                ),

                //space
                SizedBox(height: 20.h,),


              ],
            ),
          );
        },
      ),
    );
  }



  Widget containerAndCard(Widget radioButtonWidget){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: Colors.white)
        ),
        child: radioButtonWidget,
      ),
    );
  }


}


