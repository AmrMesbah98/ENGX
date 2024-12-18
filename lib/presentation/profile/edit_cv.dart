import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/model/get_cv.dart';
import 'package:asec_application/presentation/profile/widget/TextFormField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../Widget/drop_down.dart';
import '../../bloc/CV/cv_control_cubit.dart';
import '../../shared/components/components.dart';
import '../resources/color_manager.dart';

class EditCv extends StatefulWidget {
  const EditCv({super.key, required this.cvModelEdit});

  final GetCvModel cvModelEdit;

  @override
  State<EditCv> createState() => _EditCvState();
}

class _EditCvState extends State<EditCv> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController shareProjectController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController graduationYearController = TextEditingController();
  TextEditingController startDateInputController = TextEditingController();
  TextEditingController endDateInputController = TextEditingController();
  TextEditingController experienceYearController = TextEditingController();
  TextEditingController aboutUsController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();

  List<String> gradeList = [
    "None",
    "Mufful",
    "Good",
    "VeryGood",
    "Excellent",
  ];

  List<String> gpaList = [
    "100",
    "99",
    "98",
    "97",
    "96",
    "95",
    "94",
    "93",
    "92",
    "91",
    "90",
    "89",
    "88",
    "87",
    "86",
    "85",
    "84",
    "83",
    "82",
    "81",
    "80",
    "79",
    "79",
    "79",
    "79",
    "79",
    "79",
    "79",
    "79",
  ];

  List<String> stateList = [
    "Single",
    "Married",
    "Engaged",
  ];

  List<String> militaryList = [
    "Done",
    "Exemption",
    "delay",
  ];

  double selectFinalProjectGPA = 50.0;
  String selectgpa = "90";
  String selectGrade = "None";
  String specialization = "Mechanical";
  String codeCountry = "DZ";
  String selectState = "Single";
  String selectMilitary = "Done";
  String selectPositionCv = "Trainee Engineer";
  GlobalKey<FormState> cvEdit = GlobalKey();

  clear() {
    firstnameController.clear();
    lastnameController.clear();
    phoneController.clear();
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CvControlCubit, CvControlState>(
      listener: (context, state) {},
      builder: (context, state) {
        firstnameController.text =
            CvControlCubit.get(context).cvCubit!.firstname!;
        lastnameController.text =
            CvControlCubit.get(context).cvCubit!.lastname!;
        emailController.text = CvControlCubit.get(context).cvCubit!.email!;
        phoneController.text = CvControlCubit.get(context).cvCubit!.phone!;
        addressController.text = CvControlCubit.get(context).cvCubit!.address!;
        companyNameController.text =
            CvControlCubit.get(context).cvCubit!.companyName!;
        facultyController.text = CvControlCubit.get(context).cvCubit!.faculty!;
        linkedinController.text =
            CvControlCubit.get(context).cvCubit!.linkedin!;
        facebookController.text =
            CvControlCubit.get(context).cvCubit!.facebook!;
        shareProjectController.text =
            CvControlCubit.get(context).cvCubit!.shareProject!;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Edit CV",
              style: TextStyle(color: Colors.black54),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            backgroundColor: Colors.white54,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: cvEdit,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextCv(
                                    hint: "First Name",
                                    controller: firstnameController),
                              ),
                              Expanded(
                                child: CustomTextCv(
                                    hint: "Last Name",
                                    controller: lastnameController),
                              ),
                            ],
                          ),
                          CustomTextCv(
                              hint: "Email", controller: emailController),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: CountryCodePicker(
                                  onChanged: (element) {
                                    debugPrint(element.code.toString());
                                    setState(() {
                                      codeCountry = element.toLongString();
                                    });
                                  },
                                  initialSelection: 'DZ',
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
                                  child: CustomTextCv(
                                      hint: "Phone",
                                      controller: phoneController)),
                            ],
                          ),
                          CustomTextCv(
                              hint: "Address", controller: addressController),
                          CustomTextCv(
                              hint: "University",
                              controller: facultyController),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            child: Row(
                              children: [
                                const Text("Specialization",
                                    style: TextStyle(
                                      fontSize: 19,
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
                                              "Specialization",
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
                                      items: constantvar.specializationList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: specialization,
                                      onChanged: (value) {
                                        setState(() {
                                          specialization = value as String;
                                          constantvar.selectTrack = value;
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: (Colors.grey[100])!,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            child: Row(
                              children: [
                                const Text("Final Degree",
                                    style: TextStyle(
                                      fontSize: 19,
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
                                              "Final Degree",
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
                                      items: gradeList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: (Colors.grey[100])!,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                const Text("GPA",
                                    style: TextStyle(
                                      fontSize: 19,
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
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: selectgpa,
                                      onChanged: (value) {
                                        setState(() {
                                          selectgpa = value as String;
                                          selectgpa = value;
                                          print(selectgpa);
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: (Colors.grey[100])!,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                const Text("Relationship",
                                    style: TextStyle(
                                      fontSize: 19,
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
                                      items: stateList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: (Colors.grey[100])!,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                const Text("Military",
                                    style: TextStyle(
                                      fontSize: 19,
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
                                      items: militaryList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: selectMilitary,
                                      onChanged: (value) {
                                        setState(() {
                                          selectMilitary = value as String;
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
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: (Colors.grey[100])!,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
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

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            child: Row(
                              children: [
                                const Text("Final degree",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const Spacer(),
                                Slider(
                                    max: 100,
                                    min: 0,
                                    activeColor: Colors.blue[200],
                                    inactiveColor: Colors.grey[200],
                                    value: selectFinalProjectGPA,
                                    label: '${selectFinalProjectGPA.round()}',
                                    onChanged: (val) {
                                      setState(() {
                                        selectFinalProjectGPA = val;
                                      });
                                    }),
                                Text("${selectFinalProjectGPA.round()}")
                              ],
                            ),
                          ),

                          CustomTextCv(
                              hint: "FaceBook", controller: linkedinController),
                          CustomTextCv(
                              hint: "LinkedIn", controller: facebookController),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                const Text("Graduation Year",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  height: 40,
                                  child: Center(
                                    child: TextField(
                                      controller: graduationYearController,
                                      //editing controller of this TextField
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons
                                            .calendar_today), //icon of text field
                                      ),
                                      readOnly: true,
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2030));

                                        if (pickedDate != null) {
                                          print(pickedDate);
                                          //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            graduationYearController.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {}
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Personal Info",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 22),
                                )
                              ]),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          // about us
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "About us",
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                            ),
                            controller: aboutUsController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter some info";
                              }
                            },
                            maxLines: 4,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          // hobbies
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Hobbies",
                              labelStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                            ),
                            controller: hobbiesController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter some info";
                              }
                            },
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                          CustomTextCv(
                              hint: "company Name",
                              controller: companyNameController),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              const Text(
                                "From",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .3,
                                height: 70,
                                child: Center(
                                  child: TextField(
                                    controller: startDateInputController,
                                    //editing controller of this TextField
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        //icon of text field
                                        labelText: "Date",
                                        labelStyle: TextStyle(fontSize: 25)),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          currentDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
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
                              const Text(
                                "To",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .3,
                                height: 70,
                                child: Center(
                                  child: TextField(
                                    controller: endDateInputController,
                                    //editing controller of this TextField
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        //icon of text field
                                        labelText: "Date",
                                        labelStyle: TextStyle(fontSize: 25)),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2030));

                                      if (pickedDate != null) {
                                        print(pickedDate);
                                        //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          endDateInputController.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),
                          Row(
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
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),
                          CustomTextCv(
                              hint: "share Project",
                              controller: shareProjectController),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  defaultButton(
                    width: MediaQuery.of(context).size.width * .9,
                    isUpperCase: true,
                    sizeText: 18,
                    background: Colors.blue[200]!,
                    radius: 10,
                    function: () {
                      if (cvEdit.currentState!.validate()) {
                        CvControlCubit.get(context)
                            .editCv(
                                firstname: firstnameController.text,
                                lastname: lastnameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                facebook: facebookController.text,
                                address: addressController.text,
                                faculty: facultyController.text,
                                linkedin: linkedinController.text,
                                gpa: selectGrade,
                                // degreeFinalProject: selectFinalProjectGPA   ,
                                graduationYear: graduationYearController.text,
                                state: selectState,
                                military: selectMilitary,
                                positionCv: selectPositionCv,
                                totalLikeCv: constantvar.totalLikeCv.toString(),
                                startDate: startDateInputController.text,
                                shareProject: shareProjectController.text,
                                specialization: specialization,
                                companyName: companyNameController.text,
                                pro: constantvar.selectedItem)
                            .then((value) {
                          // CvControlCubit.get(context).getPersonalCv();

                          var snackBar = SnackBar(
                            content: Text(
                              "Your CV Editing...",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    text: "Edit Your CV",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
