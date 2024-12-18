import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/bloc/Auth/auth_cubit.dart';
import 'package:asec_application/core/new_customTextFormField_forRegister.dart';
import 'package:asec_application/presentation/new_Auth/new_login.dart';
import 'package:asec_application/presentation/new_Auth/presentation/manager/id_signin_with_google_cubit.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../model/app_user.dart';
import '../resources/color_manager.dart';

class NewRegisterPage extends StatefulWidget {
  const NewRegisterPage({Key? key}) : super(key: key);

  @override
  _NewRegisterPageState createState() => _NewRegisterPageState();
}

class _NewRegisterPageState extends State<NewRegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _passwordVisible = false;

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
    _passwordVisible = true;
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
      backgroundColor: const Color(0xfff5f5f5),
      body: BlocConsumer<IdSigninWithGoogleCubit, IdSigninWithGoogleState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SafeArea(
                child: Stack(children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Hello! Welcome",
                            style: TextStyle(
                                fontSize: 15.sp,
                                //color: Color(0xff1B98D2),
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Select method to sign up",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Form(
                            key: _key,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    //first name
                                    SizedBox(
                                      width: 160.w,
                                      child: NewCustomTextFormFieldForRegister(
                                        label: 'First Name',
                                        controller: firstNameController,
                                        keyboardType: TextInputType.text,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Color(0xff46454a),
                                          size: 20,
                                        ),
                                        validator:
                                            'Please Enter your First Name',
                                      ),
                                    ),

                                    const Spacer(),

                                    //last name
                                    SizedBox(
                                      width: 160.w,
                                      child: NewCustomTextFormFieldForRegister(
                                        label: 'Last Name',
                                        controller: lastNameController,
                                        keyboardType: TextInputType.text,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Color(0xff46454a),
                                          size: 20,
                                        ),
                                        validator:
                                            'Please Enter your Last Name',
                                      ),
                                    ),
                                  ],
                                ),
                                //space
                                SizedBox(
                                  height: 15.h,
                                ),

                                //=====>>>> country code phone
                                IntlPhoneField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.phone_android_outlined,
                                        color: Color(0xff46454a)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: '',
                                    labelStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color(0xff46454a)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      //background TextFormField ====>>> white
                                      borderSide: const BorderSide(
                                          color: Color(0xffffffff)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                          color: Color(0xffffffff)),
                                    ),
                                  ),
                                  initialCountryCode: 'EG',
                                  controller: phoneController,
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                  },
                                ),

                                //space
                                SizedBox(
                                  height: 5.h,
                                ),

                                //address

                                NewCustomTextFormFieldForRegister(
                                  label: 'Address',
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  prefixIcon: const Icon(
                                    Icons.location_on,
                                    color: Color(0xff46454a),
                                    size: 20,
                                  ),
                                  validator: 'Please Enter your Location',
                                ),

                                SizedBox(height: 15.h),

                                NewCustomTextFormFieldForRegister(
                                  label: 'Bio',
                                  controller: bioController,
                                  keyboardType: TextInputType.text,
                                  prefixIcon: const Icon(
                                    Icons.note_alt_rounded,
                                    color: Color(0xff46454a),
                                    size: 20,
                                  ),
                                  validator: 'Please Enter your Bio',
                                ),

                                SizedBox(height: 15.h),

                                Row(
                                  children: [
                                    Text(
                                      "specialization",
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: constantvar.specializationList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff46454a),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: specializationItem,
                                          onChanged: (value) {
                                            setState(() {
                                              specializationItem =
                                                  value as String;
                                              constantvar
                                                      .selectspecializationItem =
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
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: (Colors.grey[50])!,
                                              ),
                                              color: (Colors.grey[50])!,
                                            ),
                                            elevation: 2,
                                          ),
                                          iconStyleData: const IconStyleData(
                                            icon: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 13,
                                            iconEnabledColor: Color(0xff46454a),
                                            iconDisabledColor:
                                                Color(0xff46454a),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 200,
                                            padding: null,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: (Colors.grey[50])!,
                                            ),
                                            elevation: 8,
                                            offset: const Offset(-20, 0),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),

                                NewCustomTextFormFieldForRegister(
                                  label: 'Email',
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xff46454a),
                                    size: 20,
                                  ),
                                  validator: 'Please Enter your Email',
                                ),

                                SizedBox(height: 15.h),

                                //password
                                NewCustomTextFormFieldForRegister(
                                  label: 'Password',
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xff46454a),
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color(0xff46454a), size: 20,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  obsocure: _passwordVisible,
                                  validator: 'Please Enter your Password',
                                ),

                                SizedBox(height: 15.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
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
                                              const Expanded(
                                                child: Text(
                                                  "Position",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff46454a),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: positionList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff46454a),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedValuePosition,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValuePosition =
                                                  value as String;
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: 200,
                                            padding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: (Colors.grey[50])!,
                                              ),
                                              color: (Colors.grey[50])!,
                                            ),
                                            elevation: 2,
                                          ),
                                          iconStyleData: const IconStyleData(
                                            icon: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 13,
                                            iconEnabledColor: Color(0xff46454a),
                                            iconDisabledColor:
                                                Color(0xff46454a),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 200,
                                            padding: null,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: (Colors.grey[50])!,
                                            ),
                                            elevation: 8,
                                            offset: const Offset(-20, 0),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
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
                                              const Expanded(
                                                child: Text(
                                                  "Type",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff46454a),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: typeList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff46454a),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedValueType,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValueType =
                                                  value as String;
                                            });
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: 200,
                                            padding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: (Colors.grey[50])!,
                                              ),
                                              color: (Colors.grey[50])!,
                                            ),
                                            elevation: 2,
                                          ),
                                          iconStyleData: const IconStyleData(
                                            icon: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 13,
                                            iconEnabledColor: Color(0xff46454a),
                                            iconDisabledColor:
                                                Color(0xff46454a),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            width: 200,
                                            padding: null,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: (Colors.grey[50])!,
                                            ),
                                            elevation: 8,
                                            offset: const Offset(-20, 0),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),

                                //button submit
                                Center(
                                  child: ElevatedButton(
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
                                            [
                                              {
                                                'msg':
                                                    'Hi ${firstNameController.value.text} ${lastNameController.value.text}',
                                                'uid':
                                                    'fNxe5mBrhVUYqZXAAZ1fVbOt2ju2'
                                              },
                                            ],
                                            "no");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 17,
                                      backgroundColor: const Color(0xff1B98D2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      fixedSize: const Size(350, 50),
                                    ),
                                    child: const Text(
                                      "Submit",
                                    ),
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
                                      style:
                                          TextStyle(color: Color(0xff000000)),
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
                              onTap: (){
                                signInWithFacebook().then((value) => {
                                  debugPrint("done sign in facebook >>>>>>>>>")
                                });
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
                                    Container(
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
                                        ))
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
                                        "Not have an account ?",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return const NewLoginPage();
                                            }));
                                          },
                                          child: Text("Login Here",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff0B3F5D),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp)))
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10.h),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            },
          );
        },
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
    List<dynamic> arrayMsg,
    String chat,
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
            arrayMsg: arrayMsg,
            chat: chat);

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
        navigateTo(context, const NewLoginPage());
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
  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
     // permissions: ['email'],
    );

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      print('Logged in successfully: ${accessToken.token}');
      print("done amira>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      // Handle login success, e.g., navigate to another screen
    } else if (result.status == LoginStatus.cancelled) {
      print('Login cancelled');
      // Handle login cancellation
    } else {
      print('Login failed: ${result.message}');
      // Handle login failure
    }
  }


   */
}
