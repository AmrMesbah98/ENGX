import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart ' as pw;

import '../../../model/Certification_model.dart';

class AcceptUserCertificateTablet extends StatefulWidget {
  AcceptUserCertificateTablet({super.key, required this.certificationModel});

  CertificationModel certificationModel;

  @override
  State<AcceptUserCertificateTablet> createState() =>
      _AcceptUserCertificateTabletState();
}

class _AcceptUserCertificateTabletState
    extends State<AcceptUserCertificateTablet> {
  get pdf => null;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  yearDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    //String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    // print(formattedTime);
    print(formattedDate);
    return formattedDate;
  }

  Future getPdf(Uint8List screenShot) async {
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
              child: pw.Image(
                  PdfImage.file(pdf.document, bytes: screenShot)
                      as pw.ImageProvider,
                  fit: pw.BoxFit.contain));
        },
      ),
    );

    String tempPath = (await getTemporaryDirectory()).path;
    String fileName = "myPdf";

    File pdfFile = await File('$tempPath/$fileName.pdf').create();
    pdfFile.writeAsBytesSync(pdf.save() as List<int>);
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

  /*
   Future screenToPdf({required String fileName}) async {

    pw.Document pdf = pw.Document();
    final customPageSize = PdfPageFormat(300.w, 200.h, marginAll: 3);
    pdf.addPage(
      pw.Page(
        //pageFormat: PdfPageFormat.a4,
        pageFormat: customPageSize,
        build: (context) {
          return pw.Expanded(
            child: pw.Image(pw.MemoryImage(uint8List!), fit: pw.BoxFit.values[3]),
          );
        },
      ),
    );

    if (await Permission.storage.request().isGranted) {
      // File file = await File('$tempPath/$fileName.png').create();
      // file.writeAsBytesSync(uint8List!);
      String path = (await getTemporaryDirectory()).path;
      File pdfFile = await File('$path/$fileName.pdf').create();

      pdfFile.writeAsBytesSync(await pdf.save());
      await Share.shareXFiles([XFile('$path/certificate.pdf')]);
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
          //pageFormat: PdfPageFormat.a4,
          pageFormat: customPageSize,
          build: (context) {
            return pw.Expanded(
              child: pw.Image(pw.MemoryImage(uint8List!), fit: pw.BoxFit.values[3]),
            );
          },
        ),
      );

      return doc.save();
    });
  }
   */

  validateState() {
    if (widget.certificationModel.stateCourses == "ONLINE") {
      return "0000";
    } else {
      return "1111";
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: _printKey,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      // image
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Image(
                          image: const AssetImage(
                              "assets/images/certificatee.png"),
                          width: MediaQuery.of(context).size.width,

                          //image: AssetImage("assets/images/oldCertificate.png"),
                        ),
                      ),

                      //column text certificate
                      Positioned(
                        top: height * .02.h,
                        left: width * .135.w,
                        child: Column(
                          children: [
                            Text(
                              'CERTIFICATE',
                              style: TextStyle(
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 4),
                            ),
                            SizedBox(height: 3.h),
                            Text('OF APPRECIATION',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2)),
                            SizedBox(height: 1.h),
                            Text('PROUDLY PRESENTED TO',
                                style: TextStyle(
                                  fontSize: 7.sp,
                                )),
                          ],
                        ),
                      ),

                      // name
                      Positioned(
                        top: height * .097.h,
                        left: width * .033.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .85,
                                child: Text(widget.certificationModel.name!,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        letterSpacing: 1),
                                    textAlign: TextAlign.center)),
                          ],
                        ),
                      ),

                      // name courses
                      Positioned(
                        // top: height*.135,
                        top: height * .124.h,
                        left: width * .038.w,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * .83,
                            child: Text(
                              "FOR ACHIEVING ${widget.certificationModel.nameCourses!} DIPLOMA",
                              style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.black,
                                  letterSpacing: 1),
                              textAlign: TextAlign.center,
                            )),
                      ),

                      // grade
                      widget.certificationModel.grade == 'GOOD' ||
                              widget.certificationModel.grade == 'NONE'
                          ? Positioned(
                              top: height * .1105.h,
                              left: width * .16.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 30.h),
                                child: Row(
                                  children: [
                                    Text(
                                      "GRADE ${widget.certificationModel.grade!} ( ${widget.certificationModel.degree!}% )",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.black,
                                          letterSpacing: 1),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Positioned(
                              top: height * .112.h,
                              left: width * .143.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 30.h),
                                child: Row(
                                  children: [
                                    Text(
                                      "GRADE ${widget.certificationModel.grade!} ( ${widget.certificationModel.degree!}% )",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.black,
                                          letterSpacing: 1),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      //column text to pass
                      Positioned(
                        top: height * .16.h,
                        left: width * .112.w,
                        child: Column(
                          children: [
                            Text('TO PASS A 6-MONTH TRAINING PERIOD',
                                style: TextStyle(
                                  fontSize: 7.sp,
                                )),
                            Text('IN THE FIELD OF',
                                style: TextStyle(fontSize: 7.sp)),
                            Text('HVAC, FIREFIGHTING, PLUMBING AND MEDICAL GAS',
                                style: TextStyle(fontSize: 7.sp)),
                            Text(
                                'THE APPLICATION HAS BEEN APPLIED TO MANY PROJECTS',
                                style: TextStyle(fontSize: 7.sp)),
                            Text('USING THE REVIT AND AUTOCAD SOFTWARE',
                                style: TextStyle(
                                  fontSize: 7.sp,
                                )),
                          ],
                        ),
                      ),

                      //text date
                      Positioned(
                        top: height * .210.h,
                        left: width * .135.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: Row(
                            children: [
                              Text(
                                'DATE',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // date
                      Positioned(
                        // top: height*.23,
                        // left: width*.211,
                        top: height * .240.h,
                        left: width * .119.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: Row(
                            children: [
                              Text(
                                todayDate(),
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ENG.AHMED M. SHUHAYB
                      Positioned(
                        // top: height*.23,
                        // left: width*.211,
                        top: height * .210.h,
                        left: width * .265.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'ENG.AHMED M. SHUHAYB',
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Training Manger

                      Positioned(
                        // top: height*.23,
                        // left: width*.211,
                        top: height * .240.h,
                        left: width * .275.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 30.h),
                          child: Row(
                            children: [
                              Text(
                                'TRAINING MANAGER',
                                style: TextStyle(
                                    fontSize: 8.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // image logo engx
                      Positioned(
                        top: height * .214.h,
                        left: width * .223.w,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 30.h),
                            child: Image(
                              image: const AssetImage('assets/images/ASEC.png'),
                              height: 25.h,
                            )),
                      ),

                      // text logo engx
                      Positioned(
                        top: height * .255.h,
                        left: width * .226.w,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 3.h),
                            child: Text(
                              'ENG-X',
                              style: TextStyle(
                                  fontSize: 4.sp, fontWeight: FontWeight.w600),
                            )),
                      ),

                      // serial number
                      Positioned(
                        top: height * .278.h,
                        left: width * .04.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Row(
                            children: [
                              Text(
                                "Serial No. ${yearDate()}-${validateState()}-${widget.certificationModel.serialNumber!}",
                                style: TextStyle(
                                    fontSize: 7.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
