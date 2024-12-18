import 'package:asec_application/core/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../../model/order_Model.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class OrderProject extends StatefulWidget {
  const OrderProject({super.key});

  @override
  State<OrderProject> createState() => _OrderProjectState();
}

class _OrderProjectState extends State<OrderProject> {
  late FirebaseAuth _mAuth;

  late FirebaseFirestore _firestore;

  late TextEditingController _yourOrder;

  late TextEditingController _FullName;

  late TextEditingController _Email;

  late TextEditingController _Address;

  late TextEditingController _PhoneNumber;

  late TextEditingController _ProjectType;

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _yourOrder = TextEditingController();
    _FullName = TextEditingController();

    _Address = TextEditingController();
    _Email = TextEditingController();
    _PhoneNumber = TextEditingController();
    _ProjectType = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _yourOrder.dispose();
    _FullName.dispose();
    _Email.dispose();
    _Address.dispose();
    _PhoneNumber.dispose();
    _ProjectType.dispose();
    super.dispose();
  }

  final List<String> items = [
    'MEP',
    'CAD',
    'BIM',
    'SoildWork',
    'AutoCad',
    'Revit',
  ];

  String? selectedValue;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: ColorManager.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        title: Text(
          S.of(context).yourOrder,
          style: TextStyle(
              fontSize: AppSize.s24,
              fontWeight: FontWeight.w700,
              color: ColorManager.Black),
        ),
      ),
      body: SafeArea(
        child: Container(
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
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .12),

                  // order
                  CustomTextFormFieldNew(
                      hintText: "Your Order",
                      controller: _yourOrder,
                      keyboardType: TextInputType.text,
                      validateText: "Please Enter your Order",
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .05,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.home_work_outlined,
                        color: Colors.black,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  // name
                  CustomTextFormFieldNew(
                      hintText: "Full Name",
                      controller: _FullName,
                      keyboardType: TextInputType.text,
                      validateText: "Please Enter your Name",
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .05,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.black,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),

                  // email
                  CustomTextFormFieldNew(
                      hintText: "Email",
                      controller: _Email,
                      keyboardType: TextInputType.text,
                      validateText: "Please Enter your Email",
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .05,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),

                  // address
                  CustomTextFormFieldNew(
                      hintText: "Address",
                      controller: _Address,
                      keyboardType: TextInputType.text,
                      validateText: "Please Enter your Address",
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .05,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),

                  // phone
                  CustomTextFormFieldNew(
                      hintText: "Phone",
                      controller: _PhoneNumber,
                      keyboardType: TextInputType.text,
                      validateText: "Please Enter your phone",
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .05,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).projectType,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.s14),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  Expanded(
                                    child: Text(
                                      S.of(context).projectType,
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
                              items: items
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
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 150,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.grey[200],
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
                                  color: Colors.grey[100],
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
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  Center(
                    child: Container(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: AppSize.s48,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                // Change your radius here
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[100]),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(AppSize.s8))),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              saveUserDataInFirestore(
                                  _mAuth.currentUser!.uid,
                                  _yourOrder.value.text,
                                  _FullName.value.text,
                                  _Email.value.text,
                                  _PhoneNumber.value.text,
                                  _Address.value.text,
                                  selectedValue);
                              clearText();
                            }
                          },
                          child: Text(
                            S.of(context).Send,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveUserDataInFirestore(String uid, String order, String name,
      String email, String Address, String phone, String? selectedValue) {
    MakeOrder makeOrder =
        MakeOrder(uid, order, name, email, Address, phone, selectedValue!);

    _firestore
        .collection("OrderUser")
        .doc(_mAuth.currentUser!.uid)
        .set(makeOrder.toJson())
        .then((value) {
      var snackBar = SnackBar(
        content: Text(
          AppStrings.orderSuccess,
          style: TextStyle(fontSize: 15.sp),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void clearText() {
    _yourOrder.clear();
    _FullName.clear();
    _Email.clear();
    _Address.clear();
    _PhoneNumber.clear();
  }
}
