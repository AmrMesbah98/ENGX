import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widget/homepageWidget.dart';
import '../../bloc/get_project/project_cubit.dart';
import '../../generated/l10n.dart';
import '../../master.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'detailsProject.dart';

class ShowAllProject extends StatefulWidget {
  @override
  State<ShowAllProject> createState() => _ShowAllProjectState();
}

class _ShowAllProjectState extends State<ShowAllProject> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return const Master();
                }));
              },
              icon: const Icon(Icons.arrow_back,color: Colors.black,)

          ),
          iconTheme: const IconThemeData(color: Colors.black54),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
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
          title: Text(
            S.of(context).AllProject,
            style: const TextStyle(fontSize: 25,color: Colors.black54),
          ),
        ),
        body: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            if (state is GetProjectFailure) {
              return Text(state.errMessage);
            } else if (state is GetProjectSuccess) {
              return Container(
                decoration: const BoxDecoration(
                  gradient:   LinearGradient(
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
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 3.2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: state.project.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                              return DetailsProjects(
                                projectModel: state.project[index],
                              );
                            }));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient:   const LinearGradient(
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

                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl: state.project[index].iamge!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                      height: AppSize.s130,
                                      width: AppSize.s200,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.cloud_off_outlined),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor:
                                            Colors.grey.shade200,
                                        child: const SizedBox(
                                          width: 200,
                                          height: 200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.013),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        state.project[index].category!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          fontWeight: FontWeight.bold

                                        ),
                                      ),
                                    ),
                                  ),


                                  /*
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              buildRowDetails(
                                                Icons.calendar_month_sharp,
                                                state.project[index].date!,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: AppSize.s8),
                                          Row(
                                            children: [
                                              buildRowDetails(
                                                Icons.location_on_outlined,
                                                state.project[index].location!,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),



                                   */

                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
