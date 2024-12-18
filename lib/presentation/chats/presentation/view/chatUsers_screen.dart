import 'package:asec_application/Constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/profile/profile_cubit.dart';
import '../../../../model/users_model.dart';
import 'answerChatByAdmin_screen.dart';

class ChatUsersScreen extends StatefulWidget {
  ChatUsersScreen({
    super.key,
    required this.userModel,
  });

  List<UserModel> userModel;

  @override
  State<ChatUsersScreen> createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.userModel.length);
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Users Chats",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection("User Application").where('chat', isEqualTo:"yes").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No data available"),
                );
              }
              var docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var doc = docs[index];
                  String docId = doc.id;
                  constantvar.uidMsg = doc.id;
                  String firstName = doc['firstName'];
                  String lastName = doc['lastName'];
                  Map<String, dynamic> data =
                  doc.data() as Map<String, dynamic>;
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.account_circle),
                    ),
                    title: Row(
                      children: [
                        Text("name : $firstName $lastName"),
                        const Spacer(),
                        CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.green[300],
                            child: Text(doc["arrayMsg"].length.toString(),style: TextStyle(fontSize: 11.sp,color: Colors.black),)
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text("Uid : $docId"),
                        const Spacer(),
                        /*
                        GestureDetector(
                            onTap: (){
                              FirebaseFirestore.instance.collection("User Application").doc(docId).update({
                                "chat":"no"
                              });
                            },
                            child: const Icon(Icons.clear,size: 17,color: Colors.red,)
                        )

                         */
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return AnswerChatByAdminScreen(
                            arrmsg: doc["arrayMsg"],
                            id: docId,
                          );
                        }));
                      });
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

/*
 SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ProfileCubit.get(context).userList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            height: 135.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 16.w),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        AnswerChatByAdminScreen(
                                          arrmsg:
                                              widget.userModel[index].arrayMsg!,
                                          id: widget.userModel[index].id!,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 5.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //row for id
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                child: const Icon(
                                                  Icons.numbers_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(widget.userModel[index].id!),
                                            ],
                                          ),
                                          //space
                                          SizedBox(
                                            height: 5.h,
                                          ),

                                          //row for name
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                child: const Icon(
                                                  Icons.account_circle_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(widget
                                                  .userModel[index].name!),
                                            ],
                                          ),
                                          //space
                                          SizedBox(
                                            height: 5.h,
                                          ),

                                          ////////////////////////////////////////////////

                                          //row for msg
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                child: const Icon(
                                                  Icons.message_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                              //space
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              widget.userModel[index].arrayMsg!
                                                      .isEmpty
                                                  ? Text("null")
                                                  : Text("msg"),
                                            ],
                                          ),
                                          //space
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        })),
                //space
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
 */
