import 'package:flutter/material.dart';

class BackgroundImage extends StatefulWidget {
  final Widget child;

  const BackgroundImage({super.key, required this.child});

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // backgroundColor:Colors.indigo.shade900,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Display the GIF animation
          // Image.asset(
          //   'assets/app_images/neon_gift.gif', // Replace with your GIF file path
          //   fit: BoxFit.cover,
          // ),
          Container(
            child: widget.child, // Overlay your widget's child content
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// class BackgroundImage extends StatefulWidget {
//   final Widget child;
//
//   const BackgroundImage({super.key, required this.child});
//
//   @override
//   State<BackgroundImage> createState() => _BackgroundImageState();
// }
//
// class _BackgroundImageState extends State<BackgroundImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor:Colors.indigo.shade900,
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Display the Lottie animation
//           Lottie.asset(
//             'assets/app_images/rocket.json', // Replace with your Lottie file path
//             fit: BoxFit.cover, // Adjust this to fit your animation properly
//           ),
//           Container(
//             child: widget.child, // Overlay your widget's child content
//           ),
//         ],
//       ),
//     );
//   }
// }


//
// import 'package:cached_video_player/cached_video_player.dart';
// import 'package:flutter/material.dart';
//
// class BackgroundImage extends StatefulWidget {
//   final Widget child;
//   const BackgroundImage({super.key, required this.child});
//
//   @override
//   State<BackgroundImage> createState() => _BackgroundImageState();
// }
//
// class _BackgroundImageState extends State<BackgroundImage> {
//   CachedVideoPlayerController videoPlayerController = CachedVideoPlayerController.asset(
//     'assets/app_images/neon2_quLunjPp.mp4'
//       // "https://firebasestorage.googleapis.com/v0/b/vimvid-3db58.appspot.com/o/neon3.mp4?alt=media&token=c2852c5c-108c-4e4a-a199-8fb7a24de47d"
//   );
//
//   initializeData() async {
//     videoPlayerController = await CachedVideoPlayerController.asset(
//           'assets/app_images/neon2_quLunjPp.mp4')
//         // "https://firebasestorage.googleapis.com/v0/b/vimvid-3db58.appspot.com/o/neon2.mp4?alt=media&token=8cbcd0b5-6508-4900-8a26-ff4f4af8f7ff")
//       ..initialize().then((_) {
//         videoPlayerController.play(); // Play the video
//         videoPlayerController.setLooping(true); // Loop the video
//         setState(() {});
//       });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize your video controller here
//     initializeData();
//   }
//
//   // @override
//   // void dispose() {
//   //   videoPlayerController.pause(); // Pause the video before disposing
//   //   videoPlayerController.dispose(); // Dispose the controller when the widget is disposed
//   //   super.dispose();
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor:Colors.indigo.shade900,
//       // Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//          CachedVideoPlayer(videoPlayerController!),
//           Container(
//             child: widget.child,
//           ),
//         ],
//       ),
//     );
//   }
// }
