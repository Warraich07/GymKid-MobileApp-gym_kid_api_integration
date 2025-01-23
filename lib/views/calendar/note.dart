// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gym_kid/components/custom_button.dart';
// import 'package:gym_kid/res/dimens.dart';
// import 'package:gym_kid/views/auth/components/backround_video.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../components/custom_appbar.dart';
// import '../../components/dialogbox.dart';
// import '../../res/colors.dart';
//
// class Note extends StatefulWidget {
//   const Note({super.key});
//
//   @override
//   State<Note> createState() => _EmotionsState();
// }
//
// class _EmotionsState extends State<Note> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus!.unfocus();
//       },
//       child: BackgroundImage(
//
//         child: Padding(
//           padding: PAD_SYM_H20,
//           child: SingleChildScrollView(
//             child: SizedBox(
//               height: 90.h,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     IconButton(color: Colors.white, onPressed: () {
//                       Get.back();
//                     }, icon: Icon(Icons.arrow_back),),
//                     Text(
//                       'Anything you want to write in note',
//                       style: TextStyle(
//                         color: Get.isDarkMode ? Colors.white : Colors.white,
//                         fontSize: 25,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Add your notes on any thought that reflects your feeling at practice',
//                       style: TextStyle(
//                         color: Get.isDarkMode
//                             ? Colors.white.withOpacity(0.7)
//                             : Colors.white.withOpacity(0.7),
//                         fontSize: 15,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Stack(
//                       alignment: Alignment.topRight,
//                       children: [
//                         TextFormField(
//                           textInputAction: TextInputAction.done,
//                           controller: TextEditingController(),
//                           style: TextStyle(color: Colors.white),
//                           cursorColor: Colors.white,
//
//                           maxLines:
//                               10, // Set to null for unlimited lines, or specify a number
//                           decoration: InputDecoration(
//                             fillColor: Get.isDarkMode
//                                 ? AppColors.textfieldColor
//                                 : AppColors.textfieldColor,
//                             filled: true,
//                             hintText: 'Enter text here...',
//                             hintStyle: TextStyle(
//                                 color:
//                                     Get.isDarkMode ? Colors.white : Colors.white),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 borderRadius: BorderRadius.circular(20)),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 10.0, top: 10),
//                           child: Image.asset(
//                             'assets/icons/pin.png',
//                             height: 50,
//                           ),
//                         )
//                       ],
//                     ),
//                     Expanded(child: SizedBox()),
//                     // CustomButton.commonButton(
//                     //     onTap: () {
//                     //       Dialogbox.showHappyDialog(context,'');
//                     //     },
//                     //     buttonText: 'Save note'),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
