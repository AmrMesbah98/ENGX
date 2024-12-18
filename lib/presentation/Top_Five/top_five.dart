import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/Top_FIveModel.dart';
import '../resources/color_manager.dart';


class TopFivePage extends StatelessWidget {
   TopFivePage({super.key, required this.topFiveModel});

   TopFiveModel topFiveModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.Black),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
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
        ),
        title: Text(
          topFiveModel.name!,
          style: const TextStyle(color: Colors.black),
        ),
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
        child: ListView(
          children: [
            Hero(
              tag: topFiveModel.id!,
              child: CachedNetworkImage(
                imageUrl: topFiveModel.image!,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height * .38, // 2.8
                width: double.infinity,
                errorWidget: (context, url, error) =>
                const Icon(Icons.cloud_off_outlined),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
