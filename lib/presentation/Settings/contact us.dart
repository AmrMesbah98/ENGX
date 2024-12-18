import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Contact Us",
          style: TextStyle(color: Colors.black54, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
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
      ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            Image(
              image: const AssetImage("assets/images/logoen.png"),
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .2,
              fit: BoxFit.fill,
            ),
            const ContactUsCard(
              address: "4-ST-Mohamed Makaled\nMostafa El-nahas Naser City",
              //email: "Mepteam@asec.work\nAhmedshuheyb6@gmail.com",
              // phone: "+20 10_133_25_233",
              email: "engxservices@gmail.com\nInfo@acecbim.com",
              phone: "+2010-133-25-233\n+2010-939-60-618",
            ),

            // partner
            /*
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
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey.shade300,
                  ),
                );
              },
            ),
             */

            SizedBox(height: 30.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Partners success",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                SizedBox(height: 10.h),

                //image for maps

                /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlagItem(flagUrl: "https://t4.ftcdn.net/jpg/03/41/32/95/360_F_341329587_wYFQ6umqO5P22azniKcQNPSRzeJfTdMG.jpg"),
                      FlagItem(flagUrl: "https://img.freepik.com/premium-photo/flag-united-arab-emirates-3d-illustration-uae-flag-waving_2227-1860.jpg"),
                      FlagItem(flagUrl: "https://i0.wp.com/www.flagworldinc.com/wp-content/uploads/2023/12/Palestine-Poly-Flag.jpg?fit=853%2C480&ssl=1"),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlagItem(flagUrl: "https://img.freepik.com/free-photo/flag-sudan_1401-230.jpg?size=626&ext=jpg&ga=GA1.1.735520172.1710979200&semt=ais"),
                      FlagItem(flagUrl: "https://v1.cdnpk.net/videvo_files/video/premium/getty_138/thumbnails/istock-1082920560_small.jpg"),
                      FlagItem(flagUrl: "https://www.shutterstock.com/shutterstock/videos/1095844697/thumb/1.jpg?ip=x480"),
                    ],
                  )

                   */

                const Image(image: AssetImage('assets/images/map.png'))
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .05,
              child: const Column(
                children: [
                  Center(
                      child: Text(
                    "ENGX ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  Center(
                      child: Text(
                    "Training Services ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactUsCard extends StatelessWidget {
  const ContactUsCard(
      {super.key,
      required this.address,
      required this.email,
      required this.phone});

  final String address;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .9,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildCard(
              iconData: Icons.location_on_outlined,
              data: address,
            ),
            BuildCard(
              iconData: Icons.email_outlined,
              data: email,
            ),
            BuildCard(
              iconData: Icons.phone,
              data: phone,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({super.key, required this.iconData, required this.data});

  final IconData iconData;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(
              iconData,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            data,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class FlagItem extends StatelessWidget {
  FlagItem({super.key, required this.flagUrl});

  String flagUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 70.w,
      decoration: BoxDecoration(
          color: Colors.white12, borderRadius: BorderRadius.circular(20)),
      child: Image(
        image: NetworkImage(flagUrl),
        fit: BoxFit.fill,
        width: 80.w,
        height: 50.h,
      ),
    );
  }
}
