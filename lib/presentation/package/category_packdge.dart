
import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/presentation/package/save_pay_detials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/l10n.dart';
import '../../../master.dart';
import '../../../model/courses_model.dart';

import '../../shared/components/components.dart';
import '../courses/Method_Payment/Support_system.dart';
import '../courses/price/clarification_Open.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'open_pay_detials.dart';


class CategoryPricePackdge extends StatefulWidget {
  const CategoryPricePackdge({super.key});

  @override
  State<CategoryPricePackdge> createState() => _CategoryPricePackdgeState();
}

class _CategoryPricePackdgeState extends State<CategoryPricePackdge> {
  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const Master();
            }));
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.05),
            Padding(
              padding:  EdgeInsets.only(
                  top: 20.h,
                  left: AppSize.s15,
                  right: AppSize.s15),
              child: Container(
                width: double.infinity,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s15)),

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

                      CardPrice(
                          image: "assets/images/save.png",
                          lable: S.of(context).Saving,
                          details: constantvar.halfPaymentPrice,
                          navigator: (){

                            navigateTo(context, const SavePayPackage());
                          }
                      ),

                      CardPrice(
                          image: "assets/images/lock.png",
                          lable: S.of(context).Open,
                          details: constantvar.paymentPrice,
                          navigator: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return const OpenPayPackage();
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
          height: MediaQuery.of(context).size.width * .37,
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
                        height: MediaQuery.of(context).size.width * .25
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .02,),
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

