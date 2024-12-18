import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/CV/CV_DETAILS_PAGE.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slider_controller/slider_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/CV_Model.dart';


class CvDetailsViewTablet extends StatelessWidget {
  const CvDetailsViewTablet({super.key, required this.cvModel, required this.pro});

  final CvModel cvModel;
  final List pro;

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String validateDate() {
    if (cvModel.startDate! == "") {
      return "2024";
    } else {
      return cvModel.startDate!;
    }
  }

  String validateGradeYear() {
    if (cvModel.graduationYear! == "") {
      return "2024";
    } else {
      return cvModel.graduationYear!;
    }
  }

  showExperience(BuildContext ctx) {
    if (cvModel.work == false) {
      return Container();
    } else {
      return buildExperienceItemTablet(
        ctx: ctx,
        position: cvModel.positionCv!,
        companyName: cvModel.companyName!,
        from: validateDate(),
        nameProject: cvModel.shareProject!,
      );
    }
  }



  showHobbiesTablet() {
    if (cvModel.listHobbies!.isNotEmpty) {
      return Column(
        children: [
          buildItemCategory(Icons.deck_outlined, "Hobbies"),
          // Line
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Container(
            width: 200.w,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: cvModel.listHobbies!.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sports_soccer,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),

                          Text(capitalize(cvModel.listHobbies![index]),
                            style: TextStyle(
                                color: Colors.black54, fontSize: 8.sp),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * 1.1,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            "assets/images/person22.png",
                          ),
                          backgroundColor: Colors.white,
                        ),
                        // Space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        // contact us
                         Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Contact us",
                              style: TextStyle(color: Colors.black,fontSize: 8.sp),
                            )),
                        // Line
                        const Divider(
                          color: Colors.grey,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),

                        // ========================================================
                        buildItemContactUsTablet(
                            Icons.phone_android, cvModel.phone!, context),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        buildItemContactUsTablet(Icons.location_on_outlined,
                            cvModel.address!, context),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        buildItemContactUsTablet(
                            Icons.volunteer_activism, cvModel.state!, context),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        buildItemContactUsTablet(
                            Icons.verified_user, cvModel.military!, context),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        //   buildItemContactUs(Icons.email, cvModel.email!,context),
                        // ========================================================

                        // Space
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),

