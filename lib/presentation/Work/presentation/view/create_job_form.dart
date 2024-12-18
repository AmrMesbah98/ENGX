import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/Work/presentation/manager/get_work_cubit.dart';
import 'package:asec_application/presentation/login/customTextFormField.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../shared/components/components.dart';
import '../../../resources/color_manager.dart';

class CreateJobForm extends StatefulWidget {
  CreateJobForm({super.key});

  @override
  State<CreateJobForm> createState() => _CreateJobFormState();
}

class _CreateJobFormState extends State<CreateJobForm> {
  TextEditingController nameController = TextEditingController();

  TextEditingController codeController = TextEditingController();

  TextEditingController experienceController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController nameJobController = TextEditingController();

  TextEditingController specializationController = TextEditingController();

  TextEditingController possitionController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController jopTypeController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController skillsController = TextEditingController();

  GlobalKey<FormState> jobForm = GlobalKey();

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    experienceController.dispose();
    companyController.dispose();
    locationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nameJobController.dispose();
    possitionController.dispose();
    specializationController.dispose();
    timeController.dispose();
    jopTypeController.dispose();
    salaryController.dispose();
    descController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  clear() {
    nameController.clear();
    codeController.clear();
    experienceController.clear();
    companyController.clear();
    locationController.clear();
    phoneController.clear();
    emailController.clear();
    nameJobController.clear();
    possitionController.clear();
    specializationController.clear();
    timeController.clear();
    jopTypeController.clear();
    salaryController.clear();
    descController.clear();
    skillsController.clear();
  }

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  //date: todayDate()

