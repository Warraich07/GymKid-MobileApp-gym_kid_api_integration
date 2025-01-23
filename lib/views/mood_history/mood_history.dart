// import 'package:delayed_display/delayed_display.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:motion/motion.dart';
//
// import '../../res/colors.dart';
// import '../../res/styles.dart';
// import 'line_graph.dart';
//
// class MoodHistory extends StatefulWidget {
//   const MoodHistory({Key? key}) : super(key: key);
//
//   @override
//   State<MoodHistory> createState() => _MoodHistoryState();
// }
//
// class _MoodHistoryState extends State<MoodHistory> {
//   bool showGraph = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Get.isDarkMode
//           ? AppColors.backgroundColor
//           : AppColors.lightBackgroundColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80.0),
//         child: AppBar(
//             elevation: 1,
//             shadowColor: Get.isDarkMode ? Colors.white : Colors.black,
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(
//                   40.0), // Set your desired height for the bottom area
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: Row(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon:  Icon(Icons.arrow_back,color: Get.isDarkMode ? Colors.white : Colors.black)),
//                       Container(
//                         margin: const EdgeInsets.only(
//                           left: 30.0,
//                         ), // Add space around the bottom title
//                         child: Text('Mood History', style: AppStyles.style20),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             backgroundColor:
//                 Get.isDarkMode ? AppColors.backgroundColor : Colors.white),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: DelayedDisplay(
//             slidingBeginOffset: Offset(0, 0),
//             delay: Duration(milliseconds: 500),
//             child: Column(
//               children: [
//                 Text(
//                   'Mood analysis in-progress',
//                   style: TextStyle(
//                     color: Get.isDarkMode ? Colors.white : Colors.black,
//                     fontSize: 25,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Track your mood history and progress\nover time automatically',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Get.isDarkMode
//                         ? Colors.white.withOpacity(0.5)
//                         : Colors.black.withOpacity(0.5),
//                     fontSize: 15,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 showGraph
//                     ? Motion.elevated(
//                   filterQuality: FilterQuality.medium,
//                   elevation: 50,
//                   glare: true,
//                   borderRadius: BorderRadius.circular(20),
//                   // controller: MotionController(),
//                       child: Container(
//                           width: Get.width,
//                           height: 272,
//                           decoration: ShapeDecoration(
//                             color: Get.isDarkMode
//                                 ? const Color(0xFF2D2D2D)
//                                 : const Color(0xffF6F6F6),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Text(
//                                       'September',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Color(0xFFE0AD3A),
//                                         fontSize: 15,
//                                         fontFamily: 'Montserrat',
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       '2023',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Get.isDarkMode
//                                             ? Colors.white
//                                             : Colors.black,
//                                         fontSize: 12,
//                                         fontFamily: 'Montserrat',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           const TextSpan(
//                                             text: 'Saturday',
//                                             style: TextStyle(
//                                               color: Color(0xFF70B25D),
//                                               fontSize: 10,
//                                               fontFamily: 'Poppins',
//                                               fontWeight: FontWeight.w500,
//                                               height: 0.16,
//                                             ),
//                                           ),
//                                           TextSpan(
//                                             text: ',16/09/2023',
//                                             style: TextStyle(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white.withOpacity(0.5)
//                                                   : Colors.black.withOpacity(0.5),
//                                               fontSize: 10,
//                                               fontFamily: 'Poppins',
//                                               fontWeight: FontWeight.w500,
//                                               height: 0.16,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Get.isDarkMode
//                                         ? Image.asset(
//                                             'assets/images/chart_background.png')
//                                         : Image.asset(
//                                             'assets/images/chart_light.png'),
//                                     Positioned(left: 50, child: LineGraph()),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )),
//                     )
//                     : GestureDetector(
//                         onTap: () {
//                           showGraph = !showGraph;
//                           setState(() {});
//                         },
//                         child: Get.isDarkMode
//                             ? Image.asset(
//                                 'assets/images/mood_history.png',
//                                 width: Get.width,
//                               )
//                             : Image.asset(
//                                 'assets/images/graph_light.png',
//                                 width: Get.width,
//                               ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
