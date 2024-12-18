import 'package:asec_application/model/post_model.dart';
import 'package:asec_application/presentation/Posts/comment_page.dart';
import 'package:asec_application/presentation/Settings/contact%20us.dart';
import 'package:asec_application/presentation/courses/See_more_Courses.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constant/constant.dart';
import '../../bloc/post/post_cubit.dart';
import '../../generated/l10n.dart';
import '../project/project.dart';
import 'Create_Post.dart';

class ReviewPost extends StatefulWidget {
  const ReviewPost({super.key});

  @override
  _ReviewPostState createState() => _ReviewPostState();
}

class _ReviewPostState extends State<ReviewPost>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
    CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  // TextEditingController titleController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  // TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {},
      builder: (context, state) {


        if (state is GetPostLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        var modelPost = PostCubit.get(context).modelPost;

        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black54),
              title: const Text(
                "Review Posts",
                style: TextStyle(color: Colors.black),
              ),
            ),

            body: modelPost.isEmpty
                ? const Center(child: Text("No Post Yet"))
                : ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: modelPost.length,
                        itemBuilder: (context, index) {
                          // titleController.text = postmo[index].postTitle!;
                          // descriptionController.text =postmo[index].postDescription!;
                          // commentController.text = postmo[index].comment!;

                          if (modelPost.isEmpty) {
                            return const Text("No yet");
                          } else {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              child: Column(

                                  children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(

                                    child: Container(
                                      width: MediaQuery.of(context).size.width,

                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                             Row(
                                              children: [
                                                const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage("assets/images/pic.png"),
                                                ),
                                                const SizedBox(width: 10),


                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                        modelPost[index]
                                                            .name!),

                                                  ],
                                                )



                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            Text(
                                              modelPost[index]
                                                  .postDescription!,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            Container(

                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Colors.grey[200]
                                              ),


                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.comment_bank_outlined,color: Colors.grey,),
                                                    const SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(modelPost[index]
                                                          .comment!,
                                                        textAlign: TextAlign.start,
                                                        textDirection: TextDirection.ltr,
                                                        softWrap: true,
                                                        overflow: TextOverflow.fade,


                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: ()
                                    {
                                      navigateTo(context, CommentPage(
                                        postModelComment: modelPost[index],
                                        id: PostCubit.get(context).modelPost[index].id,
                                         nameUser: PostCubit.get(context).modelPost[index].name,
                                      ));
                                    },
                                  ),
                                ),
                              ]),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

            //Init Floating Action Bubble
            floatingActionButton: FloatingActionBubble(
              // Menu items
              items: <Bubble>[
                // Floating action menu item
                Bubble(
                  title: "Settings",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.settings,
                  titleStyle:
                  const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    navigateTo(context, const ContactUs());
                    _animationController.reverse();
                  },
                ),
                // Floating action menu item
                Bubble(
                  title: "Profile",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.people,
                  titleStyle:
                  const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    navigateTo(context, const ShowAllCourses());
                    _animationController.reverse();
                  },
                ),
                //Floating action menu item
                Bubble(
                  title: "Create Post",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.home,
                  titleStyle:
                  const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () {
                    navigateTo(context, CreatePost());
                  },
                ),
              ],

              // animation controller
              animation: _animation,

              // On pressed change animation state
              onPress: () => _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward(),

              // Floating Action button Icon color
              iconColor: Colors.blue,

              // Flaoting Action button Icon
              iconData: Icons.ac_unit,
              backGroundColor: Colors.white,
            ));
      },
    );
  }

  buildItemPost(
      {required String title, required String desc, required String comment}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.blue[200], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15)),
            child: Text("Title : $title"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15)),
              child: Text("Description : $desc"),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "Comment", hintStyle: TextStyle(fontSize: 20)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(15)),
            child: Text("Title : $comment"),
          ),
        ],
      ),
    );
  }

/*
  buildItemPost(
                                          title: post[index].postTitle!,
                                          desc: post[index].postDescription!,
                                          comment: post[index].comment!

                                      );
   */
}