  String specialization = "Electrical";
  String selectPositionCv = "Trainee Engineer";
  String selectTime = "Full-Time";
  String selectJobType = "In Company";
  String selectJobState = "Active";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Job',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: jobForm,
            child: Column(
              children: [
                //space
                SizedBox(
                  height: 15.h,
                ),
                //name and code
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //code
                    SizedBox(
                      width: 150.w,
                      child: CustomTextFormField(
                          label: "Code ",
                          icon: Icons.qr_code,
                          keyboardType: TextInputType.text,
                          controller: codeController,
                          secure: false,
                          maxLine: 1),
                    ),

                    //experience
                    SizedBox(
                      width: 180.w,
                      child: CustomTextFormField(
                          label: "Experience ",
                          icon: Icons.import_export,
                          keyboardType: TextInputType.text,
                          controller: experienceController,
                          secure: false,
                          maxLine: 1),
                    ),

                    //name
                    /*
                    SizedBox(
                      width: 180.w,
                      child: CustomTextFormField(
                          label: "Name ",
                          icon: Icons.person,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          secure: false,
                          maxLine: 1
                      ),
                    ),

                     */
                  ],
                ),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //company name
                CustomTextFormField(
                    label: "Company Name ",
                    icon: Icons.wordpress,
                    keyboardType: TextInputType.text,
                    controller: companyController,
                    secure: false,
                    maxLine: 1),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //job name
                CustomTextFormField(
                    label: "Job Name ",
                    icon: Icons.work_outline,
                    keyboardType: TextInputType.text,
                    controller: nameJobController,
                    secure: false,
                    maxLine: 1),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //location
                CustomTextFormField(
                    label: "Location ",
                    icon: Icons.location_on_outlined,
                    keyboardType: TextInputType.text,
                    controller: locationController,
                    secure: false,
                    maxLine: 1),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //phone
                CustomTextFormField(
                    label: "Phone ",
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    secure: false,
                    maxLine: 1),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //email
                CustomTextFormField(
                    label: "Email ",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    secure: false,
                    maxLine: 1),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //Specialization
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
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
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                      ),
                    ],
                  ),
                ),

                // CustomTextFormField(
                //     label: "Specification ",
                //     icon: Icons.wordpress,
                //     keyboardType: TextInputType.text,
                //     controller: specializationController,
                //     secure: false,
                //     maxLine: 1
                // ),

                //space
                SizedBox(
                  height: 5.h,
                ),
                //position
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      const Text("Position",
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
                                    "Position",
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
                            items: constantvar.positionCv
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
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
                                print(selectPositionCv);
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 200,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                      ),
                    ],
                  ),
                ),

                // CustomTextFormField(
                //     label: "Position ",
                //     icon: Icons.wordpress,
                //     keyboardType: TextInputType.text,
                //     controller: possitionController,
                //     secure: false,
                //     maxLine: 1
                // ),

                //space
                SizedBox(
                  height: 5.h,
                ),
                //time
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      const Text("Time",
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
                                    "Time",
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
                            items: constantvar.timeList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectTime,
                            onChanged: (value) {
                              setState(() {
                                selectTime = value as String;
                                constantvar.selectTrack = value;
                                print(selectTime);
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 200,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                      ),
                    ],
                  ),
                ),
                // CustomTextFormField(
                //     label: "Time (Fulltime or Parttime) ",
                //     icon: Icons.timelapse,
                //     keyboardType: TextInputType.text,
                //     controller: timeController,
                //     secure: false,
                //     maxLine: 1
                // ),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //jop tape
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      const Text("Job Type",
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
                                    "Job Type",
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
                            items: constantvar.jobTypeList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectJobType,
                            onChanged: (value) {
                              setState(() {
                                selectJobType = value as String;
                                constantvar.selectTrack = value;
                                print(selectJobType);
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 200,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                      ),
                    ],
                  ),
                ),

                // CustomTextFormField(
                //     label: "Jop Type (Remote Or In Company) ",
                //     icon: Icons.location_on_outlined,
                //     keyboardType: TextInputType.text,
                //     controller: jopTypeController,
                //     secure: false,
                //     maxLine: 1
                // ),

                //space
                SizedBox(
                  height: 5.h,
                ),
                //active
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      const Text("State of Job",
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
                                    "State of Job",
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
                            items: constantvar.stateJobList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectJobState,
                            onChanged: (value) {
                              setState(() {
                                selectJobState = value as String;
                                constantvar.selectTrack = value;
                                print(selectJobState);
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 200,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                      ),
                    ],
                  ),
                ),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //salary
                CustomTextFormField(
                    label: "Salary ",
                    icon: Icons.price_change,
                    keyboardType: TextInputType.text,
                    controller: salaryController,
                    secure: false,
                    maxLine: 1),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //desc
                CustomTextFormField(
                    label: "Description ",
                    icon: Icons.loupe,
                    keyboardType: TextInputType.text,
                    controller: descController,
                    secure: false,
                    maxLine: 3),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //skills
                CustomTextFormField(
                    label: "Skills ",
                    icon: Icons.add_task,
                    keyboardType: TextInputType.text,
                    controller: skillsController,
                    secure: false,
                    maxLine: 3),
                //space
                SizedBox(
                  height: 5.h,
                ),
                //button upload job
                defaultButton(
                  width: MediaQuery.of(context).size.width * .9,
                  isUpperCase: true,
                  sizeText: 18,
                  background: Colors.grey[200]!,
                  radius: 10,
                  function: () {
                    if (jobForm.currentState!.validate()) {
                      GetWorkCubit.get(context)
                          .addExternalJob(
                        code: codeController.text,
                        company: companyController.text,
                        date: todayDate(),
                        email: emailController.text,
                        location: locationController.text,
                        name: nameController.text,
                        nameJob: nameJobController.text,
                        phone: phoneController.text,
                        possition: selectPositionCv,
                        specialization: specialization,
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/asec-project.appspot.com/o/logo%20engx%2Fengx.png?alt=media&token=f12a89a8-22df-416d-a05a-2b0b533b3c61",
                        active: selectJobState,
                        desc: descController.text,
                        skills: skillsController.text,
                        time: selectTime,
                        jopType: selectJobType,
                        salary: salaryController.text,
                        experience: experienceController.text,
                      )
                          .then((value) {
                        clear();

                        var snackBar = SnackBar(
                          content: Text(
                            "Upload Job Done",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  },
                  text: "Upload Job",
                ),

                //space
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
