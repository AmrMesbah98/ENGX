
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/Get_Partners/partners_cubit.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'buildInfoScreen.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                  colors: [
                    Color(0xFF5899E2),

                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "Personal Information",
            style: TextStyle(color: ColorManager.Black),
          ),
        ),
        body: BlocConsumer<UserAppInformationCubit, UserInformationState>(

            listener: (context, state) {},
            builder: (context, state) {
             return SafeArea(
               child: Container(
                 decoration: const BoxDecoration(
                   gradient:  LinearGradient(
                       colors: [
                         Color(0xFF5899E2),

                         Color(0xFFFFFFFF),
                       ],
                       begin: FractionalOffset(0.0, 0.0),
                       end: FractionalOffset(1.0, 0.0),
                       stops: [0.0, 1.0],
                       tileMode: TileMode.clamp),
                 ),
                 child: ListView(
                    children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                       height: 200.0,
                       width: 200.0,
                       decoration: const BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage(
                               "assets/images/ASEC.png"),
                           fit: BoxFit.fill,
                         ),
                         shape: BoxShape.circle,
                       ),
                 ),
                     ],
                   ),

                      BuildInfoScreen(
                        firstName: UserAppInformationCubit.get(context).applicationUser!.firstName,
                        lastname: UserAppInformationCubit.get(context).applicationUser!.lastName,
                        email: UserAppInformationCubit.get(context).applicationUser!.email,
                        phone: UserAppInformationCubit.get(context).applicationUser!.phone,
                        address: UserAppInformationCubit.get(context).applicationUser!.address,
                        position: UserAppInformationCubit.get(context).applicationUser!.position,
                        type: UserAppInformationCubit.get(context).applicationUser!.type,
                      ),
                      BlocBuilder<PartnersCubit, PartnersState>(
                        builder: (context, state) {
                          if (state is PartnersError) {
                            return Text(state.errMessage);
                          }
                          else if (state is PartnersSuccess) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.partners.length,
                                  itemBuilder: (context, index) {
                                    return CircleAvatarUIInfo(
                                        image: state
                                            .partners[index]
                                            .images!,
                                        id: state
                                            .partners[index]
                                            .id!);
                                  }),
                            );
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.blue.shade300,
                            highlightColor: Colors.blue.shade100,
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.blue.shade300,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s15)),

                        child: const Column(
                          children: [
                            Center(child: Text("ASEC ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                            Center(child: Text("BIM Engineering ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                          ],
                        ),
                      )



                    ],
                  ),
               ),
             );
            }
            )
    );
  }
}


class CircleAvatarUIInfo extends StatelessWidget {
  const CircleAvatarUIInfo({super.key, required this.image, required this.id});

  final String image;
  final String id;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 83,
        height: 83,
        decoration: const BoxDecoration(
        ),
        child: Hero(
          tag: id,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width:83 ,height:83 ,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            alignment: Alignment.topCenter,
            height: AppSize.s200,
            errorWidget: (context, url, error) =>
            const Icon(Icons.cloud_off_outlined),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.blue.shade400,
              highlightColor: Colors.blue.shade200,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.blue.shade300,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}