import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../model/courses_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../../whatsUp/whatsuo_Page.dart';

class ClarificationSaving extends StatelessWidget {
  const ClarificationSaving({
    super.key,
    required this.coursesModel,
  });

  final CoursesModel coursesModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black45),
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        title: Text(
          S.of(context).Saving,
          style: TextStyle(color: ColorManager.Black),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
            child: buildCategoryWidget(
          urlImage: "assets/images/save.png",
          dec1: "50% Discount",
          dec2:
              "Content is unlocked for life if exams \n are completed within 3 Monthes ",
          dec4: "Conversion to the the open system",
          dec5: "is available with a payment of 50%",
          ctx: context,
        )),
      ),
    );
  }

  buildCategoryWidget(
      {required String urlImage,
      required String dec1,
      required String dec2,
      required String dec4,
      required String dec5,
      required BuildContext ctx}) {
    return Center(
      child: Container(
        width: 320,
        height: 550,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          gradient: const LinearGradient(
              colors: [
                Color(0xFFe5e5e5),
                Color(0xFFFFFFFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(urlImage),
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              buildCategoryPayment(dec1),
              const SizedBox(height: 20),
              buildCategoryPayment(dec2),
              const SizedBox(height: 20),
              buildCategoryPayment(dec4),
              const SizedBox(height: 20),
              buildCategoryPayment(dec5),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                        return WhatsUp();
                      }));
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                        "Pay by Whatsapp",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                        return WhatsUp();
                      }));
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: const Text(
                        "Pay by Visa",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryPayment(String name) {
    return Row(
      children: [
        Icon(
          Icons.star_border_outlined,
          size: 22,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 10,
            name,
            style: const TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}
