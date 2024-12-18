import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';
import '../presentation/resources/color_manager.dart';
import '../presentation/resources/values_manager.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black54),
        title: Text(
          S.of(context).DeveloperTeam,
          style: TextStyle(color: ColorManager.Black,fontSize: 18.sp),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:   Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ItemCardTeam(
                  name: "Amr Mesbah",
                  track: "Flutter Developer",
                  phone: "+20-1124753420 / +20-1030780936",
                  email: "amrmesbah33@gmail.com",
                  experience: "Experience +4 Year",
                  image: "assets/images/amr.png"
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s15)),

                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text("All rights reserved for ",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)),
                        Center(child: Text("Amr Mesbah",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.red),)),

                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}



class ItemCardTeam extends StatelessWidget {
  const ItemCardTeam({super.key, required this.name, required this.track, required this.phone, required this.email, required this.experience, required this.image});


  final String name;
  final String track;
  final String phone;
  final String email;
  final String experience;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [


        SizedBox(height: MediaQuery.of(context).size.height *.02),

        Opacity(
          opacity: .8,
          child: Container(
            width: MediaQuery.of(context).size.width *1,
            height: MediaQuery.of(context).size.height *.06,
            decoration:  const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                color:  Color(0xff123265)
            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Text(name,style:  TextStyle( fontWeight: FontWeight.w700 ,fontSize: 20.sp, color: Colors.white),),
            ),
          ),
        ),

        Opacity(
          opacity: .95,
          child: Container(
            width: MediaQuery.of(context).size.width *1,

            decoration:  const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(AppSize.s10),
                    bottomLeft: Radius.circular(AppSize.s10)
                ),

            ),
            child:  Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [

                          Text(track,style:  TextStyle(fontSize: 16.sp,color: Colors.black54,fontWeight: FontWeight.bold),),
                        ],
                      ),
                       SizedBox(height: 7.h),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              const Icon(Icons.phone,color: Colors.black,size: 20,),
                              const SizedBox(width: 10),
                              Text(phone,style:  TextStyle(fontSize: 13.sp,color: Colors.black54,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined,color: Colors.black,size: 20,),
                              const SizedBox(width: 10),
                              Text(email,style:  TextStyle(fontSize: 13.sp,color: Colors.black54,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.account_balance_outlined,color: Colors.black,size: 20,),
                              const SizedBox(width: 10),
                              Text(experience,style:  TextStyle(fontSize: 13.sp,color: Colors.black54,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                   
                   
                   


                ],
              ),
            ),
          ),
        ),

        ClipRRect(
          borderRadius:  BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width *.8,
            height: MediaQuery.of(context).size.height *.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Image(
              
              image: AssetImage(image),
              fit: BoxFit.cover,
          
            ),
          ),
        ),

      ],
    );
  }
}



