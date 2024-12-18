import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../presentation/resources/color_manager.dart';
import '../presentation/resources/values_manager.dart';

buildHorizontalList(
  BuildContext ctx,
  String image,
  String nameCourse,
  String nameInstructor,
  String price,
  String rate,
) {
  return Stack(
    alignment: Alignment.bottomLeft,
    children: [





      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
        child: SizedBox(
          width: 180.w,
          child: Card(
            shadowColor: Colors.white, //ToDO
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient:  const LinearGradient(
                    colors: [
                      Color(0xFFe5e5e5),

                      Color(0xFFFFFFFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s20),
                        topRight: Radius.circular(AppSize.s20),
                        bottomLeft: Radius.circular(AppSize.s20),
                        bottomRight: Radius.circular(AppSize.s20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: 156.h,
                      width: AppSize.s200,
                      errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        child: const SizedBox(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 8.w,bottom: 4.h),
        child: Container(
          width: 171.w,
          height: 30.h,
          decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
          ),

          child: Padding(
            padding:  EdgeInsets.only(left: 10.w),
            child: Row(

              children: [
                Text(
                  nameCourse,
                  // style: const TextStyle(
                  //     fontSize: AppSize.s15, fontWeight: FontWeight.w900),
                  style:  TextStyle(
                      fontSize: 10.sp, fontWeight: FontWeight.w900,color: Colors.white),
                ),
                const Spacer(),
                Icon(
                  Icons.star,
                  color: ColorManager.star,
                  size: 15,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 7.w),
                  child: Text(
                    rate,
                    style:  TextStyle(color: Colors.white,fontSize: 10.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



    ],
  );
}


buildHorizontalFreeCoursesListTab(
    BuildContext ctx,
    String image,
    String nameCourse,
    String rate,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
    child: SizedBox(
      width: 100.w,
      child: Card(
        shadowColor: Colors.white, //ToDO
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient:  const LinearGradient(
                  colors: [
                    Color(0xFFe5e5e5),

                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [

              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s20),
                    topRight: Radius.circular(AppSize.s20),
                    bottomRight: Radius.circular(AppSize.s20),
                    bottomLeft: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  height:180,
                  width: AppSize.s200,
                  errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade200,
                    child: const SizedBox(
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
              // Title
              Container(
                decoration:  const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                ),
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 3.h,left: 4.w,right: 4.w),
                  child: Row(
                    children: [
                      Text(
                        nameCourse,
                        // style: const TextStyle(
                        //     fontSize: AppSize.s15, fontWeight: FontWeight.w900),
                        style:  TextStyle(
                            fontSize: 6.sp, fontWeight: FontWeight.w600,color: Colors.white),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.star,
                        color: ColorManager.star,
                        size: 16,
                      ),
                      Text(
                        rate,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    ),
  );
}

buildHorizontalFreeCoursesList(
    BuildContext ctx,
    String image,
    String nameCourse,
    String rate,
    ) {
  return Stack(
    alignment: Alignment.bottomLeft,
    children: [

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
        child: SizedBox(
          width: 180.w,
          child: Card(
            shadowColor: Colors.white, //ToDO
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient:  const LinearGradient(
                      colors: [
                        Color(0xFFe5e5e5),

                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s20),
                        topRight: Radius.circular(AppSize.s20),
                        bottomRight: Radius.circular(AppSize.s20),
                        bottomLeft: Radius.circular(AppSize.s20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: 156.h,
                      width: AppSize.s200,
                      errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        child: const SizedBox(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 8.w,bottom: 4.h),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
          ),
          child: SizedBox(
            width: 171.w,
            height: 30.h,
            child: Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  Text(
                    nameCourse,
                    // style: const TextStyle(
                    //     fontSize: AppSize.s15, fontWeight: FontWeight.w900),
                    style:  TextStyle(
                        fontSize: 10.sp, fontWeight: FontWeight.w900,color: Colors.white,
                  )),
                  const Spacer(),
                  Icon(
                    Icons.star,
                    color: ColorManager.star,
                    size: 15,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 5.w),
                    child: Text(
                      rate,

                      style: TextStyle(color: Colors.white,fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

buildHorizontalListProject(
  BuildContext ctx,
  String image,
  String category,
  String date,
  String location,

) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
    child: Container(
      decoration: BoxDecoration(

      ),
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient:  const LinearGradient(
                  colors: [
                    Color(0xFFe5e5e5),

                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s20),
                      topRight: Radius.circular(AppSize.s20)),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    height: AppSize.s140,
                    width: AppSize.s200,
                    errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                    placeholder: (context, url) => Shimmer.fromColors(

                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade200,

                      child: const SizedBox(
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
              ),
              const SizedBox(height: AppSize.s4),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
                child: Center(
                  child: Text(
                    category,
                    style: const TextStyle(
                        fontSize: AppSize.s16, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

buildHorizontalListMonitor(String image, String name, String id) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
    child: SizedBox(
      width: 180,
      height: 160,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Hero(
              tag: id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  height: 185,
                  width: AppSize.s200,
                  errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                  placeholder: (context, url) => Shimmer.fromColors(

                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade200,

                    child: const SizedBox(
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.grey.shade300,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          width:45 ,height:45 ,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(45)
                          ),
                        ),
                        alignment: Alignment.topCenter,
                        height: AppSize.s200,
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.cloud_off_outlined),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade200,
                          child: Container(
                            height: 200,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(image),
                    // ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

buildRowDetails(IconData iconData, String data) {
  return Row(
    children: [
      Icon(iconData),
      Text(data,
          style: const TextStyle(
            fontSize: AppSize.s16,
          ))
    ],
  );
}
