import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/values_manager.dart';
import '../whatsUp/whatsuo_Page.dart';
import 'open_card.dart';

class OpenPayPackage extends StatefulWidget {
  const OpenPayPackage({super.key});

  @override
  State<OpenPayPackage> createState() => _OpenPayPackageState();
}

class _OpenPayPackageState extends State<OpenPayPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: const Text("Payment",style: TextStyle(color: Colors.black54,fontSize: 22),),
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient:  LinearGradient(
              colors: [
                Color(0xFFe5e5e5),
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
              dec2: "Activated on laptop and android ",
              dec3: " Get Additions every new release",
              dec4: "Available to star without a task",
              ctx: context,
            )),
      ),
    );
  }
}

buildCategoryWidget(
    {
      required String urlImage,
      required String dec1,
      required String dec2,
      required String dec3,
      required String dec4,
      required BuildContext ctx
    }) {
  return Center(
    child: Container(
      width: 300.w ,
      height: 600.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Image(
            image: AssetImage(urlImage),
            width: 180.w,
            height: 250.h,
            fit: BoxFit.fill,
          ),
           SizedBox(height: 40.h),
          buildCategoryPayment(dec1),
           SizedBox(height: 20.h),
          buildCategoryPayment(dec2),
           SizedBox(height: 20.h),
          buildCategoryPayment(dec3),
           SizedBox(height: 20.h),
          buildCategoryPayment(dec4),
          SizedBox(height: 60.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                    return WhatsUp();
                  }));
                },
                child: Container(
                  width: 150.w,
                  height: 50.h,
                  decoration:  BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:  BorderRadius.circular(15)
                  ),
                  child:  Center(child: Text("Pay by Whatsapp",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)),
                ),
              ),

            ],
          ),
        ],
      ),
    ),
  );
}

buildCategoryPayment(
    String name,
    ) {
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
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          name,
          style: TextStyle(fontSize: 12.sp),
        ),
      )
    ],
  );
}
