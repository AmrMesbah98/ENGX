import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/Auth/auth_cubit.dart';
import '../../master.dart';
import '../resources/values_manager.dart';
import 'customTextFormField.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late FirebaseAuth _mAuth;
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController resendPassword = TextEditingController();

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;
    resendPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    resendPassword.dispose();
    super.dispose();
  }

  void clear() {
    resendPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Restart Password",
              style: TextStyle(color: Colors.black54),
            ),
            centerTitle: true,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFFe5e5e5),
                      Color(0xFFFFFFFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                /*
                gradient:   LinearGradient(
                    colors: [
                      Color(0xFF88b7eb),

                      Color(0xFFFFFFFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),

                 */
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessUserState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Master()),
                    (Route<dynamic> route) => false);
              }
            },
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFe5e5e5),
                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  /*
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF88b7eb),
                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),

               */
                ),
                child: SafeArea(
                  child: Stack(children: [
                    Form(
                      key: key,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: .8,
                              child: Image(
                                image:
                                    const AssetImage("assets/images/ASEC.png"),
                                width: MediaQuery.of(context).size.width * .4,
                                height: MediaQuery.of(context).size.width * .4,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: AppSize.s40),
                            CustomTextFormField(
                              label: "Email",
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              controller: resendPassword,
                              secure: false,
                              colorIcon: Colors.black,
                              maxLine: 1,
                            ),
                            const SizedBox(height: AppSize.s30),
                            SizedBox(
                                width: 300,
                                child: ElevatedButton.icon(
                                  label: Text(
                                    'Restart Password',
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.black54),
                                  ),
                                  icon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey[200])
                                      // backgroundColor: MaterialStateProperty.all(Colors.blue[100])
                                      ),
                                  onPressed: () async {
                                    if (key.currentState!.validate()) {
                                      try {
                                        await _mAuth
                                            .sendPasswordResetEmail(
                                                email: resendPassword.text)
                                            .then((value) {
                                          print("done");
                                          clear();

                                          var snackBar = SnackBar(
                                            content: Text(
                                              "Success Restart Password",
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        print(e);

                                        var snackBar = SnackBar(
                                          content: Text(
                                            "$e",
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
          )),
    );
  }
}
