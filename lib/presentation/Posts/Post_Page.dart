import 'package:asec_application/model/post_model.dart';
import 'package:asec_application/presentation/Posts/comment_page.dart';
import 'package:asec_application/presentation/Settings/contact%20us.dart';
import 'package:asec_application/presentation/courses/See_more_Courses.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Constant/constant.dart';
import '../../bloc/get_information/user_information_cubit.dart';
import '../../bloc/post/post_cubit.dart';
import '../../generated/l10n.dart';
import '../project/project.dart';
import 'Create_Post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
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

        var finalPost = PostCubit.get(context).finalPost;

        return Scaffold(

            body: finalPost.isEmpty
                ? const Center(child: Text("No Post Yet"))
                : SafeArea(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 20.h),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: finalPost.length,
                                  itemBuilder: (context, index) {
                                    if (finalPost.isEmpty) {
                                      return const Text("No yet");
                                    } else {
                                      return Card(

                                        shadowColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        elevation: 10,

                                        child: Padding(
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage:
                                                        AssetImage(
                                                            "assets/images/pic.png"),
                                                  ),
                                                  const SizedBox(
                                                      width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [

                                                      Text(
                                                          finalPost[index]
                                                              .name!),


                                                      //Text('${UserAppInformationCubit.get(context).applicationUser!.firstName} ${UserAppInformationCubit.get(context).applicationUser!.lastName}'),
                                                      const SizedBox(
                                                          height: 5),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .check_circle,
                                                            color: Colors
                                                                .blue,
                                                            size: 15,
                                                          ),
                                                          SizedBox(
                                                              width: 5),
                                                          Text(
                                                            "response by Ahmed",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                finalPost[index]
                                                    .postDescription!,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              Container(

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Colors.grey[100]
                                                ),


                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.comment_bank_outlined,color: Colors.grey,size: 20,),
                                                      const SizedBox(width: 5),
                                                      Expanded(
                                                        child: Text(finalPost[index]
                                                            .comment!,
                                                          textAlign: TextAlign.start,
                                                          textDirection: TextDirection.ltr,
                                                          softWrap: true,
                                                          overflow: TextOverflow.fade,
                                                          style: TextStyle(fontSize: 12.sp),


                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ))
                      ],
                    ),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

            //Init Floating Action Bubble
            floatingActionButton: FloatingActionBubble(
              herotag: "NOHero",
              // Menu items
              items: <Bubble>[
                // Floating action menu item
                Bubble(
                  title: "Contact US",
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
              iconData: Icons.post_add_outlined,
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
