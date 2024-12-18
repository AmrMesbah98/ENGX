// import 'package:asec_application/Constant/constant.dart';
// import 'package:asec_application/presentation/CV/CV_DETAILS_PAGE.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../Tablet/CV_details_tablet.dart';
//
// class CvMultiDetails extends StatelessWidget {
//   CvMultiDetails({
//     super.key,
//     required this.phone,
//     required this.address,
//     required this.state,
//     required this.military,
//     required this.positionCv,
//     required this.aboutUs,
//     required this.companyName,
//     required this.email,
//     required this.faculty,
//     required this.gpa,
//     required this.firstname,
//     required this.lastname,
//     required this.graduationYear,
//     required this.hobbies,
//     required this.facebook,
//     required this.linkedin,
//     required this.shareProject,
//     required this.specialization,
//     required this.work,
//     required this.pro,
//     required this.startDate,
//     required this.endDate,
//     required this.hobbiesList
//   });
//
//   String phone;
//   String address;
//   String state;
//   String military;
//   String positionCv;
//   String aboutUs;
//   String companyName;
//   String email;
//   String faculty;
//   String gpa;
//   String firstname;
//   String lastname;
//   String graduationYear;
//   String hobbies;
//   String facebook;
//   String linkedin;
//   String shareProject;
//   String specialization;
//   bool work;
//   List pro;
//   String startDate;
//   String endDate;
//   List hobbiesList;
//
//
//   String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
//
//
//   String validateDate()
//   {
//     if(startDate == "")
//     {
//       return "2024";
//     }
//     else
//     {
//       return startDate;
//     }
//   }
//
//
//   String validateGradeYear()
//   {
//     if(graduationYear == "")
//     {
//       return "2024";
//     }
//     else
//     {
//       return graduationYear;
//     }
//   }
//
//
//
//   showExperience(BuildContext ctx) {
//     if (work == false) {
//       return Container();
//     } else {
//       return buildExperienceItem(
//         ctx: ctx,
//         position: positionCv,
//         companyName: companyName,
//         from: validateDate(),
//         nameProject: shareProject,
//         to: endDate,
//       );
//     }
//   }
//
//
//   showHobbies(BuildContext ctx) {
//     if (hobbies.isEmpty) {
//       return Container();
//     } else {
//       return Column(
//         children: [
//           buildItemCategory(Icons.deck_outlined, "Hobbies"),
//           // Line
//           const Divider(
//             color: Colors.grey,
//             thickness: 1,
//           ),
//
//           // Hobbies
//           Container(
//               width: MediaQuery.of(ctx).size.width *1,
//
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(24)
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(child: Text(hobbies,style: const TextStyle(fontSize: 12,color: Colors.black),textAlign: TextAlign.start,)),
//               )
//           ),
//         ],
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     //   statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
//     // ));
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       body: LayoutBuilder(
//         builder: (context, constrain){
//
//           if (constrain.maxWidth < 600){
//
//             return SafeArea(
//               child: Column(
//
//                 children: [
//
//                   SizedBox(height: 10.h),
//
//
//                   // first section of cv
//
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                     child: Container(
//                       decoration:  BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: const BorderRadius.only(
//                             bottomRight: Radius.circular(10),
//                             bottomLeft: Radius.circular(40),
//                             topLeft: Radius.circular(40),
//                             topRight: Radius.circular(10),
//                           )
//                       ),
//                       child:  Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 40,
//                             backgroundImage: AssetImage(
//                               "assets/images/person22.png",
//                             ),
//                             backgroundColor: Colors.white,
//                           ),
//
//                           SizedBox(width: 50.w),
//
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // Name
//                               Text(
//                                 "${capitalize(firstname)} ${capitalize(lastname)}",
//                                 style: TextStyle(
//                                     fontSize:
//                                     MediaQuery.of(context).size.width * .05,
//                                     color: Colors.black54),
//                               ),
//                               // position
//                               Text(
//                                 capitalize(positionCv),
//                                 style: TextStyle(
//                                     fontSize: 15.sp, color: Colors.black38),
//                               ),
//
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//
//                   //space
//                   SizedBox(height: 30.h),
//
//                   // contact us text
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child:  Row(
//                       children: [
//                         const Icon(Icons.contacts, size: 20, color: Colors.grey,),
//                         SizedBox(width: 5.w),
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "CONTACT US",
//                               style: TextStyle(color: Colors.red, fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   // Line
//                   const Divider(
//
//                     color: Colors.grey,
//                     indent: 0,
//                     thickness: 1,
//                     endIndent: 290,
//
//                   ),
//
//
//
//                   // details of contact us
//                   Column(
//                     children: [
//                       // phone and state
//                       Row(
//                         children: [
//
//                           const Icon(Icons.phone_android,size: 20),
//                           SizedBox(width: 7.w),
//                           Text(phone),
//
//                           SizedBox(width: 150.w),
//
//                           const Icon(Icons.volunteer_activism_outlined,size: 20),
//                           SizedBox(width: 7.w),
//                           Text(state),
//
//
//
//
//                         ],
//                       ),
//
//                       SizedBox(height: 10.h),
//
//                       // email and military
//                       Row(
//
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//
//                           // email
//                           buildItemContactUs(Icons.email_outlined,
//                               email, context),
//
//
//
//                           // military
//
//                           Padding(
//                             padding: EdgeInsets.only(right: 69.w),
//                             child: buildItemContactUs(
//                                 Icons.verified_user_outlined, military, context),
//
//
//
//                           ),
//
//                         ],
//                       ),
//
//                     ],
//                   ),
//
//
//                   SizedBox(height: 20.h),
//
//
//
//                   // Education text
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child:  Row(
//                       children: [
//                         const Icon(Icons.deck_outlined, size: 20, color: Colors.grey,),
//                         SizedBox(width: 5.w),
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "EDUCATION",
//                               style: TextStyle(color: Colors.red, fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   // Line
//                   const Divider(
//
//                     color: Colors.grey,
//                     indent: 0,
//                     thickness: 1,
//                     endIndent: 290,
//
//                   ),
//
//                   // details of Education
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child: Column(
//                       children: [
//
//                         // university
//                         Row(
//                           children: [
//                             const Icon(Icons.school),
//                             SizedBox(width: 5.w),
//                             Text("University of ${faculty}   |   ${validateGradeYear()}",style: TextStyle(fontSize: 13.sp),),
//                           ],
//                         ),
//
//                         // specialization
//                         Row(
//                           children: [
//                             const Icon(Icons.engineering),
//                             SizedBox(width: 5.w),
//                             Text("$specialization Engineer",style: TextStyle(fontSize: 13.sp),),
//                           ],
//                         ),
//
//
//                         // Grade
//                         Row(
//                           children: [
//                             const Icon(Icons.workspace_premium),
//                             SizedBox(width: 5.w),
//                             Text("Grade is $gpa",style: TextStyle(fontSize: 13.sp),),
//                           ],
//                         ),
//
//
//
//
//                       ],
//                     ),
//                   ),
//
//
//
//
//                   SizedBox(height: 15.h),
//
//
//
//                   // ProSkill text
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child:  Row(
//                       children: [
//                         const Icon(Icons.token, size: 20, color: Colors.grey,),
//                         SizedBox(width: 5.w),
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "PRO SKILLS",
//                               style: TextStyle(color: Colors.red, fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   // Line
//                   const Divider(
//
//                     color: Colors.grey,
//                     indent: 0,
//                     thickness: 1,
//                     endIndent: 290,
//
//                   ),
//
//
//
//                   // skills
//
//                   SizedBox(
//                     child: ListView.builder(
//                         itemCount: pro.length,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         physics: const BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Row(
//                             children: [
//                               const Icon(
//                                 Icons.fiber_manual_record,
//                                 size: 13,
//                                 color: Colors.grey,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 6, vertical: 6),
//                                 child: Text("${pro[index]}",
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 12)),
//                               ),
//                             ],
//                           );
//                         }),
//                   ),
//
//
//
//                   SizedBox(height: 15.h),
//
//
//                   // Experience text
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child:  Row(
//                       children: [
//                         const Icon(Icons.token, size: 20, color: Colors.grey,),
//                         SizedBox(width: 5.w),
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "EXPERIENCE",
//                               style: TextStyle(color: Colors.red, fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   // Line
//                   const Divider(
//
//                     color: Colors.grey,
//                     indent: 0,
//                     thickness: 1,
//                     endIndent: 290,
//
//                   ),
//
//
//
//                   showExperience(context),
//
//
//
//
//
//
//                   SizedBox(height: 16.h),
//
//
//                   // Social Links
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child:  Row(
//                       children: [
//                         const Icon(Icons.token, size: 20, color: Colors.grey,),
//                         SizedBox(width: 5.w),
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "Social Links",
//                               style: TextStyle(color: Colors.red, fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   // Line
//                   const Divider(
//
//                     color: Colors.grey,
//                     indent: 0,
//                     thickness: 1,
//                     endIndent: 290,
//
//                   ),
//
//
//
//                   // Hobbies text
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child:  Row(
//                       children: [
//                         const Icon(Icons.favorite_border, size: 20, color: Colors.grey,),
//                         SizedBox(width: 5.w),
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "Hobbies",
//                               style: TextStyle(color: Colors.red, fontSize: 15.sp),
//                             )),
//                       ],
//                     ),
//                   ),
//                   // Line
//                   const Divider(
//
//                     color: Colors.grey,
//                     indent: 0,
//                     thickness: 1,
//                     endIndent: 290,
//
//                   ),
//
//                   // hobbies details
//
//
//                   SizedBox(
//                     height: 20.h,
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: hobbiesList.length,
//                         itemBuilder: (context, index){
//                           return Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                 child: Row(
//                                   children: [
//                                     const Icon(Icons.favorite_border,size: 18,),
//                                     SizedBox(width: 10.w),
//                                     Text(hobbiesList[index]),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         }
//                     ),
//                   ),
//
//
//
//                   SizedBox(height: 16.h),
//
//
//
//
//
//
//
//
//                   // social details
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // facebook
//                       GestureDetector(
//                         onTap: () {
//                           launchURL(urlLink: facebook);
//                         },
//                         child: buildItemFollowMe(
//                             "FaceBook Account", Icons.facebook, context),
//                       ),
//
//
//                       // linkedin
//                       Padding(
//                         padding: const EdgeInsets.only(right: 47),
//                         child: GestureDetector(
//                           onTap: () {
//                             launchURL(urlLink: linkedin);
//                           },
//                           child: buildItemFollowMe("linkedin Account ",
//                               FontAwesomeIcons.linkedin, context),
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//
//                   SizedBox(height: 50.h),
//
//                   // power by
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200]
//                     ),
//
//                     width: MediaQuery.of(context).size.width,
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Center(child: Text("Power by ENGX")),
//                         Image(image: AssetImage("assets/images/ASEC.png"),width: 30,height: 30,),
//
//                       ],
//                     ),
//                   )
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//                   /*
//
//                     Row(
//                       children: [
//
//                         Container(
//                           width: MediaQuery.of(context).size.width * .4,
//                           height: MediaQuery.of(context).size.height * 1.1,
//                           decoration: const BoxDecoration(color: Colors.white),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 6),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 30.h),
//                                   const CircleAvatar(
//                                     radius: 40,
//                                     backgroundImage: AssetImage(
//                                       "assets/images/person22.png",
//                                     ),
//                                     backgroundColor: Colors.white,
//                                   ),
//                                   // Space
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .01),
//                                   // contact us
//                                   const Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         "Contact us",
//                                         style: TextStyle(color: Colors.black),
//                                       )),
//                                   // Line
//                                   const Divider(
//                                     color: Colors.grey,
//                                     indent: 0,
//                                     thickness: 1,
//                                     endIndent: 0,
//                                   ),
//
//                                   // ========================================================
//                                   buildItemContactUs(
//                                       Icons.phone_android, cvModel.phone!, context),
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .01),
//                                   buildItemContactUs(Icons.location_on_outlined,
//                                       cvModel.address!, context),
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .01),
//                                   buildItemContactUs(
//                                       Icons.volunteer_activism, cvModel.state!, context),
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .01),
//                                   buildItemContactUs(
//                                       Icons.verified_user, cvModel.military!, context),
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .01),
//                                   //   buildItemContactUs(Icons.email, cvModel.email!,context),
//                                   // ========================================================
//
//                                   // Space
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .02),
//
//                                   // pro Skills
//                                   const Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         "PRO SKILLS",
//                                         style: TextStyle(color: Colors.black),
//                                       )),
//                                   // Line
//                                   const Divider(
//                                     color: Colors.grey,
//                                     indent: 0,
//                                     thickness: 1,
//                                     endIndent: 0,
//                                   ),
//
//                                   // Skills
//                                   SizedBox(
//                                     child: ListView.builder(
//                                         itemCount: cvModel.pro!.length,
//                                         shrinkWrap: true,
//                                         scrollDirection: Axis.vertical,
//                                         physics: const BouncingScrollPhysics(),
//                                         itemBuilder: (context, index) {
//                                           return Row(
//                                             children: [
//                                               const Icon(
//                                                 Icons.fiber_manual_record,
//                                                 size: 13,
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 6, vertical: 6),
//                                                 child: Text("${pro[index]}",
//                                                     style: const TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 12)),
//                                               ),
//                                             ],
//                                           );
//                                         }),
//                                   ),
//
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .02),
//
//                                   // Follow Me
//                                   const Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         "Social Links",
//                                         style: TextStyle(color: Colors.black),
//                                       )),
//                                   // Line
//                                   const Divider(
//                                     color: Colors.grey,
//                                     indent: 0,
//                                     thickness: 1,
//                                     endIndent: 0,
//                                   ),
//
//                                   //========================================================
//
//                                   // facebook
//                                   GestureDetector(
//                                     onTap: () {
//                                       launchURL(urlLink: cvModel.facebook!);
//                                     },
//                                     child: buildItemFollowMe(
//                                         cvModel.facebook!, Icons.facebook, context),
//                                   ),
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .02),
//                                   // linkedin
//                                   GestureDetector(
//                                     onTap: () {
//                                       launchURL(urlLink: cvModel.linkedin!);
//                                     },
//                                     child: buildItemFollowMe(cvModel.linkedin!,
//                                         FontAwesomeIcons.linkedin, context),
//                                   ),
//                                   SizedBox(
//                                       height: MediaQuery.of(context).size.height * .02),
//
//                                   //row power by engx
//                                   /*
//                            Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Power by ENGX",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.grey),),
//                             ],
//                           )
//
//                            */
//
//                                   //========================================================
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         ///////////////////////////////////////////////////////////////////////////////////
//
//                         Container(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: SizedBox(
//                               width: MediaQuery.of(context).size.width * .55,
//                               height: MediaQuery.of(context).size.height * 1.1,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     // first name
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 20),
//                                       child: Text(
//                                         "${capitalize(cvModel.firstname!)} ${capitalize(cvModel.lastname!)}",
//                                         style: TextStyle(
//                                             fontSize:
//                                             MediaQuery.of(context).size.width * .05,
//                                             color: Colors.black54),
//                                       ),
//                                     ),
//
//                                     SizedBox(
//                                         height: MediaQuery.of(context).size.height * .01),
//                                     // postion
//                                     Text(
//                                       capitalize(cvModel.positionCv!),
//                                       style: TextStyle(
//                                           fontSize: 15.sp, color: Colors.black38),
//                                     ),
//
//                                     // Space
//                                     SizedBox(
//                                         height: MediaQuery.of(context).size.height * .01),
//
//                                     // email
//                                     Text(
//                                       capitalize(cvModel.email!),
//                                       style: TextStyle(
//                                           fontSize:
//                                           MediaQuery.of(context).size.width * .024,
//                                           color: Colors.black38),
//                                     ),
//
//                                     // Space
//                                     SizedBox(
//                                         height: MediaQuery.of(context).size.height * .02),
//
//                                     // Label About us
//                                     buildItemCategory(Icons.deck_outlined, "About us"),
//                                     // Line
//                                     const Divider(
//                                       color: Colors.grey,
//                                       thickness: 1,
//                                     ),
//
//                                     // about us
//                                     Container(
//                                         width: MediaQuery.of(context).size.width * .9,
//                                         decoration: BoxDecoration(),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: Center(
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "my position is ${cvModel.positionCv}."
//                                                         .toTitleCase()
//
//                                                     // cvModel.aboutUs!.toTitleCase()
//                                                     ,
//                                                     style: TextStyle(
//                                                         height: 1.4,
//                                                         fontSize: 12.sp,
//                                                         color: Colors.black),
//                                                     textAlign: TextAlign.start,
//                                                   ),
//                                                   Text(
//                                                     "graduated in ${cvModel.graduationYear}."
//                                                         .toTitleCase()
//
//                                                     // cvModel.aboutUs!.toTitleCase()
//                                                     ,
//                                                     style: TextStyle(
//                                                         height: 1.4,
//                                                         fontSize: 12.sp,
//                                                         color: Colors.black),
//                                                     textAlign: TextAlign.start,
//                                                   ),
//                                                   Text(
//                                                     "my location is ${cvModel.address}."
//                                                         .toTitleCase()
//
//                                                     // cvModel.aboutUs!.toTitleCase()
//                                                     ,
//                                                     style: TextStyle(
//                                                         height: 1.4,
//                                                         fontSize: 12.sp,
//                                                         color: Colors.black),
//                                                     textAlign: TextAlign.start,
//                                                   ),
//                                                 ],
//                                               )),
//                                         )),
//
//                                     // Space
//                                     SizedBox(
//                                         height: MediaQuery.of(context).size.height * .02),
//
//                                     // Label Education
//                                     buildItemCategory(Icons.deck_outlined, "Education"),
//                                     // Line
//                                     const Divider(
//                                       color: Colors.grey,
//                                       thickness: 1,
//                                     ),
//
//                                     // item Education
//                                     buildEducationItem(
//                                       ctx: context,
//                                       specialization: cvModel.specialization!,
//                                       graduationYear: validateGradeYear(),
//                                       faculty: cvModel.faculty!,
//                                       coursesList: pro,
//                                       gpa: cvModel.gpa!,
//                                     ),
//
//                                     SizedBox(
//                                         height: MediaQuery.of(context).size.height * .02),
//
//                                     // Experience item
//
//                                     showExperience(context),
//
//                                     /*
//                             buildExperienceItem(
//                               ctx: context,
//                               position: cvModel.positionCv!,
//                               companyName: cvModel.companyName!,
//                               from: cvModel.startDate!,
//                               nameProject: cvModel.shareProject!,
//                               to: cvModel.endDate!,
//                             ),
//
//                          */
//
//                                     // about us
//
//                                     /*
//
//
//                                  SizedBox(height: MediaQuery.of(context).size.height * .02),
//
//                             // Label About us
//                             buildItemCategory(Icons.deck_outlined, "Hobbies"),
//                             // Line
//                             const Divider(
//                               color: Colors.grey,
//                               thickness: 1,
//                             ),
//
//                              Container(
//                                 width: MediaQuery.of(context).size.width *1,
//
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey),
//                                     borderRadius: BorderRadius.circular(24)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(child: Text(cvModel.hobbies!,style: TextStyle(fontSize: 12,color: Colors.black),textAlign: TextAlign.start,)),
//                                 )
//                             ),
//
//
//
//
//                              */
//
//                                     // Hobbies
//
//                                     showHobbies(),
//
//                                     // logo and power by
//                                     Center(
//                                       child: Column(
//                                         children: [
//                                           Image(
//                                             image: const AssetImage(
//                                                 "assets/images/engx.png"),
//                                             height: 75.h,
//                                           ),
//                                           Text(
//                                             "Power by ENGX",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 13.sp,
//                                                 color: Colors.grey),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                      */
//
//
//
//
//
//                 ],
//               ),
//             );
//
//           }
//           else if (constrain.maxWidth < 900) {
//             return  Center(child: CvDetailsViewTablet(
//               cvModel: constantvar.cvModel!,
//               pro: constantvar.cvModel!
//                   .pro!,
//             )
//             );
//           }
//
//           else {
//             return const Center(child: Text("Desktop"));
//           }
//         },
//         /*
//            child: SafeArea(
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Row(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * .4,
//                   height: MediaQuery.of(context).size.height*1.1,
//                   decoration: const BoxDecoration(color: Colors.white),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 30.h),
//                           const CircleAvatar(
//                             radius: 40,
//                             backgroundImage:
//                             AssetImage("assets/images/person22.png"),
//                             backgroundColor: Colors.white,
//                           ),
//                           // Space
//                           SizedBox(height: MediaQuery.of(context).size.height*.01),
//                           // contact us
//                           const Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 "Contact us",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                           // Line
//                           const Divider(
//                             color: Colors.grey,
//                             indent: 0,
//                             thickness: 1,
//                             endIndent: 0,
//                           ),
//
//                           // ========================================================
//                           buildItemContactUs(Icons.phone_android, phone,context),
//                           SizedBox(height: MediaQuery.of(context).size.height * .01),
//                           buildItemContactUs( Icons.location_on_outlined, address,context),
//                           SizedBox(height: MediaQuery.of(context).size.height * .01),
//                           buildItemContactUs( Icons.volunteer_activism, state,context),
//                           SizedBox(height: MediaQuery.of(context).size.height * .01),
//                           buildItemContactUs( Icons.verified_user, military,context),
//                           SizedBox(height: MediaQuery.of(context).size.height * .01),
//                           //   buildItemContactUs(Icons.email, cvModel.email!,context),
//                           // ========================================================
//
//                           // Space
//                           SizedBox(height: MediaQuery.of(context).size.height*.02),
//
//                           // pro Skills
//                           const Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 "PRO SKILLS",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                           // Line
//                           const Divider(
//                             color: Colors.grey,
//                             indent: 0,
//                             thickness: 1,
//                             endIndent: 0,
//                           ),
//
//                           // Skills
//                           SizedBox(
//                             child: ListView.builder(
//                                 itemCount: pro.length,
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.vertical,
//                                 physics: const BouncingScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   return Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.fiber_manual_record,
//                                         size: 13,
//                                         color: Colors.grey,
//                                       ),
//                                       Padding(padding:
//                                       const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
//
//                                         child: Text("${pro[index]}",style:  const TextStyle(color: Colors.black, fontSize:12)),
//
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//
//                           SizedBox(height: MediaQuery.of(context).size.height*.02),
//
//
//                           // Follow Me
//                           const Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 "Social Links",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                           // Line
//                           const Divider(
//                             color: Colors.grey,
//                             indent: 0,
//                             thickness: 1,
//                             endIndent: 0,
//                           ),
//
//
//                           //========================================================
//
//                           GestureDetector(
//                             onTap: (){
//                               launchURL(urlLink: facebook);
//                             },
//                             child:  buildItemFollowMe( facebook,Icons.facebook, context),
//                           ),
//                           SizedBox(height: MediaQuery.of(context).size.height* .02),
//                           GestureDetector(
//                             onTap: (){
//                               launchURL(urlLink: linkedin);
//                             },
//                             child: buildItemFollowMe( linkedin, Icons.link_outlined, context),
//                           )
//
//
//                           //========================================================
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * .55,
//                       height: MediaQuery.of(context).size.height * 1.1,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             // first name
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20),
//                               child: Text(
//                                 "${capitalize(firstname)} ${capitalize(lastname)}",
//                                 style:  TextStyle(
//                                     fontSize: MediaQuery.of(context).size.width*.05,
//                                     color: Colors.black54
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(height: MediaQuery.of(context).size.height * .01),
//                             // postion
//                             Text(capitalize(positionCv),
//
//                               style: TextStyle(
//                                   fontSize: 15.sp,
//                                   color: Colors.black38),
//
//                             ),
//
//                             // Space
//                             SizedBox(height: MediaQuery.of(context).size.height * .01),
//
//                             Text(capitalize(email),
//
//                               style: TextStyle(
//
//                                   fontSize: MediaQuery.of(context).size.width*.024,
//                                   color: Colors.black38),
//                             ),
//
//                             // Space
//                             SizedBox(height: MediaQuery.of(context).size.height * .02),
//
//                             // Label About us
//                             buildItemCategory(Icons.deck_outlined, "About us"),
//                             // Line
//                             const Divider(
//                               color: Colors.grey,
//                               thickness: 1,
//                             ),
//
//                             // about us
//                             Container(
//                                 width: MediaQuery.of(context).size.width *.9,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text("iam $firstname $lastname , my location is $address , graduated in $graduationYear , my position is $positionCv".toTitleCase() ,style: TextStyle(
//                                       height: 1.4,
//                                       fontSize: 12.sp, color: Colors.black),
//                                   textAlign: TextAlign.start,)
//                                 )
//                             ),
//
//                             // Space
//                             SizedBox(height: MediaQuery.of(context).size.height * .02),
//
//                             // Label Education
//                             buildItemCategory(Icons.deck_outlined, "Education"),
//                             // Line
//                             const Divider(
//                               color: Colors.grey,
//                               thickness: 1,
//                             ),
//
//                             // item Education
//                             buildEducationItem(
//                               ctx: context,
//                               specialization: specialization,
//                               graduationYear: validateGradeYear(),
//                               faculty: faculty,
//                               coursesList: pro,
//                               gpa: gpa,
//
//                             ),
//
//                             SizedBox(height: MediaQuery.of(context).size.height * .02),
//
//
//
//
//
//                             // Experience item
//
//                             showExperience(context),
//
//                             /*
//                             buildExperienceItem(
//                               ctx: context,
//                               position: cvModel.positionCv!,
//                               companyName: cvModel.companyName!,
//                               from: cvModel.startDate!,
//                               nameProject: cvModel.shareProject!,
//                               to: cvModel.endDate!,
//                             ),
//
//                          */
//
//
//                             SizedBox(height: MediaQuery.of(context).size.height * .02),
//
//
//                             // Label Hobbies
//                             showHobbies(context),
//
//
//
//
//
//                             SizedBox(height: MediaQuery.of(context).size.height*.03),
//
//
//                             // logo and power by
//
//
//                             Center(
//                               child: Column(
//                                 children: [
//                                   Image(
//                                     image: const AssetImage("assets/images/engx.png"),
//                                     height: 75.h,
//                                   ),
//
//                                   Text(
//                                     "Power by ENGX",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 13.sp,
//                                         color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                             )
//
//
//
//
//
//
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//          */
//
//       ),
//     );
//   }
//
//   buildInfoItem(
//       {required String name,
//         required String email,
//         required String phone,
//         required String address,
//         required String experienceYear}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Name: $name"),
//         const SizedBox(height: 4),
//         Text("Email: $email"),
//         const SizedBox(height: 4),
//         Text("Phone: $phone"),
//         const SizedBox(height: 4),
//         Text("Address: $address"),
//         const SizedBox(height: 4),
//         Text("Experience Year: $experienceYear"),
//       ],
//     );
//   }
//
//   buildEducationItem(
//       {
//         required BuildContext ctx,
//         required String faculty,
//         required String graduationYear,
//         required String specialization,
//         required String gpa,
//
//         required List coursesList}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         Text("Faculty: $faculty",style:  TextStyle(fontSize: 12.sp),),
//         SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         Text("Graduation Year: $graduationYear",style:  TextStyle(fontSize: 12.sp),),
//         SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         Text("Specialization: $specialization",style:  TextStyle(fontSize: 12.sp),),
//         SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         Text("Grade: $gpa",style:  TextStyle(fontSize: 12.sp),),
//         SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//
//       ],
//     );
//   }
//
//   buildExperienceItem(
//       {
//         required BuildContext ctx,
//         required String companyName,
//         required String from,
//         required String to,
//         required String position,
//         required String nameProject}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         // Experience label
//         buildItemCategory(Icons.deck_outlined, "Experience"),
//
//         // Divider
//         const Divider(
//           color: Colors.grey,
//           thickness: 1,
//         ),
//
//
//
//
//         Row(
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.apartment),
//                 SizedBox(width: 3.w),
//                 Text(
//                   companyName.toTitleCase(),
//                   style: const TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 const Icon(Icons.calendar_month),
//                 SizedBox(width: 3.w),
//                 Text(
//                   "$from : Now ",
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//
//
//         Row(
//           children: [
//             const Icon(Icons.accessibility_new_outlined),
//             SizedBox(width: 3.w),
//             Text(
//               "Position : $position".toTitleCase(),
//               style: const TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//
//         Row(
//           children: [
//             const Icon(Icons.assured_workload),
//             SizedBox(width: 3.w),
//             Text(
//               "Last Project: $nameProject".toTitleCase(),
//               style: const TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//
//         // Text("Position: $position",style: const TextStyle(fontSize: 12),),
//         // SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         // Text("Company: $companyName",style: const TextStyle(fontSize: 12),),
//         // SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         // Text("from : $from   ",style: const TextStyle(fontSize: 12),),
//         // SizedBox(height: MediaQuery.of(ctx).size.height*.01),
//         // Text("Last Project: $nameProject",style: const TextStyle(fontSize: 12),),
//       ],
//     );
//   }
//
//   buildItemCategory(IconData icon, String label) {
//     return Row(
//       children: [
//         CircleAvatar(
//             radius: 10,
//             backgroundColor: Colors.black54,
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 15,
//             )),
//         const SizedBox(width: 5),
//         Text(
//           capitalize(label),
//           style: TextStyle(
//               color: Colors.red[500],
//               fontSize: 18,
//               fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
//
//   buildItemFollowMe( String details, IconData icon,BuildContext ctx) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon,color: Colors.black,),
//
//
//
//
//             Text(
//               details,
//               style:TextStyle(color: Colors.blue, fontSize: MediaQuery.of(ctx).size.width *.027,overflow: TextOverflow.ellipsis),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   buildItemContactUs(IconData icon, String details, BuildContext ctx) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.grey,
//         ),
//         SizedBox(width: MediaQuery.of(ctx).size.width * .01),
//         Expanded(
//           child: Text(
//             details,
//             maxLines: 2,
//             textAlign: TextAlign.start,
//             overflow: TextOverflow.ellipsis,
//             style:  TextStyle(color: Colors.black,fontSize: MediaQuery.of(ctx).size.width*.029),
//           ),
//         )
//       ],
//     );
//   }
//
//
//   buildItemPerson(IconData icon, String details, String label , BuildContext ctx) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.white,
//         ),
//         Text(
//           label,
//           maxLines: 2,
//           textAlign: TextAlign.start,
//           overflow: TextOverflow.ellipsis,
//           style:  TextStyle(color: Colors.white70,fontSize: MediaQuery.of(ctx).size.width*.029),
//         ),
//         Text(
//           details,
//           maxLines: 2,
//           textAlign: TextAlign.start,
//           overflow: TextOverflow.ellipsis,
//           style:  TextStyle(color: Colors.white70,fontSize: MediaQuery.of(ctx).size.width*.029),
//         ),
//       ],
//     );
//   }
//
//
//   launchURL({required String urlLink}) async {
//     final Uri url = Uri.parse(urlLink);
//     if (!await launchUrl(url)) {
//       throw Exception('Could not launch');
//     }
//   }
// }
