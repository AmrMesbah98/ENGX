import 'package:asec_application/Constant/constant.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../bloc/get_information/user_information_cubit.dart';
import '../../../../bloc/profile/profile_cubit.dart';


class AnswerChatByAdminScreen extends StatefulWidget {
  AnswerChatByAdminScreen({super.key, required this.arrmsg, required this.id});

  List<dynamic> arrmsg;
  String id;

  @override
  State<AnswerChatByAdminScreen> createState() =>
      _AnswerChatByAdminScreenState();
}

class _AnswerChatByAdminScreenState extends State<AnswerChatByAdminScreen> {
  String msg = "";
  bool _loading = true;

  // This function simulates fetching new data (for refresh)
  Future<void> _refreshPage() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay
    setState(() {
      UserAppInformationCubit.get(context).applicationUser;
    });
  }

  @override
  TextEditingController textSend = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      _loading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: _loading,
          child: Scaffold(
              appBar: AppBar(
                title: const Text(
                 " Chat Boot",
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
              //backgroundColor: Colors.grey,
              body: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('User Application')
                    .doc(widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text('Document does not exist'));
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final listOfMaps = data['arrayMsg'] as List<dynamic>;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .809,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: listOfMaps.length,
                                itemBuilder: (context, index) {
                                  final mapItem =
                                  listOfMaps[index] as Map<String, dynamic>;

                                  return BubbleSpecialOne(
                                    // text: 'Hi, How are you? ',
                                    text: mapItem["msg"],
                                    // MyMap['msg'] ?? 'No Title'
                                    isSender: mapItem["uid"] ==
                                        "fNxe5mBrhVUYqZXAAZ1fVbOt2ju2"
                                        ? false
                                        : true,
                                    color: mapItem["uid"] ==
                                        "fNxe5mBrhVUYqZXAAZ1fVbOt2ju2"
                                        ? Colors.black45
                                        : Colors.blue.shade500,
                                    textStyle: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          color: Colors.grey[100],
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .09,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: TextField(
                                    cursorErrorColor: Colors.blue,
                                    cursorColor: Colors.blue,
                                    controller: textSend,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Type your message here",
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    addListOfMapsToArray(
                                        messageText: textSend.text)
                                        .then((value) async {

                                      FirebaseFirestore.instance.collection("User Application").doc(widget.id).update({
                                        "chat":"no"
                                      });
                                      print(
                                          "message is >>>>> ${textSend.text}");
                                      textSend.clear();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                        ),

                        /*
                        MessageBar(
                          onSend: (xx) {
                            setState(() {
                              msg = xx;
                              addListOfMapsToArray(messageText: msg)
                                  .then((value) async {
                                print("message is >>>>> ${msg}");
                              });

                              // ChatCubit.get(context).addMessagesToAdmin(context: context, messageText: msg,);
                            });
                          },

                          /*
                                       actions: [
                    GestureDetector(
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: GestureDetector(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 24,
                        ),
                        onTap: () {},
                      ),
                    ),
                                      ],
                                       */
                        ),
                         */
                      ],
                    ),
                  );
                },
              )),
        );
      },
    );
  }

  /*
  userModelMsg == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshPage,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              children: [
                                Container(
                                  height: 660.h,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: userModelMsg!.arrayMsg!.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: double.infinity,
                                          child: BubbleSpecialOne(
                                            // text: 'Hi, How are you? ',
                                            text: userModelMsg!.arrayMsg![index]
                                                ["msg"],
                                            // MyMap['msg'] ?? 'No Title'
                                            isSender: userModelMsg!
                                                            .arrayMsg![index]
                                                        ["uid"] ==
                                                    "DWYxF85tkdhsYkfv3XW0tIu8P1x2"
                                                ? false
                                                : true,
                                            color: userModelMsg!
                                                            .arrayMsg![index]
                                                        ["uid"] ==
                                                    "DWYxF85tkdhsYkfv3XW0tIu8P1x2"
                                                ? Colors.black45
                                                : Colors.blue.shade500,
                                            textStyle: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }),
                                ),

                                //Spacer(),

                                MessageBar(
                                  onSend: (xx) {
                                    setState(() {
                                      msg = xx;
                                      addListOfMapsToArray(messageText: msg)
                                          .then((value) async {
                                        ProfileCubit.get(context)
                                            .getNameUserData();
                                        print("message is >>>>> ${msg}");
                                        ProfileCubit.get(context)
                                            .nameUserDataModel;
                                      });

                                      // ChatCubit.get(context).addMessagesToAdmin(context: context, messageText: msg,);
                                    });
                                  },

                                  /*
                   actions: [
                    GestureDetector(
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: GestureDetector(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 24,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                   */
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
   */

  Future<void> addListOfMapsToArray({required String messageText}) async {
    // Get Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define the collection and document (e.g., users/userId)
    DocumentReference userDoc = firestore.collection('User Application').doc(widget.id);

    // Create a list of maps
    List<Map<String, dynamic>> messages = [
      {'uid': constantvar.uid, 'msg': messageText},
    ];

    // Use FieldValue.arrayUnion to add the list of maps to an existing array field
    await userDoc.update({
      'arrayMsg': FieldValue.arrayUnion(messages),
    });
  }

  // mistake code
  void sendMessage(String message) async {
    // Get the current user's UID
    //String? uid = FirebaseAuth.instance.currentUser!.uid;

    // Create a message map with the message, UID, and timestamp
    Map<String, dynamic> messageData = {
      'message': message,
      'uid': constantvar.uid,
      //'timestamp': FieldValue.serverTimestamp(), // Add server timestamp
    };

    // Send the message to Firestore
    await FirebaseFirestore.instance
        .collection('User Application')
        .doc(constantvar.uid)
        .set(messageData)
        .then((value) {});
  }
}
