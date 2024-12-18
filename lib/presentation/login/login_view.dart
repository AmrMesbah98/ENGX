
import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/get_information/user_information_cubit.dart';
import 'package:asec_application/presentation/login/passwordTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../bloc/Auth/auth_cubit.dart';
import '../../master.dart';
import '../register/register_view.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import 'customTextFormField.dart';
import 'forgetpassword.dart';

class LoginViewApp extends StatefulWidget {
  const LoginViewApp({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginViewApp> {
  late FirebaseAuth _mAuth;
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
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
                ),
                child: SafeArea(
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Form(
                        key: key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .2,
                                decoration:  BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(800),
                                      bottomRight: Radius.circular(0),

                                    )
                                ),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign In",
                                      style: TextStyle(fontSize: 20.sp,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      "            By using our services you are agreeing to our Terms and privacy statement ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: AppSize.s20),

                            Opacity(
                              opacity: .8,
                              child: Image(
                                image: const AssetImage(
                                    "assets/images/ASEC.png"),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .45,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .18,

                                fit: BoxFit.fill,
                              ),
                            ),

                            const SizedBox(height: AppSize.s20),


                            Padding(
                              padding:   EdgeInsets.symmetric(horizontal: 16.w),
                              child: SizedBox(
                                height: 45.h,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    label:  Text("Email",style: TextStyle(fontSize: 15.sp),),
                                    labelStyle: TextStyle(color: Colors.black),

                                    prefixIcon: const Icon(Icons.person,color: Colors.black,size: 20,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: EmailController,

                                ),
                              ),
                            ),

                             SizedBox(height: 20.h),
                            CustomPasswordField(
                              label: "Password",
                              icon: Icons.lock,

                              keyboardType: TextInputType.visiblePassword,
                              controller: PasswordController,
                              secure: true,
                            ),

                             SizedBox(height: 3.h),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_){
                                        return const ForgetPasswordPage();
                                      }));
                                    },
                                    child:  Text("Forget Password ?", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),),
                                  )
                                ],
                              ),
                            ),


                             SizedBox(height: 55.h),
                            SizedBox(
                              width: 300,
                              child: BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoadingState) {
                                    return CircularProgressIndicator(
                                      color: Colors.black54,
                                    );
                                  }
                                  return ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.grey[200])
                                      ),
                                      onPressed: () async {
                                        if (key.currentState!.validate()) {

                                          AuthCubit.get(context)
                                              .Login(
                                              context,
                                              EmailController.value.text,
                                              PasswordController.value.text)
                                              .then((value) async {


                                              }

                                       );
                                        }
                                      },
                                      child:  Text(
                                        'Login',
                                        style: TextStyle(fontSize: 20.sp,color: Colors.black54,),
                                      ));
                                },
                              ),
                            ),
                             SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppStrings.RegisterTextforaccount,
                                    style: TextStyle(fontSize: 12.sp)),
                                 SizedBox(width: 5.w),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                          return RegisterView();
                                        }));
                                  },
                                  child: Text(AppStrings.Registerforaccount,
                                      style:
                                      TextStyle(
                                          fontSize: 15.sp, color: Colors.blue)),
                                ),
                              ],
                            ),
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
