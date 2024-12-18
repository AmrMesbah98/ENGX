import 'package:asec_application/Widget/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get_information/user_information_cubit.dart';
import '../resources/values_manager.dart';

class BuildInfoScreen extends StatelessWidget {
   BuildInfoScreen({super.key,
    required this.firstName,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.address,
    required this.position,
    required this.type,
  });

  final String firstName;
  final String lastname;
  final String email;
  final String phone;
  final String address;
  final String position;
  final String type;


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAppInformationCubit, UserInformationState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userApp = UserAppInformationCubit.get(context).applicationUser;
        firstNameController.text = userApp!.firstName;
        lastNameController.text = userApp.lastName;
        phoneController.text = userApp.phone;
        emailController.text = userApp.email;
        addressController.text = userApp.address;
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 900,

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ListView(

                    children: [
                      const SizedBox(height: 5),
                      CustomTextField(
                          enable: false,
                          width: double.infinity,
                          height: 80,
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
                      const SizedBox(height: 5),
                      CustomTextField(
                          enable: false,
                          width: double.infinity,
                          height: 70,
                          title: "Last Name",
                          keyboard: TextInputType.text,
                          controller: lastNameController,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return "Enter Your First Name";
                            }
                          }
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                          enable: false,
                          width: double.infinity,
                          height: 70,
                          title: "Email",
                          keyboard: TextInputType.text,
                          controller: emailController,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return "Enter Your First Email";
                            }
                          }
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                          enable: false,
                          width: double.infinity,
                          height: 70,
                          title: "Phone",
                          keyboard: TextInputType.text,
                          controller: phoneController,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return "Enter Your First Name";
                            }
                          }
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                          enable: false,
                          width: double.infinity,
                          height: 70,
                          title: "Address",
                          keyboard: TextInputType.text,
                          controller: addressController,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return "Enter Your First Name";
                            }
                          }
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({super.key, required this.iconData, required this.data});

  final IconData iconData;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(child: Icon(iconData, size: 20,), radius: 16,),
          const SizedBox(width: 10),
          Text(
            data,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}


