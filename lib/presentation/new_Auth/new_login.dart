import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/core/new_customTextFormField_forLogin.dart';
import 'package:asec_application/presentation/new_Auth/presentation/manager/id_signin_with_google_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../bloc/Auth/auth_cubit.dart';
import '../../master.dart';
import 'new_forgetPassword.dart';
import 'new_register.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<NewLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late FirebaseAuth _mAuth;
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool ischecked = false;

  @override
  void initState() {
    IdSigninWithGoogleCubit.get(context).getId();
    _mAuth = FirebaseAuth.instance;
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
    _passwordVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: BlocConsumer<IdSigninWithGoogleCubit, IdSigninWithGoogleState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<AuthCubit, AuthState>(
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
                    /*
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFe5e5e5),
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
                    SingleChildScrollView(
                      child: Form(
                        key: key,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),

                              Opacity(
                                opacity: .8,
                                child: Image(
                                  image: const AssetImage(
                                      "assets/images/ASEC.png"),
                                  width:
                                      MediaQuery.of(context).size.width * .38,
                                  height:
                                      MediaQuery.of(context).size.height * .19,
                                  fit: BoxFit.fill,
                                ),
                              ),

                              SizedBox(height: 15.h),

                              Text(
                                "Hello! Welcome",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    //color: Color(0xff1B98D2),
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Select method to sign in",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 40,
                              ),

                              //email
                              NewCustomTextFormFieldForLogin(
                                label: "Email",
                                controller: EmailController,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  size: 20,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),

                              SizedBox(height: 20.h),

                              //password
                              NewCustomTextFormFieldForLogin(
                                label: "Password",
                                controller: PasswordController,
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: _passwordVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                                keyboardType: TextInputType.visiblePassword,
                                obsocure: _passwordVisible,
                              ),

                              Row(children: [
                                Checkbox(
                                    side: const BorderSide(
                                      width: 2,
                                      color: Color(0xff212121),
                                    ),
                                    // checkColor: Color(0xff000000),
                                    value: ischecked,
                                    onChanged: (checked) {
                                      setState(() {
                                        ischecked = checked!;
                                      });
                                    }),
                                Text(
                                  "Remember me",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return const NewForgetPasswordPage();
                                    }));
                                  },
                                  child: const Text(
                                    "Forget Password ?",
                                    style: TextStyle(
                                        color: Color(0xff0B3F5D),
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ]),

                              const SizedBox(
                                height: 35,
                              ),

                              //button login
                              SizedBox(
                                width: 300,
                                child: BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthLoadingState) {
                                      return SizedBox(
                                        width: 100,
                                        child: Center(
                                          child: LoadingAnimationWidget
                                              .staggeredDotsWave(
                                            color: Color(0xFF6AC1C9),
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (key.currentState!.validate()) {
                                            AuthCubit.get(context)
                                                .Login(
                                                    context,
                                                    EmailController.value.text,
                                                    PasswordController
                                                        .value.text)
                                                .then((value) async {});
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 17,
                                          backgroundColor:
                                              const Color(0xff1B98D2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          fixedSize: const Size(350, 50),
                                        ),
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 110.w,
                                    child: const Divider(
                                      color: Color(0xff000000),
                                      indent: 15,
                                      height: 11,
                                      endIndent: 7,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //  width: 10,
                                  //),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "or continue with",
                                    style: TextStyle(color: Color(0xff000000)),
                                  ),
                                  SizedBox(
                                    width: 110.w,
                                    child: const Divider(
                                      color: Color(0xff000000),
                                      indent: 15,
                                      height: 11,
                                      endIndent: 6,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 33.h,
                              ),
                              //for social
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //facebook
                                  /*
                                  GestureDetector(
                                    onTap: ()  {
                                      signInWithFacebook();
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1,
                                              offset: Offset(1, 3),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color(0xffFFFFFF),
                                        ),
                                        width: 65,
                                        height: 45,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/facebook_5968764.png',
                                            scale: 20,
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 29,
                                  ),

                                   */
                                  //google
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1,
                                              offset: Offset(1, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffFFFFFF),
                                        ),
                                        width: 65,
                                        height: 45,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/1298745_google_brand_branding_logo_network_icon.png',
                                            scale: 20,
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 29,
                                  ),
                                  //apple
                                  InkWell(
                                    onTap: () {
                                      const snackBar = SnackBar(
                                        content: Text('Soon...'),
                                        backgroundColor: Colors.blue,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1,
                                              offset: Offset(1, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffFFFFFF),
                                        ),
                                        width: 65,
                                        height: 45,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/104490_apple_icon.png',
                                            scale: 20,
                                          ),
                                        )),
                                  )
                                ],
                              ),

                              SizedBox(
                                height: 30.h,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account ?",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              context, NewRegisterPage());
                                        },
                                        child: Text("Sign Up",
                                            style: TextStyle(
                                                color: const Color(0xff0B3F5D),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
          );
        },
      )),
    );
  }

  addIdToUserWithGoogleCollection() {
    FirebaseFirestore.instance
        .collection('User With Google')
        .doc("IAQ2iUMDHFsLPOlw2h9Z")
        .update({
      'idList': FieldValue.arrayUnion([constantvar.idUserOfGoogle]),
    }).then((value) {
      print(" uid with google ============>>>>>>>>>>>>>>>> is add to list");
    });
  }

/*
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

 */
}
