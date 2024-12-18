import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get_courses/courses_cubit.dart';
import '../../model/courses_model.dart';
import '../courses/price/category_price.dart';
import '../login/customTextFormField.dart';

class RegisterScreenPackage extends StatefulWidget {
  const RegisterScreenPackage({
    super.key,
  });

  @override
  State<RegisterScreenPackage> createState() => _RegisterScreenPackageState();
}

class _RegisterScreenPackageState extends State<RegisterScreenPackage> {
  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var priceController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  CoursesModel coursesModel = CoursesModel();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const CategoryPrice();
                }));
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFa0c2e8),
                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
          title: const Center(
              child: Text(
            "Payment Integration",
            style: TextStyle(color: Colors.black),
          )),
        ),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFa0c2e8),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage("assets/images/payment.png"),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        label: "First Name",
                        icon: Icons.person_2_outlined,
                        keyboardType: TextInputType.text,
                        controller: firstNameController,
                        secure: false,
                        maxLine: 1),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        label: "Last Name",
                        icon: Icons.person_2_outlined,
                        keyboardType: TextInputType.text,
                        controller: lastNameController,
                        secure: false,
                        maxLine: 1),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        label: "Email",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        secure: false,
                        maxLine: 1),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        label: "Phone",
                        icon: Icons.phone_android_outlined,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        secure: false,
                        maxLine: 1),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 200,
                      child: BlocBuilder<GetCoursesCubit, CoursesState>(
                        builder: (context, state) {
                          if (state is GetCoursesFailure) {
                            return Text(state.errMessage);
                          } else if (state is GetCoursesSuccess) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[100])),
                              onPressed: () {},
                              child: const Text(
                                "Pay",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black54),
                              ),
                            );
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
