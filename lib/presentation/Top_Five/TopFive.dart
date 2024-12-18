import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/values_manager.dart';


/*
buildCircleAvatar(String image) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: NetworkImage(image),
    ),
  );
}

 */

class CircleAvatarUI extends StatelessWidget {
   const CircleAvatarUI({super.key, required this.image, required this.id});

  final String image;
  final String id;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.009),
      child: Container(
        width: 55.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: Colors.grey.shade300,
        ),
        child: Hero(
          tag: id,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width:80 ,height:80 ,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(70)
              ),
            ),
            alignment: Alignment.topCenter,
            height: AppSize.s100,
            errorWidget: (context, url, error) =>
                const Icon(Icons.cloud_off_outlined),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade200,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.grey.shade300,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CircleAvatarUITablet extends StatelessWidget {
  const CircleAvatarUITablet({super.key, required this.image, required this.id});

  final String image;
  final String id;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.009),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: Colors.grey.shade300,
        ),
        child: Hero(
          tag: id,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width:80 ,height:80 ,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(70)
              ),
            ),
            alignment: Alignment.topCenter,
            height: AppSize.s100,
            errorWidget: (context, url, error) =>
            const Icon(Icons.cloud_off_outlined),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade200,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.grey.shade300,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
