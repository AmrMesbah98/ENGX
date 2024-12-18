import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/ineer_response_model.dart';

class ShowAllCvForJob extends StatelessWidget {
  ShowAllCvForJob(
      {super.key,
      required this.cvJobModel,
      required this.pro,
      required this.stName,
      required this.stNum});

  final InnerResponseModel cvJobModel;
  final List pro;
  final String stName;
  final String stNum;

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String validateDate() {
    if (cvJobModel.startDate! == "") {
      return "2024";
    } else {
      return cvJobModel.startDate!;
    }
  }

  String validateGradeYear() {
    if (cvJobModel.graduationYear! == "") {
      return "2024";
    } else {
      return cvJobModel.graduationYear!;
    }
  }

  showExperience(BuildContext ctx) {
    if (cvJobModel.work == false) {
      return Container();
    } else {
      return buildExperienceItem(
        ctx: ctx,
        position: cvJobModel.positionCv!,
        companyName: cvJobModel.companyName!,
        from: validateDate(),
        nameProject: cvJobModel.shareProject!,
      );
    }
  }

  showHobbies() {
    if (cvJobModel.listHobbies!.isNotEmpty) {
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
                itemCount: cvJobModel.listHobbies!.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sports_soccer,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            capitalize(cvJobModel.listHobbies![index]),
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.sp),
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

  /*
   shareImage() async {
    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    String fileName = "myFile";
    if (await Permission.storage.request().isGranted) {
      File file = await File('$tempPath/$fileName.png').create();
      file.writeAsBytesSync(uint8List!);

    }
  }
   */

  final GlobalKey _printKey = GlobalKey();

  /*
   Future<void> _printScreen() async {
     final uint8List = await screenshotController.capture();
     final customPageSize = PdfPageFormat(300.w, 200.h,marginAll: 3);

     Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
       final doc = pw.Document();

       final image = await WidgetWrapper.fromKey(
         key: _printKey,
         pixelRatio: 2.0,
       );

       doc.addPage(
         pw.Page(
           pageFormat: PdfPageFormat.a4,
           //pageFormat: customPageSize,
           build: (context) {
             return pw.Expanded(
               child: pw.Image(pw.MemoryImage(uint8List!), fit: pw.BoxFit.fill),
             );
           },
         ),
       );

       return doc.save();
     });
   }
   */

  Future<void> shareScreenShot() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final String localPath =
        '${directory?.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    await Future.delayed(const Duration(seconds: 1));

    // whatsapp_sender_flutter
    /*
      await WhatsappShare.shareFile(
       phone: '01288136870',
       filePath: [localPath],
     );
      */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constrain) {
        if (constrain.maxWidth < 600) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10.h),

