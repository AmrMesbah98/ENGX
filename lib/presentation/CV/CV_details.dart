// import 'package:asec_application/model/CV_Model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class CvDetails extends StatelessWidget {
//   const CvDetails({super.key, required this.cvModel,required this.pro});
//
//   final CvModel cvModel;
//   final List pro;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarIconBrightness: Brightness.light,
//           statusBarColor: Colors.lightBlue[900],
//         ),
//       child: Scaffold(
//         body: SafeArea(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF66a3e8),
//                       Color(0xFFFFFFFF),
//                     ],
//                     begin: FractionalOffset(0.0, 0.0),
//                     end: FractionalOffset(1.0, 0.0),
//                     stops: [0.0, 1.0],
//                     tileMode: TileMode.clamp),
//
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Container(
//                     width: MediaQuery.of(context).size.width ,
//                     decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                             colors: [
//                               Color(0xFF66a3e8),
//                               Color(0xFFFFFFFF),
//                             ],
//                             begin: FractionalOffset(0.0, 0.0),
//                             end: FractionalOffset(1.0, 0.0),
//                             stops: [0.0, 1.0],
//                             tileMode: TileMode.clamp),
//
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Image(
//                               image: const AssetImage("assets/images/CV.png"),
//                               width: MediaQuery.of(context).size.width * .3,
//                               height: MediaQuery.of(context).size.height * .2,
//                               fit: BoxFit.fill,
//                             ),
//
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 InternalDetailsItem(
//                                   text: "Name: ${cvModel.name}",
//                                 ),
//                                 InternalDetailsItem(
//                                   text: "Email: ${cvModel.email}",
//                                 ),
//                                 InternalDetailsItem(
//                                   text: "Phone: ${cvModel.phone}",
//                                 ),
//                                 InternalDetailsItem(
//                                   text: "Position: ${cvModel.positionCv}",
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 10),
//                         const Align(
//                             alignment: Alignment.center,
//                             child: Text("Personal Inforamtion",style: TextStyle(fontSize: 20,color: Colors.black54),)
//                         ),
//                         const SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white54,
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InternalDetailsItem(
//                                     text: "name: ${cvModel.name}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text: "Email: ${cvModel.email}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text: "Phone: ${cvModel.phone}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text: "Position: ${cvModel.specialization}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text:
//                                     "Graduation Year: ${cvModel.graduationYear}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text:
//                                     "Experience Year: ${cvModel.experienceYear}",
//                                   ),
//                                   ListView.builder(
//                                       itemCount: cvModel.pro!.length,
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       physics: const BouncingScrollPhysics(),
//                                       itemBuilder: (context, index){
//                                         return Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 1),
//                                           child: Text(" Skills: ${pro[index]}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
//                                         );
//                                       }
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 10),
//                         const Align(
//                             alignment: Alignment.center,
//                             child: Text("Last Work",style: TextStyle(fontSize: 20,color: Colors.black54),)
//                         ),
//                         const SizedBox(height: 10),
//                         Container(
//                          height: MediaQuery.of(context).size.height*.2,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               color: Colors.white54,
//                               borderRadius: BorderRadius.circular(20)
//                           ),
//                           child: Row(
//                             children: [
//
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InternalDetailsItem(
//                                     text: "Comapny Name: ${cvModel.companyName}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text: "From: ${cvModel.startDate}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text: "To: ${cvModel.endDate}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text: "Position: ${cvModel.positionCv}",
//                                   ),
//                                   InternalDetailsItem(
//                                     text:
//                                     "ShareProject: ${cvModel.shareProject} Year",
//                                   ),
//
//                                 ],
//                               ),
//
//                             ],
//                           ),
//                         ),
//
//
//
//
//
//
//
//
//
//
//
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class InternalDetailsItem extends StatelessWidget {
//   InternalDetailsItem({super.key, required this.text});
//
//   String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
//           child: Text(
//             text,
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
//           ),
//         ),
//
//       ],
//     );
//   }
// }
