import 'package:asec_application/Widget/customTextFormField.dart';
import 'package:asec_application/bloc/post/post_cubit.dart';
import 'package:asec_application/model/post_model.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ADS/ads.dart';
import '../../Constant/constant.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../master.dart';
import 'Post_Page.dart';

class CreatePost extends StatefulWidget {
  CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  BannerAd? bannerAd;

  bool isLoaded =false;

  void load()
  {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AddManger.bannerOne,
        listener: BannerAdListener(
            onAdLoaded: (ad)
            {
              setState(() {
                isLoaded = true;
              });
            },
            onAdFailedToLoad: (ad,error)
            {
              ad.dispose();
            }
        ),
        request: AdRequest()
    )..load();
  }


  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAppInformationCubit, UserInformationState>(
      listener: (context, state) {},
      builder: (context, state) {

        if(state is LoadingInformationState)
          {
            return const CircularProgressIndicator();
          }
        var info = UserAppInformationCubit.get(context).applicationUser;
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            elevation: 0,
            backgroundColor: Colors.white,
            title:  Text(
              "Create Post",
              style: TextStyle(color: Colors.black,fontSize: 17.sp),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  PostModel model = PostModel(
                      name: "${info!.firstName} ${info.lastName}",
                      postTitle: titleController.text,
                      postDescription: descriptionController.text,
                      comment: "not Now",
                      isShow: false
                  );
                  PostCubit.get(context).setPostFunction(
                      data: model.toJson(),
                      uid: FirebaseAuth.instance.currentUser!.uid

                  ).then((value) {

                    navigateTo(context,  const Master());

                    print("Post Done");

                    PostCubit.get(context).getPostFunction();
                    PostCubit.get(context).getFinalPostFunction();

                    navigateTo(context, const Master());
                  });
                },
                child:  Text(
                  "Post",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                //row for logo and name user

                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/ASEC.png"),
                        radius: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                          "${info!.firstName} ${info.lastName}",
                          style:  TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),

                //for title textFormField
                /*
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration:  InputDecoration(

                      hintText: "Title",
                      border: InputBorder.none,

                    ),
                    controller: titleController,
                    validator: (val) {
                      if (val == null) {
                        return "Please Enter your post";
                      }
                    },
                  ),
                ),

                 */

                //for description textFormField

                TextFormField(
                  maxLines: 10,
                  cursorColor: Colors.black,
                  controller: descriptionController,
                  decoration:  InputDecoration(

                      hintText: "What is in your mind ${info.firstName}",
                      border: InputBorder.none,

                  ),
                  validator: (val) {
                    if (val == null) {
                      return "Please Enter your post";
                    }
                  },
                ),


                // ADS
                Spacer(),

                Center(
                    child: isLoaded ?  SizedBox(
                      width: bannerAd!.size.width.toDouble(),
                      height: bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: bannerAd!),
                    ):SizedBox()
                ),




              ],
            ),
          ),
        );
      },
    );
  }
}
