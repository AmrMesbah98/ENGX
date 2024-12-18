import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/get_project/project_cubit.dart';

class ItemProjectCard extends StatelessWidget {
   ItemProjectCard({
    super.key,
    required this.image,
    required this.category,
    required this.date,
    required this.details,
    required this.location,
    required this.photo,
    required this.id,
  });


  String image;
  String category;
  String date;
  String details;
  String id;
  String location;
  List  photo;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .26,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 4,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.width * .35,
                      errorWidget: (context,url,error)=>const Icon(Icons.cloud_off_outlined),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        child:  SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.width * .3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      id,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
