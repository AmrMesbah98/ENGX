
import 'package:asec_application/Constant/constant.dart';
import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../master.dart';
import '../../../model/courses_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../Method_Payment/Support_system.dart';
import 'clarification_Open.dart';
import 'clarification_Saving.dart';

class CategoryPrice extends StatefulWidget {
  const CategoryPrice({super.key});

  @override
  State<CategoryPrice> createState() => _CategoryPriceState();
}

class _CategoryPriceState extends State<CategoryPrice> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constrain){
      if (constrain.maxWidth < 600){

        return Scaffold(
          appBar: AppBar(
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
            centerTitle: true,

            iconTheme: const IconThemeData(color: Colors.black45),
            backgroundColor: ColorManager.white,
            elevation: AppSize.s0,
            title: Text(
              S.of(context).PriceCategory,
              style: TextStyle(color: ColorManager.Black),
            ),
          ),
          body: Container(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.s40,
                      left: AppSize.s15,
                      right: AppSize.s15),
                  child: Container(
                    width: double.infinity,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s15)),
                    height: MediaQuery.of(context).size.height * .75,
                    child: Container(


                      decoration: BoxDecoration(
                          gradient:  const LinearGradient(
                              colors: [
                                Color(0xFFe5e5e5),
                                Color(0xFFFFFFFF),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(AppSize.s15)),


                      child:  Column(
                        children: [
                          CardPrice(
                              image: "assets/images/support.png",
                              lable: S.of(context).Support,
                              details: "for Free",
                              navigator: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const UserProfile();
                                    },
                                  ),
                                );
                              }
                          ),


                          SizedBox(height: MediaQuery.of(context).size.height*.03,),
                          Container(
                              width:  MediaQuery.of(context).size.height*.4,
                              height: MediaQuery.of(context).size.height*.2,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height*.01,),

                                      Text(
                                        S.of(context).attention,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                      Text(
                                        S.of(context).priceDes,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.03,),
                          CardPrice(
                              image: "assets/images/lock.png",
                              lable: S.of(context).Open,
                              details: "${constantvar.paymentPrice}",
                              navigator: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const ClarificationOpen();
                                    },
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient:  const LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(AppSize.s15)),
                  height: MediaQuery.of(context).size.height * .05,
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
      else if (constrain.maxWidth < 900) {


        return Scaffold(
          appBar: AppBar(
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
            centerTitle: true,

            iconTheme: const IconThemeData(color: Colors.black45),
            backgroundColor: ColorManager.white,
            elevation: AppSize.s0,
            title: Text(
              S.of(context).PriceCategory,
              style: TextStyle(color: ColorManager.Black),
            ),
          ),
          body: Container(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.s40,
                      left: AppSize.s15,
                      right: AppSize.s15),
                  child: Container(
                    width: double.infinity,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s15)),
                    height: MediaQuery.of(context).size.height * .75,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient:  const LinearGradient(
                              colors: [
                                Color(0xFFe5e5e5),
                                Color(0xFFFFFFFF),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(AppSize.s15)),


                      child:  Column(
                        children: [
                          CardPrice(
                              image: "assets/images/support.png",
                              lable: S.of(context).Support,
                              details: "for Free",
                              navigator: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const UserProfile();
                                    },
                                  ),
                                );
                              }
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*.03,),
                          Container(
                              width:  MediaQuery.of(context).size.height*.4,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                      Text(
                                        S.of(context).attention,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                      Text(
                                        S.of(context).priceDes,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center,
                                      ),

                                    ],
                                  ),
                                ),
                              )
                          ),
                          CardPrice(
                              image: "assets/images/lock.png",
                              lable: S.of(context).Open,
                              details: "${constantvar.paymentPrice}",
                              navigator: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const ClarificationOpen();
                                    },
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient:  const LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(AppSize.s15)),
                  height: MediaQuery.of(context).size.height * .05,
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
      else{
        return const Center(child: Text("DeskTop"));
      }
        }
    );
  }

}

class CardPrice extends StatelessWidget {
  const CardPrice({super.key, required this.image, required this.lable, required this.details, required this.navigator});

  final String image ;
  final String lable ;
  final String details ;
  final Function() navigator ;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .9,
      child: GestureDetector(
        onTap: navigator,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.width * .47,
          child: Padding(
            padding:  const EdgeInsets.all(AppSize.s8),
            child: Container(
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s15),
                    ),
                    child: Image(
                        image:  AssetImage(image),
                        width: MediaQuery.of(context).size.width * .2,
                        height: MediaQuery.of(context).size.width * .3
                    ),
                  ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       SizedBox(height: MediaQuery.of(context).size.height * .03,),
                       Text(
                           "$lable $details",
                         style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                       ),

                     ],
                   )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

