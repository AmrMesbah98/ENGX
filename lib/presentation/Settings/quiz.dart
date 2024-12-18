import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/get_quiz/quiz_cubit.dart';
import 'package:asec_application/presentation/Settings/settings.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/get_information/user_information_cubit.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

   List<String?>? selectedAnswers; // List to store selected answers for each question

   double totalDegree = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the list of selected answers with null values
    selectedAnswers = List.generate(4,(_) => null,);
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
      appBar: AppBar(
        title: const Text("Quiz"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [


                //for quiz
                SizedBox  (
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: QuizCubit.get(context).quizList.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(QuizCubit.get(context).quizList[index].question!),

                            RadioListTile(
                              title: Text(
                                QuizCubit.get(context).quizList[index].answers![0],
                              ),
                              value: QuizCubit.get(context).quizList[index].degree![0],
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
                            RadioListTile(
                              title: Text(
                                QuizCubit.get(context).quizList[index].answers![1],
                              ),
                              value: QuizCubit.get(context).quizList[index].degree![1],
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
                            RadioListTile(
                              title: Text(
                                QuizCubit.get(context).quizList[index].answers![2],
                              ),
                              value: QuizCubit.get(context).quizList[index].degree![2],
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
                            RadioListTile(
                              title: Text(
                                QuizCubit.get(context).quizList[index].answers![3],
                              ),
                              value: QuizCubit.get(context).quizList[index].degree![3],
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

                            // Repeat RadioListTile widgets for other answer options



                          ],
                        ),
                      );
                    },
                  ),
                ),


                //for button finish
                /*
                GestureDetector(
                  onTap: (){

                    QuizCubit.get(context).setQuizDegreeFunction(
                        name: '${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}',
                        degree: '${totalDegree.toInt().toString()} / 5',
                        quiz: '1'
                    ).then((value) {
                      print('done degree send');
                      navigateTo(context, Settings());

                      showDialog(
                          context: context,
                          builder: (context)
                          {
                            return AlertDialog(
                              title:
                              const Text('Congratulation'),
                              content: Text('Degree : ${totalDegree.toInt().toString()} / 5'),
                            );
                          }
                      );

                    });



                  },
                  child: Container(
                    width: 115.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.greenAccent
                    ),
                    child: const Center(child: Text('Finish',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),)),
                  ),
                ),

                 */

                //space
                SizedBox(height: 20.h,),



              ],
            ),
          );
        },
      ),
    );
  }
}