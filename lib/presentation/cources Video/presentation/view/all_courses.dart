import 'package:asec_application/Constant/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


import '../manager/get_courses_cubit.dart';

class ShowAllCoursesVideo extends StatefulWidget {
  const ShowAllCoursesVideo({
    super.key,
  });

  @override
  State<ShowAllCoursesVideo> createState() => _ShowAllCoursesVideoState();
}

class _ShowAllCoursesVideoState extends State<ShowAllCoursesVideo> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCoursesVideoCubit, CoursesState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
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
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'All courses',
            //S.of(context).AllCourses,
            style:  TextStyle(fontSize: 25.sp, color: Colors.black54),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2.8,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount:
                          GetCoursesVideoCubit.get(context).coursesModelList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            constantvar.idCategory = GetCoursesVideoCubit.get(context)
                                .coursesModelList[index]
                                .id!;
                            constantvar.promoCode = GetCoursesVideoCubit.get(context)
                                .coursesModelList[index]
                                .promoCode!;
                            constantvar.nameCourse = GetCoursesVideoCubit.get(context)
                                .coursesModelList[index]
                                .title!;
                            GetCoursesVideoCubit.get(context)
                                .getSecondCategory(context);
                          },
                          child: Card(
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFe5e5e5),
                                        Color(0xFFFFFFFF),
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: GetCoursesVideoCubit.get(context)
                                          .coursesModelList[index]
                                          .image!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                      height: 110.h,
                                      width: 200.w,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.cloud_off_outlined),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade200,
                                        child: SizedBox(
                                          width: 200.w,
                                          height: 200.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          .015),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Center(
                                      child: Text(
                                        GetCoursesVideoCubit.get(context)
                                            .coursesModelList[index]
                                            .title!,
                                        //  DummyAllCourses[index].nameCourse,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  },
);
  }
}
