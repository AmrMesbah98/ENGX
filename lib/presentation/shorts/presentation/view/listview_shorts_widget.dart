import 'package:asec_application/presentation/shorts/presentation/view/shortsVideosPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/components/components.dart';
import '../manager/shorts_cubit.dart';

SizedBox listviewShortsSection() {
  return SizedBox(
    height: 267.h,
    width: double.infinity,
    child: BlocConsumer<ShortsCubit, ShortsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: ShortsCubit.get(context).shortsList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * .47,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image
                      GestureDetector(
                        onTap: () {
                          navigateTo(
                            context,
                            ShortsVideosPage(
                              shortsModel: ShortsCubit.get(context).shortsList,
                              id: ShortsCubit.get(context)
                                  .shortsList[index]
                                  .id!,
                              link: ShortsCubit.get(context)
                                  .shortsList[index]
                                  .link!,
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: ShortsCubit.get(context)
                                .shortsList[index]
                                .image!,
                            //imageUrl: "https://cdn.britannica.com/52/245552-050-3D7334F9/Eiffel-Tower-Paris.jpg?w=400&h=300&c=crop",
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                            width: 200.w,
                            height: 257.h,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.cloud_off_outlined),
                            /*
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[200]!,
                                      child: Container(
                                        width: 150.w,
                                        height: 292.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                        ),
                                      ),
                                    ),

                                 */
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    ),
  );
}
