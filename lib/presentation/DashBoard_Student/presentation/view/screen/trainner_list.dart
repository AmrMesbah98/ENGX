import 'package:asec_application/presentation/DashBoard_Student/presentation/manger/dash_board_student_cubit.dart';
import 'package:asec_application/presentation/whatsUp/whatsuo_Page.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_degree.dart';

class TrainerList extends StatefulWidget {
  const TrainerList({super.key});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  bool _HVACswitch = false; // Default value
  bool _Revitswitch = false; // Default value
  bool _Autocadswitch = false; // Default value
  bool _FPMswitch = false; // Default value

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  // Load switch state from shared_preferences
  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _HVACswitch = prefs.getBool('HVAC_switch') ?? false; // Default to false
      _Revitswitch = prefs.getBool('Revit_switch') ?? false; // Default to false
      _Autocadswitch =
          prefs.getBool('AutoCad_switch') ?? false; // Default to false
      _FPMswitch = prefs.getBool('FPMt_switch') ?? false; // Default to false
    });
  }

  // Save switch state to shared_preferences
  Future<void> _saveSwitchStateHVAC(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('HVAC_switch', value);
  } // Save switch state to shared_preferences

  Future<void> _saveSwitchStateRevit(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Revit_switch', value);
  }

  Future<void> _saveSwitchStateAutoCad(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('AutoCad_switch', value);
  }

  Future<void> _saveSwitchStateFPM(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('FPMt_switch', value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardStudentCubit, DashBoardStudentState>(
      listener: (context, state) {
        if (state is DashBoardStudentSuccessInner) {
          navigateTo(context, WhatsUp());
        }
        if (state is DashBoardStudentLoading) {
          CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        var innerModel = DashBoardStudentCubit.get(context).weekTesterModel;
        var outerModel = DashBoardStudentCubit.get(context).dashBoardModel;

        return Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Trainer List',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF6AC1C9),
                    Color(0xFF3857A4),
                  ]),
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
                  child: Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF6AC1C9),
                          Color(0xFF3857A4),
                        ]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        spacing: 10,
                        children: [
                          //AutoCad
                          Row(
                            children: [
                              Text(
                                "AutoCad",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                value: _Autocadswitch,
                                onChanged: (value) async {
                                  print("Switch value changed to: $value");

                                  setState(() {
                                    _Autocadswitch = value;
                                  });

                                  // Save the state locally
                                  await _saveSwitchStateAutoCad(value);
                                  print("Switch state saved locally.");

                                  // Update Firebase
                                  try {
                                    CollectionReference mainCollection =
                                        FirebaseFirestore.instance
                                            .collection('DashBoard User');
                                    QuerySnapshot querySnapshot =
                                        await mainCollection.get();

                                    print(
                                        "Main collection fetched: ${querySnapshot.docs.length} documents");

                                    for (QueryDocumentSnapshot doc
                                        in querySnapshot.docs) {
                                      CollectionReference innerCollection =
                                          mainCollection
                                              .doc(doc.id)
                                              .collection('WeekTest');
                                      QuerySnapshot innerSnapshot =
                                          await innerCollection
                                              .where('subject',
                                                  isEqualTo: 'AutoCad')
                                              .get();

                                      print(
                                          "Inner collection fetched: ${innerSnapshot.docs.length} documents");

                                      for (QueryDocumentSnapshot innerDoc
                                          in innerSnapshot.docs) {
                                        print(
                                            "Updating document with ID: ${innerDoc.id}");
                                        await innerCollection
                                            .doc(innerDoc.id)
                                            .update({
                                          'open': value.toString(),
                                        });
                                      }
                                    }

                                    print(
                                        "Firebase update completed successfully.");
                                  } catch (e) {
                                    print("Error during Firebase update: $e");
                                  }
                                },
                              ),
                            ],
                          ),
                          //revit
                          Row(
                            children: [
                              Text(
                                "Revit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                value: _Revitswitch,
                                onChanged: (value) async {
                                  print("Switch value changed to: $value");

                                  setState(() {
                                    _Revitswitch = value;
                                  });

                                  // Save the state locally
                                  await _saveSwitchStateRevit(value);
                                  print("Switch state saved locally.");

                                  // Update Firebase
                                  try {
                                    CollectionReference mainCollection =
                                        FirebaseFirestore.instance
                                            .collection('DashBoard User');
                                    QuerySnapshot querySnapshot =
                                        await mainCollection.get();

                                    print(
                                        "Main collection fetched: ${querySnapshot.docs.length} documents");

                                    for (QueryDocumentSnapshot doc
                                        in querySnapshot.docs) {
                                      CollectionReference innerCollection =
                                          mainCollection
                                              .doc(doc.id)
                                              .collection('WeekTest');
                                      QuerySnapshot innerSnapshot =
                                          await innerCollection
                                              .where('subject',
                                                  isEqualTo: 'Revit')
                                              .get();

                                      print(
                                          "Inner collection fetched: ${innerSnapshot.docs.length} documents");

                                      for (QueryDocumentSnapshot innerDoc
                                          in innerSnapshot.docs) {
                                        print(
                                            "Updating document with ID: ${innerDoc.id}");
                                        await innerCollection
                                            .doc(innerDoc.id)
                                            .update({
                                          'open': value.toString(),
                                        });
                                      }
                                    }

                                    print(
                                        "Firebase update completed successfully.");
                                  } catch (e) {
                                    print("Error during Firebase update: $e");
                                  }
                                },
                              ),
                            ],
                          ),
                          //HVAC
                          Row(
                            children: [
                              Text(
                                "HVAC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                value: _HVACswitch,
                                onChanged: (value) async {
                                  print("Switch value changed to: $value");

                                  setState(() {
                                    _HVACswitch = value;
                                  });

                                  // Save the state locally
                                  await _saveSwitchStateHVAC(value);
                                  print("Switch state saved locally.");

                                  // Update Firebase
                                  try {
                                    CollectionReference mainCollection =
                                        FirebaseFirestore.instance
                                            .collection('DashBoard User');
                                    QuerySnapshot querySnapshot =
                                        await mainCollection.get();

                                    print(
                                        "Main collection fetched: ${querySnapshot.docs.length} documents");

                                    for (QueryDocumentSnapshot doc
                                        in querySnapshot.docs) {
                                      CollectionReference innerCollection =
                                          mainCollection
                                              .doc(doc.id)
                                              .collection('WeekTest');
                                      QuerySnapshot innerSnapshot =
                                          await innerCollection
                                              .where('subject',
                                                  isEqualTo: 'HVAC')
                                              .get();

                                      print(
                                          "Inner collection fetched: ${innerSnapshot.docs.length} documents");

                                      for (QueryDocumentSnapshot innerDoc
                                          in innerSnapshot.docs) {
                                        print(
                                            "Updating document with ID: ${innerDoc.id}");
                                        await innerCollection
                                            .doc(innerDoc.id)
                                            .update({
                                          'open': value.toString(),
                                        });
                                      }
                                    }

                                    print(
                                        "Firebase update completed successfully.");
                                  } catch (e) {
                                    print("Error during Firebase update: $e");
                                  }
                                },
                              ),
                            ],
                          ),
                          //FPM
                          Row(
                            children: [
                              Text(
                                "FPM",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                value: _FPMswitch,
                                onChanged: (value) async {
                                  print("Switch value changed to: $value");

                                  setState(() {
                                    _FPMswitch = value;
                                  });

                                  // Save the state locally
                                  await _saveSwitchStateFPM(value);
                                  print("Switch state saved locally.");

                                  // Update Firebase
                                  try {
                                    CollectionReference mainCollection =
                                        FirebaseFirestore.instance
                                            .collection('DashBoard User');
                                    QuerySnapshot querySnapshot =
                                        await mainCollection.get();

                                    print(
                                        "Main collection fetched: ${querySnapshot.docs.length} documents");

                                    for (QueryDocumentSnapshot doc
                                        in querySnapshot.docs) {
                                      CollectionReference innerCollection =
                                          mainCollection
                                              .doc(doc.id)
                                              .collection('WeekTest');
                                      QuerySnapshot innerSnapshot =
                                          await innerCollection
                                              .where('subject',
                                                  isEqualTo: 'FPM')
                                              .get();

                                      print(
                                          "Inner collection fetched: ${innerSnapshot.docs.length} documents");

                                      for (QueryDocumentSnapshot innerDoc
                                          in innerSnapshot.docs) {
                                        print(
                                            "Updating document with ID: ${innerDoc.id}");
                                        await innerCollection
                                            .doc(innerDoc.id)
                                            .update({
                                          'open': value.toString(),
                                        });
                                      }
                                    }

                                    print(
                                        "Firebase update completed successfully.");
                                  } catch (e) {
                                    print("Error during Firebase update: $e");
                                  }
                                },
                              ),
                            ],
                          ),

                          /*
                           Row(
                            children: [
                              Text("Revit"),
                              Spacer(),
                              CupertinoSwitch(
                                value: _AutoCadswitchV ?? false,
                                onChanged: (value) async {
                                  setState(() {
                                    _AutoCadswitchV = value;

                                    print("my val is $_AutoCadswitchV");
                                  });

                                  // Reference to the main collection
                                  CollectionReference mainCollection =
                                      FirebaseFirestore.instance
                                          .collection('DashBoard User');

                                  // Retrieve all documents from the main collection
                                  QuerySnapshot querySnapshot =
                                      await mainCollection.get();

                                  for (QueryDocumentSnapshot doc
                                      in querySnapshot.docs) {
                                    // Access the inner collection for each document in the main collection
                                    CollectionReference innerCollection =
                                        mainCollection
                                            .doc(doc
                                                .id) // Reference to the specific document
                                            .collection('WeekTest');

                                    // You can add a query to filter specific documents within the inner collection
                                    QuerySnapshot innerSnapshot =
                                        await innerCollection
                                            .where('subject',
                                                isEqualTo: 'Revit')
                                            .get();

                                    for (QueryDocumentSnapshot innerDoc
                                        in innerSnapshot.docs) {
                                      // Update a specific field in this document
                                      await innerCollection
                                          .doc(innerDoc.id)
                                          .update({
                                        'open': _AutoCadswitchV
                                            .toString(), // Update with your desired field and value
                                      });
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("AutoCad"),
                              Spacer(),
                              CupertinoSwitch(
                                value: _Revitswitch ?? false,
                                onChanged: (value) async {
                                  setState(() {
                                    _Revitswitch = value;

                                    print("my val is $_Revitswitch");
                                  });

                                  // Reference to the main collection
                                  CollectionReference mainCollection =
                                      FirebaseFirestore.instance
                                          .collection('DashBoard User');

                                  // Retrieve all documents from the main collection
                                  QuerySnapshot querySnapshot =
                                      await mainCollection.get();

                                  for (QueryDocumentSnapshot doc
                                      in querySnapshot.docs) {
                                    // Access the inner collection for each document in the main collection
                                    CollectionReference innerCollection =
                                        mainCollection
                                            .doc(doc
                                                .id) // Reference to the specific document
                                            .collection('WeekTest');

                                    // You can add a query to filter specific documents within the inner collection
                                    QuerySnapshot innerSnapshot =
                                        await innerCollection
                                            .where('subject',
                                                isEqualTo: 'AutoCad')
                                            .get();

                                    for (QueryDocumentSnapshot innerDoc
                                        in innerSnapshot.docs) {
                                      // Update a specific field in this document
                                      await innerCollection
                                          .doc(innerDoc.id)
                                          .update({
                                        'open': _Revitswitch
                                            .toString(), // Update with your desired field and value
                                      });
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("FPM"),
                              Spacer(),
                              CupertinoSwitch(
                                value: _FPMswitch ?? false,
                                onChanged: (value) async {
                                  setState(() {
                                    _FPMswitch = value;

                                    print("my val is $_FPMswitch");
                                  });

                                  // Reference to the main collection
                                  CollectionReference mainCollection =
                                      FirebaseFirestore.instance
                                          .collection('DashBoard User');

                                  // Retrieve all documents from the main collection
                                  QuerySnapshot querySnapshot =
                                      await mainCollection.get();

                                  for (QueryDocumentSnapshot doc
                                      in querySnapshot.docs) {
                                    // Access the inner collection for each document in the main collection
                                    CollectionReference innerCollection =
                                        mainCollection
                                            .doc(doc
                                                .id) // Reference to the specific document
                                            .collection('WeekTest');

                                    // You can add a query to filter specific documents within the inner collection
                                    QuerySnapshot innerSnapshot =
                                        await innerCollection
                                            .where('subject', isEqualTo: 'FPM')
                                            .get();

                                    for (QueryDocumentSnapshot innerDoc
                                        in innerSnapshot.docs) {
                                      // Update a specific field in this document
                                      await innerCollection
                                          .doc(innerDoc.id)
                                          .update({
                                        'open': _FPMswitch
                                            .toString(), // Update with your desired field and value
                                      });
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                           */
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 400.h,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: outerModel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF6AC1C9),
                                  Color(0xFF3857A4),
                                ]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF6AC1C9),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name : ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            outerModel[index].name!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Password : ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            outerModel[index].identity!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Code : ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            outerModel[index].code!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await DashBoardStudentCubit.get(context)
                                            .getWeakCollectionDashboard(
                                                outerModel[index].id!);

                                        navigateTo(
                                            context,
                                            DashBoardDegree(
                                              id: outerModel[index].id!,
                                            ));
                                      },
                                      child: Text(
                                        "login",
                                        style:
                                            TextStyle(color: Color(0xFF3857A4)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
