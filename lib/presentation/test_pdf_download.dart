import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ScreenShotToPdf extends StatelessWidget {
  ScreenShotToPdf({super.key});

  //  بستخدمه عشان احدد العنصر ال هتعامل معاه في الصفحه زى مثلا هعمل جزء معين pdf ف هعرفه عن طريق المفتاح دا زى م بنعمله فى form لما بنيجي نستخدمها
  final GlobalKey _printKey = GlobalKey();

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWrapper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // دى عبارة عن widget بحدد بيها جزء معين من الصفحه مش بيتم عليها اي ستايل نعمله ف الصفحه و استخدمناها هنا عشان احدد العنصر ال هحوله ل pdf لما اخد ال screen Shot
          RepaintBoundary(
              key: _printKey,
              child: Container(

                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtDZ3-Yw3bgKq-QSpxuvlERsUfa77gz2JJcw&s"))),
          ElevatedButton(
              onPressed: _printScreen, child: const Text("Take screenShot"))
        ],
      ),
    );
  }
}