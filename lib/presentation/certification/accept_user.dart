import 'dart:io';
import 'dart:typed_data';

import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart ' as pw;

import '../../model/Certification_model.dart';
import 'ChoosesOperator.dart';
import 'Tablet/accept_user_tablet.dart';

class CertificationUser extends StatefulWidget {
  CertificationUser({super.key, required this.certificationModel});

  CertificationModel certificationModel;

  @override
  State<CertificationUser> createState() => _CertificationUserState();
}

class _CertificationUserState extends State<CertificationUser> {
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
    final uint8List = await screenshotController.capture();
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

  validateState() {
    if (widget.certificationModel.stateCourses == "ONLINE") {
      return "0000";
    } else {
      return "1111";
    }
  }

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: LayoutBuilder(builder: (context, constrain) {
        if (constrain.maxWidth < 600) {
          return SafeArea(
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
                            top: height * .02,
                            left: width * .24,
                            child: const Column(
                              children: [
                                Text(
                                  'CERTIFICATE',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 4),
                                ),
                                SizedBox(height: 3),
                                Text('OF APPRECIATION',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2)),
                                SizedBox(height: 1),
                                Text('PROUDLY PRESENTED TO',
                                    style: TextStyle(
                                      fontSize: 9,
                                    )),
                              ],
                            ),
                          ),

                          // name
                          Positioned(
                            top: height * .101,
                            left: width * .06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .85,
                                    child: Text(widget.certificationModel.name!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            letterSpacing: 1),
                                        textAlign: TextAlign.center)),
                              ],
                            ),
                          ),

                          // name courses
                          Positioned(
                            // top: height*.135,
                            top: height * .13,
                            left: width * .09,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .83,
                                child: Text(
                                  "FOR ACHIEVING ${widget.certificationModel.nameCourses!} DIPLOMA",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      letterSpacing: 1),
                                  textAlign: TextAlign.center,
                                )),
                          ),

                          // grade
                          widget.certificationModel.grade == 'GOOD' ||
                                  widget.certificationModel.grade == 'NONE'
                              ? Positioned(
                                  top: height * .1105,
                                  left: width * .32,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 30),
                                    child: Row(
                                      children: [
                                        Text(
                                          "GRADE ${widget.certificationModel.grade!} ( ${widget.certificationModel.degree!}% )",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              letterSpacing: 1),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Positioned(
                                  top: height * .1105,
                                  left: width * .28,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 30),
                                    child: Row(
                                      children: [
                                        Text(
                                          "GRADE ${widget.certificationModel.grade!} ( ${widget.certificationModel.degree!}% )",
                                          style: const TextStyle(
                                              fontSize: 10,
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
                            top: height * .17,
                            left: width * .23,
                            child: const Column(
                              children: [
                                Text('TO PASS A 6-MONTH TRAINING PERIOD',
                                    style: TextStyle(
                                      fontSize: 7,
                                    )),
                                Text('IN THE FIELD OF',
                                    style: TextStyle(fontSize: 7)),
                                Text(
                                    'HVAC, FIREFIGHTING, PLUMBING AND MEDICAL GAS',
                                    style: TextStyle(fontSize: 7)),
                                Text(
                                    'THE APPLICATION HAS BEEN APPLIED TO MANY PROJECTS',
                                    style: TextStyle(fontSize: 7)),
                                Text('USING THE REVIT AND AUTOCAD SOFTWARE',
                                    style: TextStyle(
                                      fontSize: 7,
                                    )),
                              ],
                            ),
                          ),

                          //text date
                          Positioned(
                            top: height * .200,
                            left: width * .277,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Row(
                                children: [
                                  Text(
                                    'DATE',
                                    style: TextStyle(
                                        fontSize: 8,
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
                            top: height * .230,
                            left: width * .25,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Row(
                                children: [
                                  Text(
                                    todayDate(),
                                    style: const TextStyle(
                                        fontSize: 8,
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
                            top: height * .200,
                            left: width * .54,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'ENG.AHMED M. SHUHAYB',
                                        style: TextStyle(
                                            fontSize: 8,
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
                            top: height * .230,
                            left: width * .55,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Row(
                                children: [
                                  Text(
                                    'TRAINING MANAGER',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // image logo engx
                          Positioned(
                            top: height * .204,
                            left: width * .441,
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
                                child: Image(
                                  image: AssetImage('assets/images/ASEC.png'),
                                  height: 25,
                                )),
                          ),

                          // text logo engx
                          Positioned(
                            top: height * .227,
                            left: width * .457,
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
                                child: Text(
                                  'ENG-X',
                                  style: TextStyle(
                                      fontSize: 4, fontWeight: FontWeight.w600),
                                )),
                          ),

                          // serial number
                          Positioned(
                            top: height * .265,
                            left: width * .09,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Row(
                                children: [
                                  Text(
                                    "Serial No. ${yearDate()}-${validateState()}-${widget.certificationModel.serialNumber!}",
                                    style: const TextStyle(
                                        fontSize: 7,
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

                  // ElevatedButton(
                  //     onPressed: _printScreen, child: const Text("Take screenShot"))
                ],
              ),
            ),
          );
        } else if (constrain.maxWidth < 900) {
          return Center(
              child: AcceptUserCertificateTablet(
            certificationModel: constantvar.certificationModel!,
          ));
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

          FirebaseFirestore.instance
              .collection("AcceptCertificate")
              .doc(widget.certificationModel.id)
              .delete();
          print("Delete Done");
          print(widget.certificationModel.id);
          navigateTo(context, const ChoosesState());
        },
        backgroundColor: Colors.brown[200],
        child: const Icon(Icons.download),
      ),
    );
  }
}