                      // first section of cv

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(40),
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(10),
                              )),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                  "assets/images/person22.png",
                                ),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(width: 50.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Name
                                  Row(
                                    children: [
                                      cvJobModel.isTrain == true
                                          ? const Icon(Icons.star,
                                              color: Colors.grey)
                                          : Container(),
                                      Text(
                                        "${capitalize(cvJobModel.firstname!)} ${capitalize(cvJobModel.lastname!)}",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .035,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  // position
                                  Text(
                                    capitalize(cvJobModel.positionCv!),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black38),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //space
                      SizedBox(height: 20.h),

                      // contact us text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.contacts,
                              size: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5.w),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "CONTACT US",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp),
                                )),
                          ],
                        ),
                      ),
                      // Line
                      const Divider(
                        color: Colors.grey,
                        indent: 0,
                        thickness: 1,
                        endIndent: 290,
                      ),

                      // details of contact us
                      Column(
                        children: [
                          // phone and state
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // phone
                              Row(
                                children: [
                                  const Icon(Icons.phone_android, size: 20),
                                  SizedBox(width: 7.w),
                                  Text(
                                    cvJobModel.phone!,
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                ],
                              ),
                              //state
                              Padding(
                                padding: EdgeInsets.only(right: 63.w),
                                child: Row(
                                  children: [
                                    const Icon(
                                        Icons.volunteer_activism_outlined,
                                        size: 20),
                                    SizedBox(width: 7.w),
                                    Text(
                                      cvJobModel.state!.toCapitalized(),
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          // email and military
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // email
                              Expanded(
                                flex: 2,
                                child: buildItemContactUs(Icons.email_outlined,
                                    cvJobModel.email!.toCapitalized(), context),
                              ),

                              // military

                              Expanded(
                                flex: 1,
                                child: buildItemContactUs(
                                    Icons.verified_user_outlined,
                                    cvJobModel.military!,
                                    context),
                              )
                            ],
                          ),

                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Text(
                                "$stNum St - ${stName.toCapitalized()} - ${cvJobModel.address?.toCapitalized()}",
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ],
                          )
                        ],
                      ),

                      SizedBox(height: 15.h),

                      // Education text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.deck_outlined,
                              size: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5.w),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "EDUCATION",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp),
                                )),
                          ],
                        ),
                      ),
                      // Line
                      const Divider(
                        color: Colors.grey,
                        indent: 0,
                        thickness: 1,
                        endIndent: 290,
                      ),

                      // details of Education
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            // university
                            Row(
                              children: [
                                const Icon(Icons.school),
                                SizedBox(width: 5.w),
                                Flexible(
                                    child: Text(
                                  "University of ${cvJobModel.faculty!.toCapitalized()}   |   ${validateGradeYear()}",
                                  style: TextStyle(fontSize: 13.sp),
                                )),
                              ],
                            ),

                            // specialization
                            Row(
                              children: [
                                const Icon(Icons.engineering),
                                SizedBox(width: 5.w),
                                Text(
                                  "${cvJobModel.specialization} Engineer",
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                              ],
                            ),

                            // Grade
                            Row(
                              children: [
                                const Icon(Icons.workspace_premium),
                                SizedBox(width: 5.w),
                                Text(
                                  "Grade is ${cvJobModel.gpa}",
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // ProSkill text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.token,
                              size: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5.w),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "PRO SKILLS",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp),
                                )),
                          ],
                        ),
                      ),
                      // Line
                      const Divider(
                        color: Colors.grey,
                        indent: 0,
                        thickness: 1,
                        endIndent: 290,
                      ),

                      // skills details

                      SizedBox(
                        height: 55,
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cvJobModel.pro!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 30),
                          itemBuilder: (BuildContext context, int index) {
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
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      /*

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
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12)),
                                          ),
                                        ],
                                      );
                                    }),
                              ),

                                             */

                      // Experience details
                      showExperience(context),

                      SizedBox(height: 16.h),

                      // Hobbies text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5.w),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Hobbies",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp),
                                )),
                          ],
                        ),
                      ),
                      // Line
                      const Divider(
                        color: Colors.grey,
                        indent: 0,
                        thickness: 1,
                        endIndent: 290,
                      ),

                      // hobbies details

                      SizedBox(
                        height: 17.h,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cvJobModel.listHobbies!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite_border,
                                          size: 18,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          cvJobModel.listHobbies![index],
                                          style: TextStyle(fontSize: 11.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),

                      SizedBox(height: 16.h),

                      // Social Links
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.token,
                              size: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5.w),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Social Links",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp),
                                )),
                          ],
                        ),
                      ),
                      // Line
                      const Divider(
                        color: Colors.grey,
                        indent: 0,
                        thickness: 1,
                        endIndent: 290,
                      ),

                      // social details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // facebook
                          GestureDetector(
                            onTap: () {
                              launchURL(urlLink: cvJobModel.facebook!);
                            },
                            child: buildItemFollowMe(
                                "FaceBook Account", Icons.facebook, context),
                          ),

                          // linkedin
                          Padding(
                            padding: const EdgeInsets.only(right: 47),
                            child: GestureDetector(
                              onTap: () {
                                launchURL(urlLink: cvJobModel.linkedin!);
                              },
                              child: buildItemFollowMe("linkedin Account ",
                                  FontAwesomeIcons.linkedin, context),
                            ),
                          ),
                        ],
                      ),

                      /*

                                  SizedBox(height: 48.h),

                              // power by
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200]
                                ),

                                width: MediaQuery.of(context).size.width,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: Text("Power by ENGX")),
                                    Image(image: AssetImage("assets/images/ASEC.png"),width: 30,height: 30,),

                                  ],
                                ),
                              )

                                 */

                      /*

                              Row(
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
                                            const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Contact us",
                                                  style: TextStyle(color: Colors.black),
                                                )),
                                            // Line
                                            const Divider(
                                              color: Colors.grey,
                                              indent: 0,
                                              thickness: 1,
                                              endIndent: 0,
                                            ),

                                            // ========================================================
                                            buildItemContactUs(
                                                Icons.phone_android, cvModel.phone!, context),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .01),
                                            buildItemContactUs(Icons.location_on_outlined,
                                                cvModel.address!, context),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .01),
                                            buildItemContactUs(
                                                Icons.volunteer_activism, cvModel.state!, context),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .01),
                                            buildItemContactUs(
                                                Icons.verified_user, cvModel.military!, context),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .01),
                                            //   buildItemContactUs(Icons.email, cvModel.email!,context),
                                            // ========================================================

                                            // Space
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .02),

                                            // pro Skills
                                            const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "PRO SKILLS",
                                                  style: TextStyle(color: Colors.black),
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
                                                              style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 12)),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ),

                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .02),

                                            // Follow Me
                                            const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Social Links",
                                                  style: TextStyle(color: Colors.black),
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
                                              child: buildItemFollowMe(
                                                  cvModel.facebook!, Icons.facebook, context),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .02),
                                            // linkedin
                                            GestureDetector(
                                              onTap: () {
                                                launchURL(urlLink: cvModel.linkedin!);
                                              },
                                              child: buildItemFollowMe(cvModel.linkedin!,
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
                                                      MediaQuery.of(context).size.width * .05,
                                                      color: Colors.black54),
                                                ),
                                              ),

                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height * .01),
                                              // postion
                                              Text(
                                                capitalize(cvModel.positionCv!),
                                                style: TextStyle(
                                                    fontSize: 15.sp, color: Colors.black38),
                                              ),

                                              // Space
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height * .01),

                                              // email
                                              Text(
                                                capitalize(cvModel.email!),
                                                style: TextStyle(
                                                    fontSize:
                                                    MediaQuery.of(context).size.width * .024,
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
                                                  width: MediaQuery.of(context).size.width * .9,
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Center(
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
                                                                  fontSize: 12.sp,
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
                                                                  fontSize: 12.sp,
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
                                                                  fontSize: 12.sp,
                                                                  color: Colors.black),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ],
                                                        )),
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
                                              buildEducationItem(
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

                                              showHobbies(),

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
                                                          fontSize: 13.sp,
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
                               */
                    ],
                  ),

                  //whatsapp sender file
                  /*

                        InkWell(
                            onTap: () async {
                              /*
                              _printScreen().then((value) async {

                                await WhatsAppSenderFlutter.send(
                                  phones: [ "01288136870"],
                                  message: "Hello",
                                  //file: File("path-to-file.pdf"),
                                  // file: File('$getTemporaryDirectory().path/$fileName.png').create()
                                ).then((value) {
                                  print("done send whats>>>>>>");
                                });

                              });

                               */



                              String path = (await getTemporaryDirectory()).path;
                              File pdfFile = await File('$path/CV.pdf').create();

                              await WhatsAppSenderFlutter.send(
                                phones: ["+201288136870"],
                                message: "Hello",
                                 file: pdfFile
                              ).then((value) {

                                print("done send whats>>>>>>");
                              });





                            },

                            child: Text("download")),

                         */
                ],
              ),
            ),
          );
        } else if (constrain.maxWidth < 900) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  // first section of cv

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(10),
                          )),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              "assets/images/person22.png",
                            ),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 65.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Name
                              Row(
                                children: [
                                  cvJobModel.isTrain == true
                                      ? const Icon(Icons.star,
                                          color: Colors.grey)
                                      : Container(),
                                  Text(
                                    "${capitalize(cvJobModel.firstname!)} ${capitalize(cvJobModel.lastname!)}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                .05,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              // position
                              Text(
                                capitalize(cvJobModel.positionCv!),
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.black38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //space
                  SizedBox(height: 30.h),

                  // contact us text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.contacts,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "CONTACT US",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            )),
                      ],
                    ),
                  ),

                  // Line
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                    thickness: 1,
                    endIndent: 550,
                  ),

                  // details of contact us
                  Column(
                    children: [
                      // phone and state
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // phone
                          Row(
                            children: [
                              const Icon(Icons.phone_android, size: 20),
                              SizedBox(width: 7.w),
                              Text(
                                cvJobModel.phone!,
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ],
                          ),
                          //state
                          Padding(
                            padding: EdgeInsets.only(right: 55.w),
                            child: Row(
                              children: [
                                const Icon(Icons.volunteer_activism_outlined,
                                    size: 20),
                                SizedBox(width: 7.w),
                                Text(
                                  cvJobModel.state!.toCapitalized(),
                                  style: TextStyle(fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // email and military
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // email
                          Expanded(
                            flex: 2,
                            child: buildItemContactUs(Icons.email_outlined,
                                cvJobModel.email!.toCapitalized(), context),
                          ),

                          // military

                          Expanded(
                            flex: 1,
                            child: buildItemContactUs(
                                Icons.verified_user_outlined,
                                cvJobModel.military!,
                                context),
                          )
                        ],
                      ),

                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(
                            "$stNum St - ${stName.toCapitalized()} - ${cvJobModel.address?.toCapitalized()}",
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Education text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.deck_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "EDUCATION",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            )),
                      ],
                    ),
                  ),
                  // Line
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                    thickness: 1,
                    endIndent: 290,
                  ),

                  // details of Education
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        // university
                        Row(
                          children: [
                            const Icon(Icons.school),
                            SizedBox(width: 5.w),
                            Text(
                              "University of ${cvJobModel.faculty!.toCapitalized()}   |   ${validateGradeYear()}",
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),

                        // specialization
                        Row(
                          children: [
                            const Icon(Icons.engineering),
                            SizedBox(width: 5.w),
                            Text(
                              "${cvJobModel.specialization} Engineer",
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),

                        // Grade
                        Row(
                          children: [
                            const Icon(Icons.workspace_premium),
                            SizedBox(width: 5.w),
                            Text(
                              "Grade is ${cvJobModel.gpa}",
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // ProSkill text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.token,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "PRO SKILLS",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            )),
                      ],
                    ),
                  ),
                  // Line
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                    thickness: 1,
                    endIndent: 290,
                  ),

                  // skills details

                  SizedBox(
                      height: 88.h,
                      child: ListView.builder(
                          itemCount: cvJobModel.pro!.length,
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
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 8.sp)),
                                ),
                              ],
                            );
                          })),

                  /*

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
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12)),
                                  ),
                                ],
                              );
                            }),
                      ),

                 */

                  // Experience details
                  showExperience(context),

                  SizedBox(height: 16.h),

                  // Hobbies text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Hobbies",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            )),
                      ],
                    ),
                  ),

                  // Line
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                    thickness: 1,
                    endIndent: 290,
                  ),

                  // hobbies details

                  SizedBox(
                    height: 20.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: cvJobModel.listHobbies!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite_border,
                                      size: 18,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      cvJobModel.listHobbies![index],
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),

                  SizedBox(height: 16.h),

                  // Social Links
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.token,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.w),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Social Links",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            )),
                      ],
                    ),
                  ),
                  // Line
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                    thickness: 1,
                    endIndent: 290,
                  ),

                  // social details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // facebook
                      GestureDetector(
                        onTap: () {
                          launchURL(urlLink: cvJobModel.facebook!);
                        },
                        child: buildItemFollowMe(
                            "Facebook Account", Icons.facebook, context),
                      ),

                      // linkedin
                      Padding(
                        padding: const EdgeInsets.only(right: 47),
                        child: GestureDetector(
                          onTap: () {
                            launchURL(urlLink: cvJobModel.linkedin!);
                          },
                          child: buildItemFollowMe("linkedin Account ",
                              FontAwesomeIcons.linkedin, context),
                        ),
                      ),
                    ],
                  ),

                  // InkWell(
                  //     onTap: () async {
                  //       await WhatsAppSenderFlutter.send(
                  //         phones: [ "391111111", "391111111", "391111111"],
                  //         message: "Hello",
                  //         file: File("path-to-file.pdf"),
                  //       );
                  //     },
                  //
                  //     child: Text("download")),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text("Desktop"));
        }
      }),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        hoverColor: Colors.orange,
        onPressed: () {
          print('aaaaaaaaaaaaaaaa');
          // for screenShot
          //shareImage();

          //for pdf
          // screenToPdf(fileName:'certificate');

          //for new pdf
          //_printScreen();
        },
        backgroundColor: Colors.blue[200],
        child: const Icon(Icons.download),
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

  buildExperienceItem(
      {required BuildContext ctx,
      required String companyName,
      required String from,
      required String position,
      required String nameProject}) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        // Experience text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            children: [
              const Icon(
                Icons.token,
                size: 20,
                color: Colors.grey,
              ),
              SizedBox(width: 5.w),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "EXPERIENCE",
                    style: TextStyle(color: Colors.red, fontSize: 15.sp),
                  )),
            ],
          ),
        ),
        // Line
        const Divider(
          color: Colors.grey,
          indent: 0,
          thickness: 1,
          endIndent: 290,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // name of office
              Row(
                children: [
                  const Icon(Icons.apartment),
                  SizedBox(width: 6.w),
                  Text(
                    companyName.toTitleCase(),
                    style: TextStyle(
                        fontSize: 11.sp, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),

              // date
              Padding(
                padding: const EdgeInsets.only(right: 77),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    Text(
                      "$from : Now ",
                      style: TextStyle(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),

              /*
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
               */
            ],
          ),
        ),

        SizedBox(height: 6.h),

        // position
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.accessibility_new_outlined),
                SizedBox(width: 6.w),
                Text(
                  position.toTitleCase(),
                  style: TextStyle(fontSize: 11.sp),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 6.h),
        //Special Project
        Padding(
          padding: const EdgeInsets.only(right: 59),
          child: Row(
            children: [
              const Icon(Icons.assured_workload),
              SizedBox(width: 6.w),
              Text(
                "Special Project: $nameProject".toTitleCase(),
                style: TextStyle(fontSize: 11.sp),
              ),
            ],
          ),
        ),
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

  buildItemContactUs(IconData icon, String details, BuildContext ctx) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(width: MediaQuery.of(ctx).size.width * .01),
        Text(
          details,
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 11.sp),
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

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
