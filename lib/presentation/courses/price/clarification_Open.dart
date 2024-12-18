import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../../whatsUp/whatsuo_Page.dart';

class ClarificationOpen extends StatelessWidget {
  const ClarificationOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      if (constrain.maxWidth < 600) {
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
              S.of(context).Open,
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
              urlImage: "assets/images/lock.png",
              dec1: "Content is unlocked for life ",
              dec2: "Activated on laptop and android mobile",
              dec3: " Get Additions every new release",
              dec4: "Available to star without a task",
              ctx: context,
            )),
          ),
        );
      } else if (constrain.maxWidth < 900) {
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
              S.of(context).Open,
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
                child: buildCategoryWidgetTab(
              urlImage: "assets/images/lock.png",
              dec1: "Content is unlocked for life ",
              dec2: "Activated on laptop and android mobile",
              dec3: " Get Additions every new release",
              dec4: "Available to star without a task",
              ctx: context,
            )),
          ),
        );
      } else {
        return const Center(
          child: Text("Desktop"),
        );
      }
    });
  }

  buildCategoryWidget(
      {required String urlImage,
      required String dec1,
      required String dec2,
      required String dec3,
      required String dec4,
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
              buildCategoryPayment(dec3),
              const SizedBox(height: 20),
              buildCategoryPayment(dec4),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                        return WhatsUp();
                      }));
                    },
                    child: Container(
                      width: 200,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryWidgetTab(
      {required String urlImage,
      required String dec1,
      required String dec2,
      required String dec3,
      required String dec4,
      required BuildContext ctx}) {
    return Center(
      child: Container(
        width: 320.w,
        height: 600.h,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Image(
                image: AssetImage(urlImage),
                width: 130.w,
                height: 200.h,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 40.h),
              buildCategoryPayment(dec1),
              const SizedBox(height: 20),
              buildCategoryPayment(dec2),
              const SizedBox(height: 20),
              buildCategoryPayment(dec3),
              const SizedBox(height: 20),
              buildCategoryPayment(dec4),
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                        return WhatsUp();
                      }));
                    },
                    child: Container(
                      width: 200,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryPayment(
    String name,
  ) {
    return Row(
      children: [
        const Icon(
          Icons.star_border_outlined,
          size: 25,
          color: Colors.black,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              name,
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
        )
      ],
    );
  }
}
