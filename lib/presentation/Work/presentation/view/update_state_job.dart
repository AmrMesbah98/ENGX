import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/core/tost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/components/components.dart';
import '../../../resources/color_manager.dart';

class UpdateStateOfJob extends StatefulWidget {
   UpdateStateOfJob({super.key,required this.id,required this.innerDoc});

   String? id;
   String? innerDoc;

  @override
  State<UpdateStateOfJob> createState() => _UpdateStateOfJobState();
}

class _UpdateStateOfJobState extends State<UpdateStateOfJob> {
   String selectJobState = "Active";

   @override
  void initState() {
    print("id is ${widget.id}  >>>>>>>>>>>>>>>>>>>");
    print("inner id is ${widget.innerDoc}  >>>>>>>>>>>>>>>>>>>");
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update State of Job",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //active
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Text("State of Job",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    )),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width *
                      .4,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: ColorManager.Black,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              "State of Job",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight.bold,
                                color: ColorManager
                                    .Black,
                              ),
                              overflow: TextOverflow
                                  .ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: constantvar
                          .stateJobList
                          .map((item) =>
                          DropdownMenuItem<
                              String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                              overflow:
                              TextOverflow
                                  .ellipsis,
                            ),
                          ))
                          .toList(),
                      value: selectJobState,
                      onChanged: (value) {
                        setState(() {
                          selectJobState =
                          value as String;
                          constantvar.selectTrack =
                              value;
                          print(selectJobState);
                        });
                      },
                      buttonStyleData:
                      ButtonStyleData(
                        height: 50,
                        width: 200,
                        padding:
                        const EdgeInsets.only(
                            left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                              14),
                          border: Border.all(
                            color:
                            (Colors.grey[100])!,
                          ),
                          color: (Colors.grey[100])!,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: const Icon(
                          Icons
                              .arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor:
                        ColorManager.Black,
                        iconDisabledColor:
                        ColorManager.Black,
                      ),
                      dropdownStyleData:
                      DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        padding: null,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                              14),
                          color: (Colors.grey[100])!,
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme:
                        ScrollbarThemeData(
                          radius:
                          const Radius.circular(
                              40),
                          thickness:
                          MaterialStateProperty
                              .all<double>(6),
                          thumbVisibility:
                          MaterialStateProperty
                              .all<bool>(true),
                        ),
                      ),
                      menuItemStyleData:
                      const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(
                            left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //space
          SizedBox(height: 15.h,),

          //button update
          //button update state job
          defaultButton(
            width: MediaQuery.of(context).size.width * .9,
            isUpperCase: true,
            sizeText: 18,
            background: Colors.grey[200]!,
            radius: 10,
            function: () {

              FirebaseFirestore.instance.collection("Work").doc(widget.id).collection("Request").doc(widget.innerDoc).update(
                  {
                    "active":selectJobState
                  }).then((value) {
                    debugPrint("update state of job done >>>>>>>>>");

              });

            },
            text: "Update ",
          ),
        ],
      ),
    );
  }
}
