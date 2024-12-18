// import 'package:asec_application/presentation/CV/search_CV.dart';
// import 'package:asec_application/presentation/Settings/contact%20us.dart';
// import 'package:asec_application/shared/components/components.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../bloc/get_information/user_information_cubit.dart';
// import '../presentation/CV/cv_share.dart';
// import '../presentation/Golden_Member/Golden_Page.dart';
// import '../presentation/Info_Character/info_Character.dart';
// import '../presentation/profile/profilePage.dart';
//
//
// buildDrawer(BuildContext ctx) {
//   return Drawer(
//
//     child: ListView(
//
//       padding: const EdgeInsets.all(0),
//       children: [
//          DrawerHeader(
//           decoration: const BoxDecoration(
//
//             gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF66a3e8),
//                   Color(0xFF4d4dff),
//                 ],
//                 begin: FractionalOffset(0.0, 0.0),
//                 end: FractionalOffset(1.0, 0.0),
//                 stops: [0.0, 1.0],
//                 tileMode: TileMode.clamp),
//           ), //BoxDecoration
//           child: UserAccountsDrawerHeader(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF66a3e8),
//                     Color(0xFF4d4dff),
//                   ],
//                   begin: FractionalOffset(0.0, 0.0),
//                   end: FractionalOffset(1.0, 0.0),
//                   stops: [0.0, 1.0],
//                   tileMode: TileMode.clamp),
//             ),
//             accountName:  BlocBuilder<UserAppInformationCubit,
//                 UserInformationState>(
//                   builder: (context, state) {
//                 if (state is ErrorInformationState) {
//                   return Text(state.errMessage);
//                 } else if (state is SuccsessInformationState) {
//                   return Text(
//                     "${state.informationAccount["firstName"]} ${state.informationAccount["lastName"]} ",
//                     //_mAuth.currentUser!.email!,
//                     style: const TextStyle(fontSize: 25),
//                   );
//                 }
//                 return Shimmer.fromColors(
//                   baseColor: Colors.blue.shade300,
//                   highlightColor: Colors.blue.shade100,
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     color: Colors.blue.shade300,
//                   ),
//                 );
//               },
//             ),
//             accountEmail: BlocBuilder<UserAppInformationCubit,
//                 UserInformationState>(
//               builder: (context, state) {
//                 if (state is ErrorInformationState) {
//                   return Text(state.errMessage);
//                 } else if (state is SuccsessInformationState) {
//                   return Text(
//                     "${state.informationAccount["email"]} ",
//                     //_mAuth.currentUser!.email!,
//                     style: const TextStyle(fontSize: 15),
//                   );
//                 }
//                 return Shimmer.fromColors(
//                   baseColor: Colors.blue.shade300,
//                   highlightColor: Colors.blue.shade100,
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     color: Colors.blue.shade300,
//                   ),
//                 );
//               },
//             ),
//             currentAccountPictureSize: const Size.square(40),
//             currentAccountPicture:  CircleAvatar(
//               backgroundColor: const Color.fromARGB(255, 165, 255, 137),
//               child: BlocBuilder<UserAppInformationCubit,
//                   UserInformationState>(
//                 builder: (context, state) {
//                   if (state is ErrorInformationState) {
//                     return Text(state.errMessage);
//                   } else if (state is SuccsessInformationState) {
//                     return Text(
//                       "${state.informationAccount["firstName"][0]}",
//                       //_mAuth.currentUser!.email!,
//                       style: const TextStyle(fontSize: 25),
//                     );
//                   }
//                   return Shimmer.fromColors(
//                     baseColor: Colors.blue.shade300,
//                     highlightColor: Colors.blue.shade100,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       color: Colors.blue.shade300,
//                     ),
//                   );
//                 },
//               )
//             ), //circleAvatar
//           ), //UserAccountDrawerHeader
//         ), //DrawerHeader
//         ListTile(
//           leading: const Icon(Icons.person),
//           title: const Text(' My Profile '),
//           onTap: () {
//            navigateTo(ctx, const Info());
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.workspace_premium),
//           title: const Text('Go Premium'),
//           onTap: () {
//             navigateTo(ctx, const GoldenMember());
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.contact_page),
//           title: const Text('CV Share'),
//           onTap: () {
//             navigateTo(ctx,  ShareCV());
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.find_in_page),
//           title: const Text('CV Search'),
//           onTap: () {
//             navigateTo(ctx,   SearchCV());
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.email_outlined),
//           title: const Text('Contact US'),
//           onTap: () {
//             navigateTo(ctx, const ContactUs());
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.privacy_tip_outlined),
//           title: const Text('Privacy Policy'),
//           onTap: () {
//             navigateTo(ctx, const ProFilePage());
//           },
//         ),
//       ],
//     ),
//   );
// }
