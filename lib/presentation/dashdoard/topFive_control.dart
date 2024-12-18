import 'package:asec_application/bloc/get_topFive/top_five_cubit.dart';
import 'package:asec_application/model/Top_FIveModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopFiveControlPage extends StatefulWidget {
  TopFiveControlPage({super.key, required this.topFiveModel});

  List<TopFiveModel> topFiveModel;

  @override
  State<TopFiveControlPage> createState() => _TopFiveControlPageState();
}

class _TopFiveControlPageState extends State<TopFiveControlPage> {
  TextEditingController autoCadController = TextEditingController();
  TextEditingController revitController = TextEditingController();
  TextEditingController hvacController = TextEditingController();
  TextEditingController fireFightingController = TextEditingController();
  TextEditingController plumbingController = TextEditingController();
  TextEditingController navisWorkController = TextEditingController();
  TextEditingController dynamoController = TextEditingController();
  TextEditingController enScapeController = TextEditingController();

  //GlobalKey<FormState> reviewKey = GlobalKey();

  //final List<GlobalObjectKey<FormState>> formKeyList = List.generate(8, (index) => GlobalObjectKey<FormState>(index));

  @override
  void dispose() {
    autoCadController.dispose();
    revitController.dispose();
    hvacController.dispose();
    fireFightingController.dispose();
    plumbingController.dispose();
    navisWorkController.dispose();
    dynamoController.dispose();
    enScapeController.dispose();
    super.dispose();
  }

  clear() {
    autoCadController.clear();
    revitController.clear();
    hvacController.clear();
    fireFightingController.clear();
    plumbingController.clear();
    navisWorkController.clear();
    dynamoController.clear();
    enScapeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTopFiveCubit, TopFiveState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Top Five Control",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  //itemCount:GetTopFiveCubit.get(context).TopFiveList.length,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]),
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //name
                                    CustomBuildItemForTopFive(
                                        icon: Icons.person,
                                        label: GetTopFiveCubit.get(context)
                                            .TopFiveList[index]
                                            .name!),

                                    //AutoCad

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'AutoCad'),
                                        //for textFormField
                                        textFormFieldWidget(autoCadController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkAutoCad":
                                                  autoCadController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate AutoCad For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //Revit
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'Revit'),
                                        //for textFormField
                                        textFormFieldWidget(revitController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkRevit":
                                                  revitController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate Revit For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //HVAC Design
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'HVAC Design'),
                                        //for textFormField
                                        textFormFieldWidget(hvacController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkHvac": hvacController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate HVAC Design For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //Firefighting Design
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'Firefighting Design'),
                                        //for textFormField
                                        textFormFieldWidget(
                                            fireFightingController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkFirefighting":
                                                  fireFightingController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate Firefighting Design For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //Plumbing Design
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'Plumbing Design'),
                                        //for textFormField
                                        textFormFieldWidget(plumbingController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkPluming":
                                                  plumbingController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate Plumbing Design For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);

                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //Navisworks
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'Navisworks'),
                                        //for textFormField
                                        textFormFieldWidget(
                                            navisWorkController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkNavisworks":
                                                  navisWorkController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate Navisworks For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //Dynamo
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'Dynamo'),
                                        //for textFormField
                                        textFormFieldWidget(dynamoController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkDynamo":
                                                  dynamoController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate Dynamo For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),

                                    //EnScape
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomBuildItemForTopFive(
                                            icon: Icons.safety_check_outlined,
                                            label: 'EnScape'),
                                        //for textFormField
                                        textFormFieldWidget(enScapeController),
                                        //for icon
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Top Five')
                                                .doc(widget
                                                    .topFiveModel[index].id!)
                                                .update({
                                              "rateSkEnScape":
                                                  enScapeController.text
                                            }).then((value) => {
                                                      print('rate done'),
                                                      clear(),
                                                      setState(() {
                                                        var snackBar = SnackBar(
                                                          content: Text(
                                                            "Done Rate EnScape For ${widget.topFiveModel[index].name}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                        GetTopFiveCubit.get(
                                                                context)
                                                            .getTopFiveSnap();
                                                      })
                                                    });
                                          },
                                          child: iconCheckWidget(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    );
                  })),
        );
      },
    );
  }

  Padding textFormFieldWidget(TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: SizedBox(
        width: 70.w,
        height: 30.h,
        child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Rate',
              hintStyle: TextStyle(fontSize: 10.sp, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                //borderSide:  BorderSide(),
              ),
            ),
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Number';
              }
            }),
      ),
    );
  }

  Padding iconCheckWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Icon(
        Icons.check,
        color: Colors.blue,
      ),
      /*
                                      child: Container(
                                        width: 45.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: Colors.greenAccent
                                        ),
                                        child: const Center(child: Icon(Icons.check)),
                                      )

                                       */
    );
  }
}

class CustomBuildItemForTopFive extends StatelessWidget {
  CustomBuildItemForTopFive(
      {super.key, required this.icon, required this.label});

  IconData icon;
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: SizedBox(
        width: 200.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
