import 'package:asec_application/presentation/new_Auth/new_login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_container/curved_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared_prefrance/shard_prefrance.dart';
import '../login/intro_chosse.dart';
import '../login/login_view.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingViewApp extends StatefulWidget {
  OnBoardingViewApp({Key? key}) : super(key: key);

  @override
  State<OnBoardingViewApp> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingViewApp> {
  void submit(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      //return const LoginViewApp();
      return const NewLoginPage();
    }));
  }

  var boardController = PageController();

  List<BoardingModel> boarding = [

    BoardingModel(
      image: "assets/images/CVON.png",
      title: 'ENGX',
      body: 'You can now create a CV for yourself showcasing your skills and some of the work you have implemented through your experience',

    ),


    BoardingModel(
      image: "assets/images/news.jpg",
      title: 'ENGX',
      body: 'By publishing articles, you can get responses to everything that is on your mind regarding the educational and technical field',
    ),
    BoardingModel(
      image: "assets/images/cirtificate.png",
      title: 'ENGX',
      body:
          'Now you can obtain your certificate through the application by entering your personal data',
    ),
  ];

  bool islast = false;

  void submitOnBoarding() {
    CacheHelper.saveData(key: 'onBoarding', value: islast);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

        builder: (context, constrain) {

          if (constrain.maxWidth < 600){
            return Scaffold(
                body: Container(
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
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(ImageAssets.splashLogo),
                                    width: AppSize.s40,
                                    height: AppSize.s40,
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text("E", style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                      Text("N", style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                      Text("G", style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                      Text("X", style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                    ],
                                  ),
                                  //Text("ASEC OFFICE",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)
                                ],
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height *.03),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *1,
                              height: MediaQuery.of(context).size.height *.76,
                              child: PageView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: boardController,
                                itemCount: boarding.length,
                                itemBuilder: (context, index) {
                                  return OnBoardingView(
                                      image: boarding[index].image,
                                      title: boarding[index].title,
                                      subTitle: boarding[index].body);
                                },
                                onPageChanged: (int index) {
                                  if (index == boarding.length - 1) {
                                    setState(() {
                                      islast = true;
                                      submitOnBoarding();
                                    });
                                  } else {
                                    islast = false;
                                  }
                                },
                              ),
                            ),

                            Row(
                              children: [
                                SmoothPageIndicator(
                                  effect:   ExpandingDotsEffect(
                                    dotColor: Colors.black26,
                                    activeDotColor: Colors.blue[200]!,
                                    dotHeight: 8,
                                    expansionFactor: 4,
                                    dotWidth: 10,
                                    spacing: 5,
                                  ),
                                  controller: boardController,
                                  count: boarding.length,
                                ),
                                const Spacer(),
                                FloatingActionButton(
                                  backgroundColor: Colors.blue[200]!,
                                  onPressed: () {
                                    if (islast) {
                                      submit(context);
                                    } else {
                                      boardController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 700,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }




          else if(constrain.maxWidth < 900){
            return Scaffold(
                body: Container(
                  height: 1000.h,
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
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(ImageAssets.splashLogo),
                                  width: AppSize.s40,
                                  height: AppSize.s40,
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("E", style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                    Text("N", style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                    Text("G", style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                    Text("X", style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold,), ),
                                  ],
                                ),
                                //Text("ASEC OFFICE",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height *.05),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *1,
                            height: MediaQuery.of(context).size.height *.76,
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: boardController,
                              itemCount: boarding.length,
                              itemBuilder: (context, index) {
                                return OnBoardingView(
                                    image: boarding[index].image,
                                    title: boarding[index].title,
                                    subTitle: boarding[index].body);
                              },
                              onPageChanged: (int index) {
                                if (index == boarding.length - 1) {
                                  setState(() {
                                    islast = true;
                                    submitOnBoarding();
                                  });
                                } else {
                                  islast = false;
                                }
                              },
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height *.05),
                          Row(
                            children: [
                              SmoothPageIndicator(
                                effect:   ExpandingDotsEffect(
                                  dotColor: Colors.black26,
                                  activeDotColor: Colors.blue[200]!,
                                  dotHeight: 8,
                                  expansionFactor: 4,
                                  dotWidth: 10,
                                  spacing: 5,
                                ),
                                controller: boardController,
                                count: boarding.length,
                              ),
                              const Spacer(),
                              FloatingActionButton(
                                backgroundColor: Colors.blue[200]!,
                                onPressed: () {
                                  if (islast) {
                                    submit(context);
                                  } else {
                                    boardController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 700,
                                      ),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                    );
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          }




          else{
            return const Center(child: Text("Desktop"));
          }

        }

    );
  }
}

class OnBoardingView extends StatelessWidget {
  const OnBoardingView(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.02, 0.3],
            ),
          ),
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .07),
        Text(
          subTitle,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
