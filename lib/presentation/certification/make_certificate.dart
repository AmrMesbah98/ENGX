import 'package:asec_application/bloc/Certification/certification_cubit.dart';
import 'package:asec_application/presentation/certification/textformfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/new_customTextFormField_forRegister.dart';
import '../resources/color_manager.dart';

class MakeCertification extends StatefulWidget {
  MakeCertification({super.key});

  @override
  State<MakeCertification> createState() => _MakeCertificationState();
}

class _MakeCertificationState extends State<MakeCertification> {
  TextEditingController nameController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();

  List<String> gpaList = [
    "NONE",
    "GOOD",
    "VERY GOOD",
    "EXCELLENT",
  ];

  List<String> packageList = [
    "MEP",
    "BIM",
  ];

  List<String> codeCourses = [
    "ONLINE",
    "MIX",
  ];

  String selectGradeAb = "NONE";
  String selectCourses = "MEP";
  String selectCode = "ONLINE";
  int selectDegree = 70;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  var x = 70;

  List<int> num = [];

  numberFun() {
    for (x; x < 100; x++) {
      num.add(x);
    }
    return num;
  }

  @override
  void initState() {
    numberFun();
    print(num);
    super.initState();
  }

  clear() {
    nameController.clear();
    serialNumberController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    serialNumberController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> cirKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CertificationCubit, CertificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Make Certificate",
              style: TextStyle(color: Colors.black54),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: cirKey,
                child: Column(
                  children: [


                    SizedBox(height: MediaQuery.of(context).size.height * .11),
                    //name
                    NewCustomTextFormFieldForRegister(
                      label: 'Name',
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                        color: Color(0xff46454a),
                        size: 15,
                      ),
                      validator: 'Please Enter your Name',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    //serial Number
                    NewCustomTextFormFieldForRegister(
                      label: 'Serial Number max 4 digit',
                      controller: serialNumberController,
                      keyboardType: TextInputType.text,
                      maxLength: 4,
                      counterText: "",
                      prefixIcon: const Icon(
                        Icons.numbers_outlined,
                        color: Color(0xff46454a),
                        size: 15,
                      ),
                      validator: 'Please Enter your Serial Number',

                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    //degree
                    Row(
                      children: [
                        Text(
                          "Degree",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.Black,
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: num
                                  .map((item) =>
                                  DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: const Color(
                                            0xff46454a),
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                              value: selectDegree,
                              onChanged: (value) {
                                setState(() {
                                  selectDegree =
                                  value as int;
                                  selectDegree = value;
                                  print(selectDegree);
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
                                    color: (Colors.grey[50])!,
                                  ),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 13,
                                iconEnabledColor: Color(0xff46454a),
                                iconDisabledColor:
                                Color(0xff46454a),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                padding: null,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(14),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 8,
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty
                                      .all<double>(6),
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
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    //grade
                    Row(
                      children: [
                        Text(
                          "specialization",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
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
                                      "Grade",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.Black,
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
                                        fontSize: 13.sp,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: const Color(
                                            0xff46454a),
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                              value: selectGradeAb,
                              onChanged: (value) {
                                setState(() {
                                  selectGradeAb =
                                  value as String;
                                  selectGradeAb= value;
                                  print(selectGradeAb);
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
                                    color: (Colors.grey[50])!,
                                  ),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 13,
                                iconEnabledColor: Color(0xff46454a),
                                iconDisabledColor:
                                Color(0xff46454a),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                padding: null,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(14),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 8,
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty
                                      .all<double>(6),
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
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    //name package
                    Row(
                      children: [
                        Text(
                          "specialization",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
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
                                      "Name Package",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.Black,
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: packageList
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: const Color(
                                            0xff46454a),
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                              value: selectCourses,
                              onChanged: (value) {
                                setState(() {
                                  selectCourses =
                                  value as String;
                                  selectCourses = value;
                                  print(selectCourses);
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
                                    color: (Colors.grey[50])!,
                                  ),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 13,
                                iconEnabledColor: Color(0xff46454a),
                                iconDisabledColor:
                                Color(0xff46454a),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                padding: null,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(14),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 8,
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty
                                      .all<double>(6),
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
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Row(
                      children: [
                        Text(
                          "specialization",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
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
                                      "State Courses",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.Black,
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: codeCourses
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: const Color(
                                            0xff46454a),
                                      ),
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ))
                                  .toList(),
                              value: selectCode,
                              onChanged: (value) {
                                setState(() {
                                  selectCode =
                                  value as String;
                                  selectCode = value;
                                  print(selectCode);
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
                                    color: (Colors.grey[50])!,
                                  ),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 13,
                                iconEnabledColor: Color(0xff46454a),
                                iconDisabledColor:
                                Color(0xff46454a),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                padding: null,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(14),
                                  color: (Colors.grey[50])!,
                                ),
                                elevation: 8,
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty
                                      .all<double>(6),
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
                    SizedBox(height: MediaQuery.of(context).size.height * .04),
                    //button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (cirKey.currentState!.validate()) {
                            CertificationCubit.get(context)
                                .setCertificate(
                                id: FirebaseAuth.instance.currentUser!.uid,
                                name: nameController.text.toUpperCase(),
                                grade: selectGradeAb,
                                nameCourses: selectCourses,
                                stateCourses: selectCode,
                                degree: selectDegree,
                                serialNumber: serialNumberController.text)
                                .then((value) {
                              var snackBar = SnackBar(
                                content: Text(
                                  "Your Certificate will be reviewed",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              clear();

                              CertificationCubit.get(context).getCertificate();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 17,
                          backgroundColor: const Color(0xff1B98D2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(25)),
                          fixedSize: const Size(350, 50),
                        ),
                        child: const Text(
                          "Make Certification",
                        ),
                      ),
                    ),



                    /*
                    SizedBox(height: MediaQuery.of(context).size.height * .11),
                    CustomFieldCertification(
                      controller: nameController,
                      label: "Name",
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    CustomFieldCertification(
                      controller: serialNumberController,
                      label: "Serial Number max 4 digit",
                      maxLength: 4,
                      counterText: "",
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Text("Degree",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
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
                                        "Degree",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.Black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: num.map((item) => DropdownMenuItem<int>(
                                  value: item,
                                  child: Text(
                                    item.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList(),
                                value: selectDegree,
                                onChanged: (value) {
                                  setState(() {
                                    selectDegree = value as int;
                                    selectDegree = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 200,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    thickness:
                                    MaterialStateProperty.all<double>(6),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Text("Grade",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
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
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.Black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: gpaList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: selectGradeAb,
                                onChanged: (value) {
                                  setState(() {
                                    selectGradeAb = value as String;
                                    selectGradeAb = value;
                                    print(selectGradeAb);
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 200,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    thickness:
                                    MaterialStateProperty.all<double>(6),
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
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Text("Name Package",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
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
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.Black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: packageList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: selectCourses,
                                onChanged: (value) {
                                  setState(() {
                                    selectCourses = value as String;
                                    selectCourses = value;
                                    print(selectCourses);
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 200,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    thickness:
                                    MaterialStateProperty.all<double>(6),
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
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Text("State Courses",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
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
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.Black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: codeCourses
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: selectCode,
                                onChanged: (value) {
                                  setState(() {
                                    selectCode = value as String;
                                    selectCode = value;
                                    print(selectCode);
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 200,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    thickness:
                                    MaterialStateProperty.all<double>(6),
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    GestureDetector(
                      onTap: () {
                        if (cirKey.currentState!.validate()) {
                          CertificationCubit.get(context)
                              .setCertificate(
                              id: FirebaseAuth.instance.currentUser!.uid,
                              name: nameController.text.toUpperCase(),
                              grade: selectGradeAb,
                              nameCourses: selectCourses,
                              stateCourses: selectCode,
                              degree: selectDegree,
                              serialNumber: serialNumberController.text)
                              .then((value) {
                            var snackBar = SnackBar(
                              content: Text(
                                "Your Certificate will be reviewed",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            clear();

                            CertificationCubit.get(context).getCertificate();
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                              "Make Certification",
                              style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                            )),
                      ),
                    ),




                     */

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
