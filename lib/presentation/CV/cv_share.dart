import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/Widget/drop_down.dart';
import 'package:asec_application/bloc/CV/cv_control_cubit.dart';
import 'package:asec_application/bloc/DataId/id_data_cubit.dart';
import 'package:asec_application/presentation/CV/search_member.dart';
import 'package:asec_application/presentation/login/customTextFormField.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../resources/color_manager.dart';

class ShareCV extends StatefulWidget {
  ShareCV({super.key});

  @override
  State<ShareCV> createState() => _ShareCVState();
}

class _ShareCVState extends State<ShareCV> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController graduationYearController = TextEditingController();
  TextEditingController experienceYearController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController startDateInputController = TextEditingController();
  TextEditingController endDateInputController = TextEditingController();
  TextEditingController shareProjectController = TextEditingController();
  TextEditingController addressControllerStNum = TextEditingController();
  TextEditingController addressControllerStName = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController aboutUsController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    linkedinController.dispose();
    graduationYearController.dispose();
    experienceYearController.dispose();
    companyNameController.dispose();
    startDateInputController.dispose();
    facebookController.dispose();
    //twitterController.dispose();
    endDateInputController.dispose();
    shareProjectController.dispose();
    facultyController.dispose();
    addressControllerStName.dispose();
    addressControllerStNum.dispose();
    addressController.dispose();
    aboutUsController.dispose();
    hobbiesController.dispose();
    super.dispose();
  }

  String specialization = "Electrical";
  String selectPositionCv = "Trainee Engineer";
  String selectGrade = "None";
  String selectGpa = "70";
  double selectFinalProjectGPA = 150.0;
  String selectState = "Single";
  String selectMilitary = "Done";

  clear() {
    firstnameController.clear();
    lastnameController.clear();
    phoneController.clear();
    emailController.clear();
    linkedinController.clear();
    // twitterController.clear();
    facebookController.clear();
    graduationYearController.clear();
    experienceYearController.clear();
    companyNameController.clear();
    startDateInputController.clear();
    endDateInputController.clear();
    facultyController.clear();
    shareProjectController.clear();
    addressController.clear();
    addressControllerStNum.clear();
    addressControllerStName.clear();
    aboutUsController.clear();
    hobbiesController.clear();
  }

  List<String> positionCv = [
    "Trainee Engineer",
    "Site Engineer",
    "Design Engineer",
    "Technical Engineer",
  ];

  List<String> gradeList = [
    "None",
    "Good",
    "Very Good",
    "Excellent",
  ];

  List<String> gpaList = [
    "85",
    "84",
    "83",
    "82",
    "81",
    "80",
    "79",
    "78",
    "77",
    "76",
    "75",
    "74",
    "73",
    "71",
    "70",
    "69",
    "68",
    "67",
    "66",
    "65",
  ];

  List<String> stateList = [
    "Single",
    "Married",
    "Engaged",
  ];

  List<String> militaryList = [
    "Done",
    "Exemption",
    "Delay",
  ];

  workFunction() {
    if (constantvar.selectWork == false) {
      return Container();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), border: Border.all()),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                label: "Company Name",
                icon: Icons.home_work_outlined,
                keyboardType: TextInputType.text,
                controller: companyNameController,
                secure: false,
                maxLine: 1),
            Row(
              children: [
                const SizedBox(width: 10),
                const Text(
                  "From",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: 70,
                  child: Center(
                    child: TextField(
                      controller: startDateInputController,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Date",
                          labelStyle: TextStyle(fontSize: 20)),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            currentDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        //DateTime.now() - not to allow to choose before today.

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            startDateInputController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                  ),
                ),
                const Spacer(),
                /*
                  const Text(
                    "to",
                    style: TextStyle(fontSize: 20),
                  ),


                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        .3,
                    height: 70,
                    child: Center(
                      child: TextField(
                        controller:
                        endDateInputController,
                        //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(
                                Icons.calendar_today),
                            //icon of text field
                            labelText: "Date",
                            labelStyle:
                            TextStyle(fontSize: 20)),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate =
                          await showDatePicker(
                              context: context,
                              initialDate:
                              DateTime.now(),
                              firstDate:
                              DateTime(2000),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate:
                              DateTime(2030));

                          if (pickedDate != null) {
                            print(pickedDate);
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                            DateFormat('yyyy-MM-dd')
                                .format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              endDateInputController
                                  .text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                    */
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Position",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Spacer(),
                  DropdownButtonHideUnderline(
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
                              "Position",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.Black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: constantvar.positionCv
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.Black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectPositionCv,
                      onChanged: (value) {
                        setState(() {
                          selectPositionCv = value as String;
                          constantvar.selectPositionCv = value;
                          print(specialization);
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 40,
                        width: 200,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: (Colors.grey[100])!,
                          ),
                          color: (Colors.grey[100])!,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: ColorManager.Black,
                        iconDisabledColor: ColorManager.Black,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        padding: null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: (Colors.grey[100])!,
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
                label: "Name of Project",
                icon: Icons.home_work_outlined,
                keyboardType: TextInputType.text,
                controller: shareProjectController,
                secure: false,
                maxLine: 1),
          ],
        ),
      );
    }
  }

  GlobalKey<FormState> cvForm = GlobalKey();

  String codeCountry = "EG";

  addIdToCheckCollection() {
    FirebaseFirestore.instance
        .collection('check')
        .doc("2VCKA0ejOAwI7o5qxeOn")
        .update({
      'idList': FieldValue.arrayUnion([id]),
    }).then((value) {
      print(" uid ============>>>>>>>>>>>>>>>> id is add to list");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IdDataCubit, IdDataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black54),
              title: const Text(
                'Share CV',
                style: TextStyle(color: Colors.black54),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, const SearchPage());
                    },
                    icon: const Icon(Icons.search, color: Colors.black54))
              ],
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            body: SafeArea(
              child: Form(
                key: cvForm,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all()),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  // name
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                            label: "First Name",
                                            maxDigit: 11,
                                            icon: Icons.person_2_outlined,
                                            keyboardType: TextInputType.text,
                                            controller: firstnameController,
                                            secure: false,
                                            maxLine: 1),
                                      ),
                                      Expanded(
                                        child: CustomTextFormField(
                                            label: "Last Name",
                                            maxDigit: 11,
                                            icon: Icons.person_2_outlined,
                                            keyboardType: TextInputType.text,
                                            controller: lastnameController,
                                            secure: false,
                                            maxLine: 1),
                                      ),
                                    ],
                                  ),
                                  // email
                                  CustomTextFormField(
                                      label: "Email",
                                      icon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      secure: false,
                                      maxLine: 1),
                                  // university
                                  CustomTextFormField(
                                      label: "University",
                                      icon: Icons.safety_check_outlined,
                                      keyboardType: TextInputType.text,
                                      controller: facultyController,
                                      secure: false,
                                      maxLine: 1),
                                  // specialization
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 5.h),
                                    child: Row(
                                      children: [
                                        Text("Specialization",
                                            style: TextStyle(
                                              fontSize: 16.sp,
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
                                                      "Specialization",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: constantvar
                                                  .specializationList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: specialization,
                                              onChanged: (value) {
                                                setState(() {
                                                  specialization =
                                                      value as String;
                                                  constantvar.selectTrack =
                                                      value;
                                                  print(specialization);
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: (Colors.grey[100])!,
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
                                                      BorderRadius.circular(14),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(-20, 0),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  radius:
                                                      const Radius.circular(40),
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
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
                                  // Grade
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 5.h),
                                    child: Row(
                                      children: [
                                        Text("Grade",
                                            style: TextStyle(
                                              fontSize: 16.sp,
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
                                                      "GPA",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: gradeList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectGrade,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectGrade = value as String;
                                                  selectGrade = value;
                                                  print(selectGrade);
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: (Colors.grey[100])!,
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
                                                      BorderRadius.circular(14),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(-20, 0),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  radius:
                                                      const Radius.circular(40),
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
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
                                  // GPA
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 5.h),
                                    child: Row(
                                      children: [
                                        Text("GPA",
                                            style: TextStyle(
                                              fontSize: 16.h,
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
                                                      "GPA",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: gpaList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectGpa,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectGpa = value as String;
                                                  selectGpa = value;
                                                  print(selectGpa);
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: (Colors.grey[100])!,
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
                                                      BorderRadius.circular(14),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(-20, 0),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  radius:
                                                      const Radius.circular(40),
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
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
                                  //state
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 5.h),
                                    child: Row(
                                      children: [
                                        Text("Relationship",
                                            style: TextStyle(
                                              fontSize: 16.h,
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
                                                      "GPA",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: stateList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectState,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectState = value as String;
                                                  selectState = value;
                                                  print(selectState);
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: (Colors.grey[100])!,
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
                                                      BorderRadius.circular(14),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(-20, 0),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  radius:
                                                      const Radius.circular(40),
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
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
                                  // Military
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 5.h),
                                    child: Row(
                                      children: [
                                        Text("Military",
                                            style: TextStyle(
                                              fontSize: 16.h,
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
                                                      "GPA",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            ColorManager.Black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: militaryList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectMilitary,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectMilitary =
                                                      value as String;
                                                  selectMilitary = value;
                                                  print(selectMilitary);
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: (Colors.grey[100])!,
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
                                                      BorderRadius.circular(14),
                                                  color: (Colors.grey[100])!,
                                                ),
                                                elevation: 8,
                                                offset: const Offset(-20, 0),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  radius:
                                                      const Radius.circular(40),
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
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
                                  // phone
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: CountryCodePicker(
                                          onChanged: (element) {
                                            debugPrint(element.code.toString());
                                            setState(() {
                                              codeCountry =
                                                  element.toLongString();
                                            });
                                          },
                                          initialSelection: 'EG',
                                          showCountryOnly: true,
                                          showOnlyCountryWhenClosed: true,
                                          favorite: const [
                                            'EG',
                                            'AE',
                                            'DZ',
                                            'LY',
                                            'AS',
                                            'YE',
                                            'LB',
                                            'SD',
                                            'SY'
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextFormField(
                                          label: "Phone",
                                          icon: Icons.phone_android_outlined,
                                          keyboardType: TextInputType.number,
                                          controller: phoneController,
                                          secure: false,
                                          maxLine: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Address street
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                            label: "St Number",
                                            icon: Icons.location_on_outlined,
                                            keyboardType: TextInputType.text,
                                            controller: addressControllerStNum,
                                            secure: false,
                                            maxLine: 1),
                                      ),
                                      Expanded(
                                        child: CustomTextFormField(
                                            label: "St Name",
                                            icon: Icons.location_on_outlined,
                                            keyboardType: TextInputType.text,
                                            controller: addressControllerStName,
                                            secure: false,
                                            maxLine: 1),
                                      ),
                                    ],
                                  ),
                                  // Address city
                                  CustomTextFormField(
                                      label: "City Name",
                                      icon: Icons.location_on_outlined,
                                      keyboardType: TextInputType.text,
                                      controller: addressController,
                                      secure: false,
                                      maxLine: 1),
                                  // Linked in
                                  CustomTextFormField(
                                      label: "Linked in",
                                      icon: FontAwesomeIcons.linkedin,
                                      keyboardType: TextInputType.text,
                                      controller: linkedinController,
                                      secure: false,
                                      maxLine: 1),
                                  // Facebook
                                  CustomTextFormField(
                                      label: "Facebook",
                                      icon: Icons.facebook,
                                      keyboardType: TextInputType.text,
                                      controller: facebookController,
                                      secure: false,
                                      maxLine: 1),
                                  // Graduation Year
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text("Graduation Year",
                                            style: TextStyle(
                                              fontSize: 16.h,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Spacer(),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .32,
                                          height: 40,
                                          child: Center(
                                            child: TextField(
                                              controller:
                                                  graduationYearController,
                                              //editing controller of this TextField
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(Icons
                                                    .calendar_today), //icon of text field
                                              ),
                                              readOnly: true,
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime(2030));

                                                if (pickedDate != null) {
                                                  print(pickedDate);
                                                  //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('yyyy')
                                                          .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  setState(() {
                                                    graduationYearController
                                                            .text =
                                                        formattedDate; //set output date to TextField value.
                                                  });
                                                } else {
                                                  graduationYearController
                                                      .text = "2024";
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const MultiDrop(),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            // are you train in asec

                            const Divider(
                              color: Colors.grey,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: CheckboxListTile(
                                  title: Text(
                                    "Are you Training in ASEC",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  value: constantvar.trainAsec,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      constantvar.trainAsec = val!;
                                    });
                                  }),
                            ),

                            const Divider(
                              color: Colors.grey,
                            ),
                            // Are you work
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: CheckboxListTile(
                                  title: Text(
                                    "Are you work",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  value: constantvar.selectWork,
                                  activeColor: Colors.blueAccent,
                                  onChanged: (val) {
                                    setState(() {
                                      constantvar.selectWork = val!;
                                      print(constantvar.selectWork);
                                    });
                                  }),
                            ),

                            const Divider(
                              color: Colors.grey,
                            ),

                            // work function

                            workFunction(),

                            const SizedBox(
                              height: 20,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Hobbies",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18),
                                          )
                                        ]),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    /*
                                     // about us
                                    TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      maxLength: 100,

                                      decoration:  InputDecoration(

                                        labelText: "About us",
                                        labelStyle: TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                      ),
                                      controller: aboutUsController,
                                      cursorColor: Colors.black,

                                      validator: (val){
                                        if(val!.isEmpty)
                                        {
                                          return "Please enter some info";
                                        }
                                      },
                                      maxLines: 4,
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.02),
                                    // hobbies
                                    /*
                                    TextFormField(
                                      maxLength: 100,
                                      decoration:  InputDecoration(
                                        labelText: "Hobbies",
                                        labelStyle: const TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(24),
                                            borderSide: const BorderSide(color: Colors.black)
                                        ),
                                      ),
                                      controller: hobbiesController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.black,
                                      validator: (val){
                                        if(val!.isEmpty)
                                        {
                                          return "Please enter some info";
                                        }
                                      },
                                      maxLines: 4,
                                    ),
                                     */
                                     */

                                    Column(
                                      children: [
                                        CheckboxListTile(
                                            title: const Text("Football"),
                                            subtitle: Text(
                                                "Good for palying football"),
                                            activeColor: Colors.blue,
                                            value: constantvar.hobbiesOne,
                                            onChanged: (val) {
                                              setState(() {
                                                constantvar.hobbiesOne = val!;
                                                if (constantvar.hobbiesOne ==
                                                    true) {
                                                  constantvar.hobbiesOneVal =
                                                      "Football";
                                                  constantvar.hobbiesList
                                                      .add("Football");

                                                  print("done 1");
                                                  print(constantvar
                                                      .hobbiesOneVal);
                                                } else {
                                                  constantvar.hobbiesOneVal =
                                                      "";
                                                  constantvar.hobbiesList
                                                      .remove("Football");
                                                }
                                              });
                                            }),
                                        CheckboxListTile(
                                            title: const Text("Basketball"),
                                            subtitle: Text(
                                                "Good for palying basketball"),
                                            value: constantvar.hobbiesTwo,
                                            activeColor: Colors.blue,
                                            onChanged: (val) {
                                              setState(() {
                                                constantvar.hobbiesTwo = val!;
                                                if (constantvar.hobbiesTwo ==
                                                    true) {
                                                  constantvar.hobbiesTwoVal =
                                                      "Basketball";
                                                  constantvar.hobbiesList
                                                      .add("Basketball");
                                                  print("done 2");
                                                  print(constantvar
                                                      .hobbiesTwoVal);
                                                } else {
                                                  constantvar.hobbiesTwoVal =
                                                      "";
                                                  constantvar.hobbiesList
                                                      .remove("Basketball");
                                                }
                                              });
                                            }),
                                        CheckboxListTile(
                                            title: const Text("Tennis"),
                                            subtitle:
                                                Text("Good for palying tennis"),
                                            value: constantvar.hobbiesThree,
                                            activeColor: Colors.blue,
                                            onChanged: (val) {
                                              setState(() {
                                                constantvar.hobbiesThree = val!;
                                                if (constantvar.hobbiesThree ==
                                                    true) {
                                                  constantvar.hobbiesThreeVal =
                                                      "Tennis";
                                                  constantvar.hobbiesList
                                                      .add("Tennis");
                                                  print("done 3");
                                                  print(constantvar
                                                      .hobbiesThreeVal);

                                                  print(
                                                      constantvar.hobbiesList);
                                                } else {
                                                  constantvar.hobbiesThreeVal =
                                                      "";
                                                  constantvar.hobbiesList
                                                      .remove("Tennis");
                                                }
                                              });
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            defaultButton(
                              width: MediaQuery.of(context).size.width * .9,
                              isUpperCase: true,
                              sizeText: 18,
                              background: Colors.grey[200]!,
                              radius: 10,
                              function: () {
                                if (cvForm.currentState!.validate()) {
                                  IdDataCubit.get(context)
                                      .idListData!
                                      .idList!
                                      .add(FirebaseAuth
                                          .instance.currentUser!.uid);

                                  CvControlCubit.get(context)
                                      .setCv(
                                          firstname: firstnameController.text,
                                          lastname: lastnameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          facebook: facebookController.text,
                                          address: addressController.text,
                                          faculty: facultyController.text,
                                          linkedin: linkedinController.text,
                                          gpa: selectGrade,
                                          //  degreeFinalProject: selectFinalProjectGPA as String,
                                          graduationYear:
                                              graduationYearController.text,
                                          positionCv: selectPositionCv,
                                          addressStNum:
                                              addressControllerStNum.text,
                                          addressStName:
                                              addressControllerStName.text,
                                          totalLikeCv: constantvar.totalLikeCv
                                              .toString(),
                                          startDate:
                                              startDateInputController.text,
                                          shareProject:
                                              shareProjectController.text,
                                          specialization: specialization,
                                          companyName:
                                              companyNameController.text,
                                          state: selectState,
                                          military: selectMilitary,
                                          pro: constantvar.selectedItem,
                                          work: constantvar.selectWork,
                                          isTrain: constantvar.trainAsec,
                                          listHobbies: constantvar.hobbiesList)
                                      .then((value) {
                                    constantvar.hobbiesOne = false;
                                    constantvar.hobbiesTwo = false;
                                    constantvar.hobbiesThree = false;
                                    constantvar.trainAsec = false;

                                    var snackBar = SnackBar(
                                      content: Text(
                                        "Your CV Uploading...",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    addIdToCheckCollection();
                                    clear();
                                  });
                                }
                              },
                              text: "Upload CV",
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
