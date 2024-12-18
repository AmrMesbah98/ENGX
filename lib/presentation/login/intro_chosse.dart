import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../register/register_view.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'login_view.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/images/ASEC.png"),
                    width: double.infinity,
                    height: 300,
                  ),
                  const Text(
                    "Hello !",
                    style: TextStyle(
                        fontSize: 60,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSize.s20),
                  const Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSize.s30),
                  Container(

                    width: 250,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2E2EFF),
                            Color(0xFF0000A3),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),

                                ))),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const LoginViewApp();
                          }));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, color: ColorManager.white),
                        )),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Container(

                    width: 250,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF2E2E),
                            Color(0xFFA30000),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const RegisterView();
                          }));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 30, color: ColorManager.white),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
