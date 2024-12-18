import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../Widget/homepageWidget.dart';
import '../../model/project_model.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../whatsUp/whatsuo_Page.dart';
import 'order_project.dart';

class DetailsProjects extends StatefulWidget {
  DetailsProjects({super.key, required this.projectModel});

  final ProjectModel projectModel;

  @override
  State<DetailsProjects> createState() => _DetailsProjectsState();
}

class _DetailsProjectsState extends State<DetailsProjects> {
  bool isExpanded = true;

  bool isExpanded2 = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.projectModel.category!,
              style: TextStyle(color: ColorManager.Black),
            ),
            centerTitle: true,
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
            elevation: 0,
            backgroundColor: ColorManager.white,
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 1.2,
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  // image
                  Container(
                    child: buildDetailsProjectScreen(
                      context,
                      widget.projectModel.photo!,
                    ),
                  ),
                  // category
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: Text(
                      widget.projectModel.category!,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        child: buildRowDetails(
                          Icons.calendar_month,
                          widget.projectModel.date!,
                        ),
                        padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s12),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s12),
                        child: buildRowDetails(
                          Icons.location_on_outlined,
                          widget.projectModel.location!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.02),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: buildRowDetails(
                      Icons.person_2_outlined,
                      "Client : ${widget.projectModel.clientName!}",
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.read_more),
                          Text(
                            " Area : ${widget.projectModel.area!}",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.02),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text(
                            "WorkScope",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                            width: double.infinity,

                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                                itemCount: widget.projectModel.workScope!.length,
                                itemBuilder: (context,index)
                              {
                                return Padding(
                                padding: const EdgeInsets.all(8.0),
                              child: Row(
                              children: [
                              Icon(Icons.star_border_outlined,size: 20,color: Colors.grey,),
                              SizedBox(width: 6),
                              Expanded(
                              child: Text(
                              widget.projectModel
                                  .workScope![index],
                              style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black),
                              ),
                              ),
                              ],
                              ));
                              }
                            ),
                      ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height *.02),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Design By :",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.02),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: widget.projectModel.designBy!.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 40,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.star_border_outlined,color: Colors.grey,),
                                    SizedBox(height: MediaQuery.of(context).size.height *.01),
                                    Text(
                                      widget.projectModel.designBy![index],
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(AppSize.s20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                                  return WhatsUp();
                                }));
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .4,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width * .12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green[200]),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: AppSize.s30,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                                  return const OrderProject();
                                }));
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .4,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width * .12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[100]
                            ),
                            child: const Center(
                                child: Text(
                                  "Your Order",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  buildDetailsProjectScreen(BuildContext ctx,
      List item,) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: CarouselSlider(
          items: item.map((e) {
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: e,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  height: AppSize.s190,
                  width: double.infinity,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.cloud_off_outlined),
                  placeholder: (context, url) =>
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        child: const SizedBox(
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                ),
              ],
            );
          }).toList(),
          options: CarouselOptions(
            height: 250,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            // autoPlay: true,
            // enlargeCenterPage: true,
            // autoPlayAnimationDuration: const Duration(milliseconds: 500),
            // viewportFraction: 0.8,
            // aspectRatio: 1.0,
            // initialPage: 2,
          ),
        ),
      ),
    );
  }
}
