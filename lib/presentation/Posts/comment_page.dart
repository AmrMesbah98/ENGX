import 'package:asec_application/firebase_services/firestore_service.dart';
import 'package:asec_application/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Constant/constant.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../bloc/post/post_cubit.dart';
import '../../master.dart';
import '../../shared/components/components.dart';
import '../DashBoard/CoursesControl/BuildTextFormFieldCourses.dart';
import 'Post_Page.dart';

class CommentPage extends StatefulWidget {
  CommentPage({super.key, required this.postModelComment,required this.id,required this.nameUser});

  PostModel postModelComment;
  String? id;
  String? nameUser;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController? titleController;

  TextEditingController? descriptionController;

  TextEditingController? commentController;


  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    descriptionController!.dispose();
    commentController!.dispose();
  }

  @override
  void initState() {
    print(widget.id);
    print(widget.nameUser);
    super.initState();
  }

  FireStoreService fireStoreService = FireStoreService();


  @override
  Widget build(BuildContext context) {
    var info = UserAppInformationCubit.get(context).applicationUser;
    titleController =
        TextEditingController(text: widget.postModelComment.postTitle);
    descriptionController =
        TextEditingController(text: widget.postModelComment.postDescription);
    commentController =
        TextEditingController(text: widget.postModelComment.comment);
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            title: const Text("Review Post",style: TextStyle(color: Colors.black),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            child: ListView(

              children: [
                const SizedBox(height: 20),
                //for title
                /*
                BuildTextFormFieldCourses(
                    label: "Title", controller: titleController!),

                 */
                //for description
                BuildTextFormFieldCourses(
                    label: "Description", controller: descriptionController!),
                //for comment
                BuildTextFormFieldCourses(
                    label: "Comment", controller: commentController!),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context,index){
                        return ElevatedButton(onPressed: () {

                          PostModel viewpost = PostModel(
                            //name: "${info!.firstName} ${info.lastName}",
                              name: widget.nameUser,
                              postTitle: titleController!.text,
                              postDescription: descriptionController!.text,
                              comment: commentController!.text,
                              isShow: true
                          );

                          PostCubit.get(context).setPostFunctionAfterTest(
                            data: viewpost.toJson(),
                          ).then((value)
                          async {

                            await   FirebaseFirestore.instance.collection("Post").doc(widget.postModelComment.id!).delete();

                            PostCubit.get(context).getPostFunction();

                            PostCubit.get(context).getFinalPostFunction();
                            navigateTo(context, const Master());
                          }

                          );


                        }, child: Text("Submit"));
                      },

                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
