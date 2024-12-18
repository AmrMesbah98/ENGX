import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../generated/l10n.dart';
import '../../../model/order_Model.dart';
import '../../../model/support_Model.dart';
import '../../login/customTextFormField.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late FirebaseAuth _mAuth;
  late FirebaseFirestore _fireStore;
  late Reference _storage;
  final GlobalKey<FormState> _keySupport = GlobalKey();
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _whyNeedSupport;

  void clearText() {
    _name.clear();
    _phone.clear();
    _email.clear();
    _whyNeedSupport.clear();
  }

  String downloadUrl = "";

  MakeOrder? makeOrder;

  SupportMethod? supportMethod;

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance.ref();
    _name = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();
    _whyNeedSupport = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _whyNeedSupport.dispose();
    super.dispose();
  }

  List country = [
    AppStrings.Egypt,
    AppStrings.lebanon,
    AppStrings.syria,
    AppStrings.sudan,
    AppStrings.yemen,
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      if (constrain.maxWidth < 600) {
        return Scaffold(
          appBar: AppBar(
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
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              S.of(context).Support,
              style:
                  TextStyle(color: ColorManager.Black, fontSize: AppSize.s25),
            ),
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            height: 800,
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
            child: Form(
              key: _keySupport,
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextFormField(
                    label: S.of(context).name,
                    icon: Icons.account_circle_outlined,
                    keyboardType: TextInputType.text,
                    controller: _name,
                    secure: false,
                    maxLine: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextFormField(
                    label: S.of(context).email,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    secure: false,
                    maxLine: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextFormField(
                    label: S.of(context).phone,
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                    controller: _phone,
                    secure: false,
                    maxLine: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        label: Text(S.of(context).whyNeedSupport),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.support_agent_outlined,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _whyNeedSupport,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s10),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
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
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    S.of(context).count,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.Black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: country
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 16,
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
                              width: 170,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: ColorManager.white,
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              elevation: 4,
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
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFe5e5e5),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
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
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt),
                        GestureDetector(
                          child: Text(
                            S.of(context).DeathCertificate,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          onTap: () {
                            saveImage();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSize.s12),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black54),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFe5e5e5),
                            ),
                          ),
                          onPressed: () {
                            if (_keySupport.currentState!.validate()) {
                              saveUserDataInFireStore(
                                  _mAuth.currentUser!.uid,
                                  _name.value.text,
                                  _email.value.text,
                                  _phone.value.text,
                                  _whyNeedSupport.value.text,
                                  selectedValue!,
                                  downloadUrl);
                              saveImagesInFireStore(downloadUrl);
                              clearText();

                              var snackBar = SnackBar(
                                content: Text(
                                  S.of(context).orderSuccess,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.s10),
                            child: Text(S.of(context).submit,
                                style: const TextStyle(fontSize: AppSize.s24)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else if (constrain.maxWidth < 900) {
        return Scaffold(
          appBar: AppBar(
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
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              S.of(context).Support,
              style:
                  TextStyle(color: ColorManager.Black, fontSize: AppSize.s25),
            ),
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
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
            child: Form(
              key: _keySupport,
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .12),
                  CustomTextFormField(
                    label: S.of(context).name,
                    icon: Icons.account_circle_outlined,
                    keyboardType: TextInputType.text,
                    controller: _name,
                    secure: false,
                    maxLine: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextFormField(
                    label: S.of(context).email,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    secure: false,
                    maxLine: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextFormField(
                    label: S.of(context).phone,
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                    controller: _phone,
                    secure: false,
                    maxLine: 1,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        label: Text(S.of(context).whyNeedSupport),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.support_agent_outlined,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _whyNeedSupport,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s10),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
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
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    S.of(context).count,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.Black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: country
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 16,
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
                              width: 170,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: ColorManager.white,
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              elevation: 4,
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
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFe5e5e5),
                                      Color(0xFFFFFFFF),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
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
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt),
                        GestureDetector(
                          child: Text(
                            S.of(context).DeathCertificate,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          onTap: () {
                            saveImage();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSize.s12),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black54),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFe5e5e5),
                            ),
                          ),
                          onPressed: () {
                            if (_keySupport.currentState!.validate()) {
                              saveUserDataInFireStore(
                                  _mAuth.currentUser!.uid,
                                  _name.value.text,
                                  _email.value.text,
                                  _phone.value.text,
                                  _whyNeedSupport.value.text,
                                  selectedValue!,
                                  downloadUrl);
                              saveImagesInFireStore(downloadUrl);
                              clearText();

                              var snackBar = SnackBar(
                                content: Text(
                                  S.of(context).orderSuccess,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.s10),
                            child: Text(S.of(context).submit,
                                style: const TextStyle(fontSize: AppSize.s24)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return const Center(child: Text("DESKTOP"));
      }
    });
  }

  //get image from camera with xfile path => image picker lib
  Future<String?> uploadImage() async {
    var picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    return xFile?.path;
  }

  Future<void> saveImage() async {
    String? path = await uploadImage(); //get xfile path from previous function
    if (path != null) {
      String suffix = DateTime.now()
          .second
          .toString(); //to use suffix to differentiate between images
      File file = File(path);
      //create file from dart:io packages to upload it to storage
      //create folder called images and inside it create anther folder for this user called by uid
      // then put name to the image containes uid+suffix (uploaded image name)
      UploadTask task = _storage
          .child('images')
          .child(_mAuth.currentUser!.uid)
          .child("${_mAuth.currentUser!.uid}$suffix")
          .putFile(file); //upload this image inside storage
      task.whenComplete(() async {
        downloadUrl = await task.snapshot.ref.getDownloadURL();
        saveImagesInFireStore(downloadUrl);
        setState(() {});
      });
    }
  }

  void saveImagesInFireStore(String downloadUrl) {
    if (supportMethod != null) {
      supportMethod!.pic = downloadUrl;
      _fireStore
          .collection('Support')
          .doc(_mAuth.currentUser!.uid)
          .set(supportMethod!.toJson())
          .then((value) => print('Image Save'));
    }
  }

  void saveUserDataInFireStore(String uid, String name, String email,
      String phone, String reason, String country, String url) {
    supportMethod =
        SupportMethod(uid, name, email, phone, reason, country, url);
    _fireStore
        .collection("Support")
        .doc(_mAuth.currentUser!.uid)
        .set(supportMethod!.toJson())
        .then((value) {
      print('Done');
    });
  }

  buildTextFiled(String title, TextInputType type, int line,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s10),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(title),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
        ),
        validator: (value) =>
            value!.isEmpty ? 'This field cannot be blank' : null,
        controller: controller,
        keyboardType: type,
        maxLines: line,
      ),
    );
  }
}
