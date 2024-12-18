

import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/Widget/customTextFormField.dart';
import 'package:asec_application/model/app_user.dart';
import 'package:asec_application/shared/components/components.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../bloc/get_information/user_information_cubit.dart';

import '../../master.dart';
import '../resources/color_manager.dart';

class EditProFilePage extends StatefulWidget {
  const EditProFilePage({super.key});

  @override
  State<EditProFilePage> createState() => _EditProFilePageState();
}

class _EditProFilePageState extends State<EditProFilePage> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }


  ApplicationUser? applicationUser;


  // late FirebaseAuth _mAuth;
  // late DatabaseReference _databaseReference;
  // late Reference _storage;
  // String downloadUrl = '';


  // @override
  // void initState() {
  //   _mAuth = FirebaseAuth.instance;
  //   _databaseReference = FirebaseDatabase.instance.ref();
  //   _storage = FirebaseStorage.instance.ref();
  //   super.initState();
  // }
  //
  // Future<String?> uploadImage() async {
  //   var picker = ImagePicker();
  //   XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
  //   return xFile?.path;
  // }
  //
  // Future<void> saveImage() async {
  //   String? path = await uploadImage(); //get xfile path from previous function
  //   if (path != null) {
  //     String suffix = DateTime
  //         .now()
  //         .second
  //         .toString(); //to use suffix to differentiate between images
  //     File file = File(
  //         path); //create file from dart:io packages to upload it to storage
  //     //create folder called images and inside it create anther folder for this user called by uid
  //     // then put name to the image containes uid+suffix (uploaded image name)
  //     UploadTask task = _storage
  //         .child('images')
  //         .child(_mAuth.currentUser!.uid)
  //         .child("${_mAuth.currentUser!.uid}$suffix")
  //         .putFile(file); //upload this image inside storage
  //     task.whenComplete(() async {
  //       downloadUrl = await task.snapshot.ref.getDownloadURL();
  //       saveImageInFirestore(downloadUrl);
  //       setState(() {});
  //     });
  //   }
  // }

  // void saveImageInFirestore(String downloadUrl) {
  //   if (applicationUser != null) {
  //     applicationUser!. = downloadUrl;
  //     FirebaseFirestore.instance.collection('Users').doc(_mAuth.currentUser!.uid).set(
  //   applicationUser!.toJson()).then((value) => print("Image Saved"));
  //   }
  // }



  clear()
  {
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
  }

  var codeCountry = "+20";
  List typeList = [
    "Male",
    "Female",
  ];
  List positionList = [
    "Student",
    "Engineer",
    "Manger",
    "Senior",
    "Other",
  ];
  String selectedValueType = "Male";
  String selectedValuePosition = "Other";
  String specialization = "Mechanical";


  var uID = FirebaseAuth.instance.currentUser!.uid;


  GlobalKey<FormState>keyProfile= GlobalKey();

  @override
  Widget build(BuildContext context) {

    var userApp = UserAppInformationCubit.get(context).applicationUser;



    return BlocConsumer<UserAppInformationCubit, UserInformationState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userApp = UserAppInformationCubit.get(context).applicationUser;
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: keyProfile,
              child: ListView(
                children: [
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 120.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: const DecorationImage(
                                  image:
                                  AssetImage("assets/images/procover.png"),
                                  fit: BoxFit.fill),
                            ),




                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,

                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 56,
                              backgroundImage:
                              AssetImage("assets/images/engx.png"),
                            ),
                          ),


                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const SizedBox(   height: 15, ),


                  CustomTextField(
                      width: double.infinity,
                      height: 50,
                      enable: true,
                      title: "First Name",
                      keyboard: TextInputType.text,
                      controller: firstNameController,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "Enter Your First Name";
                        }
                      }
                  ),
                  const SizedBox(   height: 20, ),
                  CustomTextField(
                      width: double.infinity,
                      enable: true,
                      height: 50,
                      title: "Last Name",
                      keyboard: TextInputType.text,
                      controller: lastNameController,
                      validate: ( value)
                      {
                        if(value.isEmpty)
                        {
                          return "Enter Your Last Name";
                        }
                      }
                  ),
                  const SizedBox(   height: 20, ),
                  CustomTextField(
                      width: double.infinity,
                      height: 50,
                      title: "Email",
                      enable: true,
                      keyboard: TextInputType.emailAddress,
                      controller: emailController,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "Enter Your Email";
                        }
                      }
                  ),
                  const SizedBox(   height: 20, ),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,

                        child: CountryCodePicker(
                          textStyle: const TextStyle(color: Colors.black54,fontSize: 18),
                          onChanged: (element)
                          {
                            debugPrint(element.code.toString());
                            setState(() {
                              codeCountry = element.toLongString();
                            });
                          },
                          initialSelection: 'EG',
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          favorite: const ['EG','AE','DZ','LY','AS','YE','LB','SD','SY'],
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                            width: double.infinity,
                            height: 50,
                            title: "Phone",
                            enable: true,
                            keyboard: TextInputType.number,
                            controller: phoneController,
                            validate: (value)
                            {
                              if(value.isEmpty)
                              {
                                return "Enter Your Phone";
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                      width: double.infinity,
                      height: 50,
                      title: "Bio",
                      enable: true,
                      keyboard: TextInputType.text,
                      controller: bioController,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "Enter Your Bio";
                        }
                      }
                  ),
                  const SizedBox(height: 20,),
                  // dropDown

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Text("Specialization",style: TextStyle(fontSize: 20,color: Colors.black54),),
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
                                  const Expanded(
                                    child: Text(
                                      "Specialization",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: constantvar.track
                                  .map((item) => DropdownMenuItem<String>(

                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                              )
                                  .toList(),
                              value: specialization,

                              onChanged: (value) {
                                setState(() {
                                  specialization = value as String;
                                  constantvar.selectspecializationItem = value;
                                  print(specialization);
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
                                    color: (Colors.grey[100])!,
                                  ),
                                  color: (Colors.grey[100])!,
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
                                  color: (Colors.grey[100])!,
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


                  const SizedBox(height: 25,),


                  CustomTextField(
                      width: double.infinity,
                      height: 50,
                      title: "Address",
                      enable: true,
                      keyboard: TextInputType.text,
                      controller: addressController,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "Enter Your Address";
                        }
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // dropdown

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
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
                                      color: (Colors.grey[100])!,
                                    ),
                                    color: (Colors.grey[100])!,
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
                                    color: (Colors.grey[100])!,
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
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
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
                                      color: (Colors.grey[100])!,
                                    ),
                                    color: (Colors.grey[100])!,
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
                                    color: (Colors.grey[100])!,
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
                        ),



                      ],
                    ),
                  ),


                  const SizedBox(
                    height: 25,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(onPressed: (){

                      if(keyProfile.currentState!.validate())
                        {

                          ApplicationUser userApp = ApplicationUser(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              address: addressController.text,
                              phone: phoneController.text,
                              type: selectedValueType,
                              position: selectedValuePosition,
                              code: codeCountry,
                              specialization: specialization,
                              bio: bioController.text
                          );


                          UserAppInformationCubit.get(context).updateInformation(
                              id: uID, model: userApp.toJson()
                          ).then((value) {
                            navigateTo(context, Master());
                            print("New Name is ===>>>> ${userApp.firstName}");
                            clear();
                            print("Update is Done");

                          });
                        }


                    }, child: const Text("Update",style: TextStyle(fontSize: 25,color: Colors.black54),)),
                  )




                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
