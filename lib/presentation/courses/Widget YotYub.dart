// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class Youtube extends StatefulWidget {
//   const Youtube({required this.path, Key? key}) : super(key: key);
//
//   final String path;
//
//   @override
//   State<Youtube> createState() => _YoutubeState();
// }
//
// class _YoutubeState extends State<Youtube> {
//   String link = "";
//
//   late YoutubePlayer youtubePlayer;
//   late YoutubePlayerController _controller;
//   late String id;
//
//   @override
//   void initState() {
//     super.initState();
//     link = widget.path;
//     id = YoutubePlayer.convertUrlToId(link)!;
//     _controller = YoutubePlayerController(
//       initialVideoId: id,
//       flags: const YoutubePlayerFlags(autoPlay: false),
//     );
//     youtubePlayer = YoutubePlayer(
//       controller: _controller,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               height: MediaQuery.of(context).size.height * .3,
//               width: double.infinity,
//               color: Colors.pink,
//               child: youtubePlayer,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
