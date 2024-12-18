import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/values_manager.dart';
import '../whatsUp/whatsuo_Page.dart';

class GoldenMember extends StatelessWidget {
  const GoldenMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Golden Member",style: TextStyle(color: Colors.black54),),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black54),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xffffd700),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xffffd700),
                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
                child: buildGoldenWidget(
                  icon: Icons.workspace_premium,
                  dec1: "Content is unlocked for life ",
                  dec2: "Activated on laptop and android mobile",
                  dec3: " Get Additions every new release",
                  dec4: "Available to star without a task",
                  ctx: context,
                )),
          ),
        ),
      ),
    );
  }
  buildGoldenWidget(
      {
        required IconData icon,
        required String dec1,
        required String dec2,
        required String dec3,
        required String dec4,
        required BuildContext ctx
      }) {
    return Center(
      child: Container(
        width: 320,
        height: 550,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          gradient: const LinearGradient(
              colors: [
                Color(0xffffd700),
                Color(0xFFFFFFFF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,size: 160,color: Colors.yellow[100],),
              const SizedBox(height: 20),
              buildCategoryPayment(dec1),
              const SizedBox(height: 20),
              buildCategoryPayment(dec2),
              const SizedBox(height: 20),
              buildCategoryPayment(dec3),
              const SizedBox(height: 20),
              buildCategoryPayment(dec4),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                        return WhatsUp();
                      }));
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration:  BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius:  BorderRadius.circular(15)
                      ),
                      child: const Center(child: Text("Pay by Whatsapp",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
                        return WhatsUp();
                      }));
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration:  BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius:  BorderRadius.circular(15)
                      ),
                      child: const Center(child: Text("Pay by VISA",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryPayment(
      String name,
      ) {
    return Row(
      children: [
        Icon(
          Icons.star_border_outlined,
          size: 22,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            name,
            style: const TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}



