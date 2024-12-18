import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../generated/l10n.dart';
import '../../master.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class WhatsUp extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constrain){
          if (constrain.maxWidth < 600){


            return Scaffold(
              appBar: AppBar(
                elevation: 0,
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
                iconTheme: IconThemeData(color: Colors.black),
                title: Text(
                  S.of(context).contactUs,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Stack(children: [
                Container(
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
                  child: SafeArea(
                    child: ListView(
                      children: [
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage(ImageAssets.Backgroundimagelogin2),
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(AppSize.s16),
                          child: TextFormField(
                            decoration: InputDecoration(
                              label: Text(
                                S.of(context).message,
                              ),
                              hintText: 'Write message and send to me to open chat',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)
                              ),

                            ),
                            controller: textEditingController,
                            maxLines: 9,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                            value!.isEmpty ? 'Email cannot be blank' : null,
                          ),
                        ),
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (textEditingController.text == '') {
                                    showSnackbar(
                                        error: 'Enter Your Message', context: context);
                                  } else {
                                    launchWhatsApp();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).OpenChat,
                                      style: const TextStyle(fontSize: 25, color: Colors.black),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );



          }
          else if (constrain.maxWidth < 900){

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
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
                iconTheme: IconThemeData(color: Colors.black),
                title: Text(
                  S.of(context).contactUs,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              body: Stack(children: [
                Container(
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
                  child: SafeArea(
                    child: ListView(
                      children: [
                        SizedBox(height: 100.h),
                         Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/images/map.png"),
                              width: 300.w,
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(AppSize.s16),
                          child: TextFormField(
                            decoration: InputDecoration(
                              label: Text(
                                S.of(context).message,
                              ),
                              hintText: 'Write message and send to me to open chat',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)
                              ),

                            ),
                            controller: textEditingController,
                            maxLines: 9,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                            value!.isEmpty ? 'Email cannot be blank' : null,
                          ),
                        ),
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            width: 220,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (textEditingController.text == '') {
                                    showSnackbar(
                                        error: 'Enter Your Message', context: context);
                                  } else {
                                    launchWhatsApp();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).OpenChat,
                                      style: const TextStyle(fontSize: 25, color: Colors.black),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );

          }
          else {
            return const Center(child: Text("DeskTop"));
          }
        }
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  showSnackbar({error, context}) {
    final snackBar = SnackBar(
      content: Text(
        error,
        style: TextStyle(fontSize: 22),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+201093460618',
      text: textEditingController.text,
    );
    await launch('$link');
  }
}
