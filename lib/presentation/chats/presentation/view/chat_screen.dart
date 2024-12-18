import 'package:asec_application/Constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/get_information/user_information_cubit.dart';
import '../../../../bloc/profile/profile_cubit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String msg = "";

  @override
  void initState() {
    UserAppInformationCubit.get(context).applicationUser;
    super.initState();
  }

  TextEditingController textSend = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chat Boot",
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
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('User Application')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(
                  child: Text('Document does not exist'));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final listOfMaps = data['arrayMsg'] as List<dynamic>;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .79,
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
                  Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .08,
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
                                contentPadding:
                                const EdgeInsets.fromLTRB(
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
                                FirebaseFirestore.instance.collection("User Application").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  "chat":"yes"
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
              )
               */
                ],
              ),
            );
          },
        ));
  }

  Future<void> addListOfMapsToArray({required String messageText}) async {
    // Get Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define the collection and document (e.g., users/userId)
    DocumentReference userDoc =
    firestore.collection('User Application').doc(FirebaseAuth.instance.currentUser!.uid);

    // Create a list of maps
    List<Map<String, dynamic>> messages = [
      {'uid': FirebaseAuth.instance.currentUser!.uid, 'msg': messageText},
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
        .set(messageData);
  }
}
