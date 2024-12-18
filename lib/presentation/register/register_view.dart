import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../../model/app_user.dart';
import '../login/customTextFormField.dart';
import '../login/login_view.dart';
import '../login/passwordTextFormField.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> _key = GlobalKey();
  late FirebaseAuth _mAuth;
  late FirebaseFirestore _firestore;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmPassowrdController = TextEditingController();

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    ConfirmPassowrdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    ConfirmPassowrdController.dispose();
    super.dispose();
  }

  List positionList = [
    "Student",
    "Engineer",
    "Manger",
    "Senior",
    "Other",
  ];

  List typeList = [
    "Male",
    "Female",
  ];

  String specializationItem = "Electrical";

  var codeCountry = "+20";

  String selectedValuePosition = "Other";
  String selectedValueType = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .2,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFFe5e5e5),
                                Color(0xFFFFFFFF),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(800),
                            bottomRight: Radius.circular(0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create an account",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "          By using our services you are agreeing to our Terms and privacy statement ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSize.s20),
                        CustomTextFormField(
                          label: "First Name",
                          icon: Icons.person,
                          keyboardType: TextInputType.text,
                          controller: firstNameController,
                          secure: false,
                          maxLine: 1,
                        ),
                        SizedBox(height: 5.h),
                        CustomTextFormField(
                          label: "Last Name",
                          icon: Icons.person,
                          keyboardType: TextInputType.text,
                          controller: lastNameController,
                          secure: false,
                          maxLine: 1,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: CountryCodePicker(
                                onChanged: (element) {
                                  debugPrint(element.code.toString());
                                  setState(() {
                                    codeCountry = element.toLongString();
                                  });
                                },
                                initialSelection: 'EG',
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: true,
                                favorite: const [
                                  'EG',
                                  'AE',
                                  'DZ',
                                  'LY',
                                  'AS',
                                  'YE',
                                  'LB',
                                  'SD',
                                  'SY'
                                ],
                              ),
                            ),
                            Expanded(
                              child: CustomTextFormField(
                                label: "Phone",
                                icon: Icons.phone_android_outlined,
                                keyboardType: TextInputType.number,
                                controller: phoneController,
                                secure: false,
                                maxLine: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        CustomTextFormField(
                          label: "Address",
                          icon: Icons.location_on_outlined,
                          keyboardType: TextInputType.text,
                          controller: addressController,
                          secure: false,
                          maxLine: 1,
                        ),
                        SizedBox(height: 5.h),
                        CustomTextFormField(
                          label: "Bio",
                          icon: Icons.note_alt_rounded,
                          keyboardType: TextInputType.text,
                          controller: bioController,
                          secure: false,
                          maxLine: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 7.h),
                          child: Row(
                            children: [
                              Text(
                                "specialization",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: ColorManager.Black,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Specialization",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.Black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: constantvar.specializationList
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorManager.Black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: specializationItem,
                                    onChanged: (value) {
                                      setState(() {
                                        specializationItem = value as String;
                                        constantvar.selectspecializationItem =
                                            value;
                                        print(specializationItem);
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: (Colors.grey[200])!,
                                        ),
                                        color: (Colors.grey[200])!,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: ColorManager.Black,
                                      iconDisabledColor: ColorManager.Black,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: (Colors.grey[200])!,
                                      ),
                                      elevation: 8,
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        CustomTextFormField(
                          label: "Email",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.text,
                          controller: emailController,
                          secure: false,
                          maxLine: 1,
                        ),
                        SizedBox(height: 5.h),
                        CustomPasswordField(
                          label: "Password",
                          icon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          secure: true,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      Icon(
                                        Icons.list,
                                        size: 16,
                                        color: ColorManager.Black,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Position",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.Black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: positionList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.Black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValuePosition,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValuePosition = value as String;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 200,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: (Colors.grey[200])!,
                                      ),
                                      color: (Colors.grey[200])!,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: ColorManager.Black,
                                    iconDisabledColor: ColorManager.Black,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    padding: null,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: (Colors.grey[200])!,
                                    ),
                                    elevation: 8,
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      Icon(
                                        Icons.list,
                                        size: 16,
                                        color: ColorManager.Black,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Type",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.Black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: typeList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.Black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValueType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValueType = value as String;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 200,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: (Colors.grey[200])!,
                                      ),
                                      color: (Colors.grey[200])!,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: ColorManager.Black,
                                    iconDisabledColor: ColorManager.Black,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    padding: null,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: (Colors.grey[200])!,
                                    ),
                                    elevation: 8,
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey[200])),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                signup(
                                  emailController.value.text,
                                  passwordController.value.text,
                                  firstNameController.value.text,
                                  lastNameController.value.text,
                                  addressController.value.text,
                                  phoneController.value.text,
                                  selectedValueType,
                                  bioController.text,
                                  selectedValuePosition,
                                  specializationItem,
                                  codeCountry,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(AppSize.s4),
                              child: Text(
                                S.of(context).submit,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 20.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account?  ",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const LoginViewApp();
                                }));
                              },
                              child: Text(S.of(context).SwapLogin,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.blue)),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s16),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String address,
    String phone,
    String type,
    String position,
    String codeHome,
    String bio,
    String specialization,
  ) async {
    try {
      UserCredential userCredential = await _mAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        ApplicationUser applicationUser = ApplicationUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          address: address,
          phone: phone,
          type: type,
          position: position,
          code: codeHome,
          specialization: specialization,
          bio: bio,
        );

        _firestore
            .collection("User Application")
            .doc(value.user!.uid)
            .set(applicationUser.toJson())
            .then((value) {
          var snackBar = SnackBar(
            content: Text(
              "welcome to ASEC",
              style: TextStyle(fontSize: 15.sp),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });

        print("user ID is ====>>>> ${value.user!.uid}");
        var id = value.user!.uid;
        print("id-->>>>>$id");
        print("email---->>> $email");
        print("Password----->>>$password");
        return value;
      });
      if (userCredential != null) {
        navigateTo(context, const LoginViewApp());
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);

      var snackBar = SnackBar(
        content: Text(
          "${e.message}",
          style: TextStyle(fontSize: 15.sp),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
