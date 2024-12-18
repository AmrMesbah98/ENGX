import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/zoomVideo/presentation/manager/zoom_meeting_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShowAllZoomVideo extends StatefulWidget {
  const ShowAllZoomVideo({
    super.key,
  });

  @override
  State<ShowAllZoomVideo> createState() => _ShowAllZoomVideoState();
}

class _ShowAllZoomVideoState extends State<ShowAllZoomVideo> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoomMeetingCubit, ZoomMeetingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constrain) {
          if (constrain.maxWidth < 600) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    toolbarHeight: 30.h,
                    title: const Text(
                      "Zoom Video",
                      style: TextStyle(color: Colors.black54),
                    ),
                    centerTitle: true,
                    bottom: TabBar(
                      tabs: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_call_outlined,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 4.w),
                            const Text(
                              "MEP",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_call_outlined,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 4.w),
                            const Text(
                              "BIM",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Scaffold(
                          body: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                children: [
                                  const Image(
                                      image: AssetImage("assets/images/map.png")),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * .05),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: ZoomMeetingCubit.get(context)
                                          .zoomMeetingList
                                          .length,
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                          physics: const BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 20.h),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    constantvar.idZoomVideoCategory =
                                                    ZoomMeetingCubit.get(context)
                                                        .zoomMeetingList[index]
                                                        .id!;
                                                    ZoomMeetingCubit.get(context)
                                                        .getSecondCategory(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                        const BorderRadius.only(
                                                          bottomRight:
                                                          Radius.circular(10),
                                                          bottomLeft:
                                                          Radius.circular(60),
                                                          topLeft:
                                                          Radius.circular(60),
                                                          topRight:
                                                          Radius.circular(10),
                                                        )),
                                                    child: Row(
                                                      children: [
                                                        /*
                                              const CircleAvatar(
                                                radius: 40,
                                                backgroundImage: AssetImage(
                                                  "assets/images/person22.png",
                                                ),
                                                backgroundColor: Colors.white,
                                              ),

                                               */

                                                        Container(
                                                          child: GestureDetector(
                                                            child: Container(
                                                              width: 80.h,
                                                              height: 80.h,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      80)),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(80),
                                                                child:
                                                                CachedNetworkImage(
                                                                  imageUrl: ZoomMeetingCubit
                                                                      .get(
                                                                      context)
                                                                      .zoomMeetingList[
                                                                  index]
                                                                      .image!,
                                                                  fit: BoxFit.cover,
                                                                  alignment: Alignment
                                                                      .topCenter,
                                                                  height: 110.h,
                                                                  width: 200.w,
                                                                  errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .cloud_off_outlined),
                                                                  placeholder: (context,
                                                                      url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                        baseColor: Colors
                                                                            .grey
                                                                            .shade400,
                                                                        highlightColor:
                                                                        Colors.grey
                                                                            .shade200,
                                                                        child: SizedBox(
                                                                          width: 200.w,
                                                                          height: 200.h,
                                                                        ),
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 65.w),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            // Name

                                                            // title
                                                            Text(
                                                              ZoomMeetingCubit.get(
                                                                  context)
                                                                  .zoomMeetingList[
                                                              index]
                                                                  .title!,
                                                              style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                            ),
                                                            SizedBox(height: 10.h),
                                                            Row(
                                                              children: [
                                                                const Icon(Icons
                                                                    .mic_none_outlined),
                                                                SizedBox(width: 3.w),
                                                                Text(
                                                                  ZoomMeetingCubit
                                                                      .get(
                                                                      context)
                                                                      .zoomMeetingList[
                                                                  index]
                                                                      .name!,
                                                                  style: TextStyle(
                                                                      fontSize: 15.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Scaffold(
                        body: Container(
                          child: const Center(
                            child: Image(
                                image: AssetImage("assets/images/empty.png")),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            );
          } else if (constrain.maxWidth < 900) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    toolbarHeight: 30.h,
                    title: const Text(
                      "Zoom Video",
                      style: TextStyle(color: Colors.black54),
                    ),
                    centerTitle: true,
                    bottom: TabBar(
                      tabs: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_call_outlined,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 4.w),
                            const Text(
                              "MEP",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_call_outlined,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 4.w),
                            const Text(
                              "BIM",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Scaffold(
                          body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              const Image(
                                  image: AssetImage("assets/images/map.png")),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: ZoomMeetingCubit.get(context)
                                      .zoomMeetingList
                                      .length,
                                  itemBuilder: (context, index) {
                                    return SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20.h),
                                            child: GestureDetector(
                                              onTap: () {
                                                constantvar.idZoomVideoCategory =
                                                    ZoomMeetingCubit.get(context)
                                                        .zoomMeetingList[index]
                                                        .id!;
                                                ZoomMeetingCubit.get(context)
                                                    .getSecondCategory(context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(60),
                                                      topLeft:
                                                          Radius.circular(60),
                                                      topRight:
                                                          Radius.circular(10),
                                                    )),
                                                child: Row(
                                                  children: [
                                                    /*
                                              const CircleAvatar(
                                                radius: 40,
                                                backgroundImage: AssetImage(
                                                  "assets/images/person22.png",
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
              
                                               */
              
                                                    Container(
                                                      child: GestureDetector(
                                                        child: Container(
                                                          width: 80.h,
                                                          height: 80.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          80)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(80),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: ZoomMeetingCubit
                                                                      .get(
                                                                          context)
                                                                  .zoomMeetingList[
                                                                      index]
                                                                  .image!,
                                                              fit: BoxFit.cover,
                                                              alignment: Alignment
                                                                  .topCenter,
                                                              height: 110.h,
                                                              width: 200.w,
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .cloud_off_outlined),
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Shimmer
                                                                      .fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade400,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade200,
                                                                child: SizedBox(
                                                                  width: 200.w,
                                                                  height: 200.h,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 65.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // Name
              
                                                        // title
                                                        Text(
                                                          ZoomMeetingCubit.get(
                                                                  context)
                                                              .zoomMeetingList[
                                                                  index]
                                                              .title!,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        Row(
                                                          children: [
                                                            const Icon(Icons
                                                                .mic_none_outlined),
                                                            SizedBox(width: 3.w),
                                                            Text(
                                                              ZoomMeetingCubit
                                                                      .get(
                                                                          context)
                                                                  .zoomMeetingList[
                                                                      index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Scaffold(
                        body: Container(
                          child: const Center(
                            child: Image(
                                image: AssetImage("assets/images/empty.png")),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            );
          } else {
            return const Center(child: Text("DeskTop"));
          }
        });
      },
    );
  }
}