                        // pro Skills
                         Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "PRO SKILLS",
                              style: TextStyle(color: Colors.black,fontSize: 8.sp),
                            )),
                        // Line
                        const Divider(
                          color: Colors.grey,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),

                        // Skills
                        SizedBox(
                          child: ListView.builder(
                              itemCount: cvModel.pro!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.fiber_manual_record,
                                      size: 13,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 6),
                                      child: Text("${pro[index]}",
                                          style:  TextStyle(
                                              color: Colors.black,
                                              fontSize: 7.sp)),
                                    ),
                                  ],
                                );
                              }),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),

                        // Follow Me
                         Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Social Links",
                              style: TextStyle(color: Colors.black,fontSize: 8.sp),
                            )),
                        // Line
                        const Divider(
                          color: Colors.grey,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),

                        //========================================================

                        // facebook
                        GestureDetector(
                          onTap: () {
                            launchURL(urlLink: cvModel.facebook!);
                          },
                          child: buildItemFollowMeTablet(
                              cvModel.facebook!, Icons.facebook, context),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),
                        // linkedin
                        GestureDetector(
                          onTap: () {
                            launchURL(urlLink: cvModel.linkedin!);
                          },
                          child: buildItemFollowMeTablet(cvModel.linkedin!,
                              FontAwesomeIcons.linkedin, context),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),

                        //row power by engx
                        /*
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Power by ENGX",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.grey),),
                          ],
                        )

                         */

                        //========================================================
                      ],
                    ),
                  ),
                ),
              ),

              ///////////////////////////////////////////////////////////////////////////////////

              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    height: MediaQuery.of(context).size.height * 1.1,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // first name
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "${capitalize(cvModel.firstname!)} ${capitalize(cvModel.lastname!)}",
                              style: TextStyle(
                                  fontSize:
                                  16.sp,
                                  color: Colors.black54),
                            ),
                          ),

                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),
                          // postion
                          Text(
                            capitalize(cvModel.positionCv!),
                            style: TextStyle(
                                fontSize: 12.sp, color: Colors.black38),
                          ),

                          // Space
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),

                          // email
                          Text(
                            capitalize(cvModel.email!),
                            style: TextStyle(
                                fontSize:
                                10.sp,
                                color: Colors.black38),
                          ),

                          // Space
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),

                          // Label About us
                          buildItemCategory(Icons.deck_outlined, "About us"),
                          // Line
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),

                          // about us
                          Container(
                              width: MediaQuery.of(context).size.width ,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "my position is ${cvModel.positionCv}."
                                          .toTitleCase()

                                      // cvModel.aboutUs!.toTitleCase()
                                      ,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontSize: 10.sp,
                                          color: Colors.black),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "graduated in ${cvModel.graduationYear}."
                                          .toTitleCase()

                                      // cvModel.aboutUs!.toTitleCase()
                                      ,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontSize: 10.sp,
                                          color: Colors.black),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "my location is ${cvModel.address}."
                                          .toTitleCase()

                                      // cvModel.aboutUs!.toTitleCase()
                                      ,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontSize: 10.sp,
                                          color: Colors.black),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              )),

                          // Space
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),

                          // Label Education
                          buildItemCategory(Icons.deck_outlined, "Education"),
                          // Line
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),

                          // item Education
                          buildEducationItemTablet(
                            ctx: context,
                            specialization: cvModel.specialization!,
                            graduationYear: validateGradeYear(),
                            faculty: cvModel.faculty!,
                            coursesList: pro,
                            gpa: cvModel.gpa!,
                          ),

                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),

                          // Experience item

                          showExperience(context),

                          /*
                          buildExperienceItem(
                            ctx: context,
                            position: cvModel.positionCv!,
                            companyName: cvModel.companyName!,
                            from: cvModel.startDate!,
                            nameProject: cvModel.shareProject!,
                            to: cvModel.endDate!,
                          ),

                       */

                          // about us

                          /*


                               SizedBox(height: MediaQuery.of(context).size.height * .02),

                          // Label About us
                          buildItemCategory(Icons.deck_outlined, "Hobbies"),
                          // Line
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),

                           Container(
                              width: MediaQuery.of(context).size.width *1,

                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text(cvModel.hobbies!,style: TextStyle(fontSize: 12,color: Colors.black),textAlign: TextAlign.start,)),
                              )
                          ),




                           */

                          // Hobbies

                          showHobbiesTablet(),

                          // logo and power by
                          Center(
                            child: Column(
                              children: [
                                Image(
                                  image: const AssetImage(
                                      "assets/images/engx.png"),
                                  height: 75.h,
                                ),
                                Text(
                                  "Power by ENGX",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.sp,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildInfoItem(
      {required String name,
        required String email,
        required String phone,
        required String address,
        required String experienceYear}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name: $name"),
        const SizedBox(height: 4),
        Text("Email: $email"),
        const SizedBox(height: 4),
        Text("Phone: $phone"),
        const SizedBox(height: 4),
        Text("Address: $address"),
        const SizedBox(height: 4),
        Text("Experience Year: $experienceYear"),
      ],
    );
  }

  buildEducationItem(
      {required BuildContext ctx,
        required String faculty,
        required String graduationYear,
        required String specialization,
        required String gpa,
        required List coursesList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Faculty: $faculty",
          style: TextStyle(fontSize: 12.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Graduation Year: $graduationYear",
          style: TextStyle(fontSize: 12.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Specialization: $specialization",
          style: TextStyle(fontSize: 12.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Grade: $gpa",
          style: TextStyle(fontSize: 12.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
      ],
    );
  }


  buildEducationItemTablet(
      {required BuildContext ctx,
        required String faculty,
        required String graduationYear,
        required String specialization,
        required String gpa,
        required List coursesList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Faculty: $faculty",
          style: TextStyle(fontSize: 10.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Graduation Year: $graduationYear",
          style: TextStyle(fontSize: 10.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Specialization: $specialization",
          style: TextStyle(fontSize: 10.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
        Text(
          "Grade: $gpa",
          style: TextStyle(fontSize: 10.sp),
        ),
        SizedBox(height: MediaQuery.of(ctx).size.height * .01),
      ],
    );
  }


  buildExperienceItem(
      {required BuildContext ctx,
        required String companyName,
        required String from,
        required String to,
        required String position,
        required String nameProject}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Experience label
        buildItemCategory(Icons.deck_outlined, "Experience"),

        // Divider
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),

        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.apartment),
                Text(
                  companyName.toTitleCase(),
                  style: const TextStyle(
                      fontSize: 12, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                  "$from : Now ",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),

        Row(
          children: [
            const Icon(Icons.accessibility_new_outlined),
            Text(
              "Position : $position".toTitleCase(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),

        Row(
          children: [
            const Icon(Icons.assured_workload),
            Text(
              "Last Project: $nameProject".toTitleCase(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  buildExperienceItemTablet(
      {required BuildContext ctx,
        required String companyName,
        required String from,
        required String position,
        required String nameProject}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Experience label
        buildItemCategory(Icons.deck_outlined, "Experience"),

        // Divider
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),

        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.apartment),
                Text(
                  companyName.toTitleCase(),
                  style:  TextStyle(
                      fontSize: 8.sp, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                  "$from : Now ",
                  style:  TextStyle(fontSize: 8.sp),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 5.h,),

        Row(
          children: [
            const Icon(Icons.accessibility_new_outlined),
            Text(
              "Position : $position".toTitleCase(),
              style:  TextStyle(fontSize: 8.sp),
            ),
          ],
        ),

        SizedBox(height: 5.h,),

        Row(
          children: [
            const Icon(Icons.assured_workload),
            Text(
              "Last Project: $nameProject".toTitleCase(),
              style:  TextStyle(fontSize: 8.sp),
            ),
          ],
        ),

        SizedBox(height: 5.h,),
      ],
    );
  }

  buildItemCategory(IconData icon, String label) {
    return Row(
      children: [
        CircleAvatar(
            radius: 10,
            backgroundColor: Colors.black54,
            child: Icon(
              icon,
              color: Colors.white,
              size: 15,
            )),
        const SizedBox(width: 5),
        Text(
          capitalize(label),
          style: TextStyle(
              color: Colors.red[500],
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  buildItemFollowMe(String details, IconData icon, BuildContext ctx) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Text(
              details,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: MediaQuery.of(ctx).size.width * .027,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  buildItemFollowMeTablet(String details, IconData icon, BuildContext ctx) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Text(
              details,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 8.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  buildItemContactUs(IconData icon, String details, BuildContext ctx) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 20,
        ),
        SizedBox(width: MediaQuery.of(ctx).size.width * .01),
        Expanded(
          child: Text(
            details,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(ctx).size.width * .029),
          ),
        )
      ],
    );
  }

  buildItemContactUsTablet(IconData icon, String details, BuildContext ctx) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 20,
        ),
        SizedBox(width: MediaQuery.of(ctx).size.width * .01),
        Expanded(
          child: Text(
            details,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp),
          ),
        )
      ],
    );
  }

  buildItemPerson(
      IconData icon, String details, String label, BuildContext ctx) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          label,
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white70,
              fontSize: MediaQuery.of(ctx).size.width * .029),
        ),
        Text(
          details,
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white70,
              fontSize: MediaQuery.of(ctx).size.width * .029),
        ),
      ],
    );
  }

  launchURL({required String urlLink}) async {
    final Uri url = Uri.parse(urlLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }
}




