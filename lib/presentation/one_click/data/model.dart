import 'package:asec_application/presentation/Posts/Post_Page.dart';
import 'package:asec_application/presentation/Settings/contact%20us.dart';
import 'package:asec_application/presentation/profile/profilePage.dart';
import 'package:flutter/material.dart';

import '../../certification/accpted_certiccation.dart';
import '../../chats/presentation/view/chat_screen.dart';
import '../../homepage/profile.dart';
import '../../podcast/videosPage.dart';
import '../../zoom_video/bim.dart';

class ItemsOfOneClick {
  String name;
  IconData icons;
  Widget screen;

  ItemsOfOneClick({
    required this.name,
    required this.icons,
    required this.screen,
  });
}

List<ItemsOfOneClick> items = [
  ItemsOfOneClick(
    name: "Profile",
    icons: Icons.account_circle,
    screen: const PersonalProfilePage(),
  ),
  ItemsOfOneClick(
    name: "Post",
    icons: Icons.post_add,
    screen: const PostPage(),
  ),
  ItemsOfOneClick(
    name: "CV Search",
    icons: Icons.plagiarism,
    screen: const ProFilePage(),
  ),
  ItemsOfOneClick(
    name: "Podcast",
    icons: Icons.mic,
    screen: const VideosPage(),
  ),
  /*
    ItemsOfOneClick(
    name: "LiveMeeting",
    icons: Icons.meeting_room,
    screen: LiveZoomMeetingPage(),
  ),
   */

  ItemsOfOneClick(
    name: "Certification",
    icons: Icons.card_membership,
    screen: const AcceptedCertification(),
  ),
  ItemsOfOneClick(
    name: "Contact us",
    icons: Icons.connect_without_contact,
    screen: const ContactUs(),
  ),
  ItemsOfOneClick(
    name: "Chat",
    icons: Icons.headset_mic,
    screen: const ChatScreen(),
  ),
  ItemsOfOneClick(
    name: "Discuss videos",
    icons: Icons.slideshow,
    screen: const MasterZoom(),
  ),
];
