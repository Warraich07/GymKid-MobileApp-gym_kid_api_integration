// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../components/custom_appbar.dart';
// import '../../components/custom_button.dart';
// import '../../res/colors.dart';
//
// class ChoosePlan extends StatefulWidget {
//   const ChoosePlan({super.key});
//
//   @override
//   State<ChoosePlan> createState() => _ChoosePlanState();
// }
//
// class _ChoosePlanState extends State<ChoosePlan> {
//   int selectedId = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Get.isDarkMode
//           ? AppColors.backgroundColor
//           : AppColors.lightBackgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         title: CustomAppBar(
//           pageTitle: "",
//           onTap: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: SizedBox(
//         height: 100.h,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 15.0),
//           child: Column(
//             children: [
//               Text(
//                 "BE PREMIUM",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Get.isDarkMode ? Colors.white : Colors.black,
//                   fontSize: 40,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "GET UNLIMITED ACCESS",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Get.isDarkMode ? Colors.white : Colors.black,
//                   fontSize: 24,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
//                 child: Text(
//                   "Subscribe now to get instant \nunlimited access!",
//                   style: TextStyle(
//                     color: Get.isDarkMode ? Colors.white : Colors.black,
//                     fontSize: 14,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400,
//                     height: 0,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const Expanded(child: SizedBox()),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     selectedId = 0;
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   height: 90,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Get.isDarkMode
//                           ? AppColors.darkContainerColor
//                           : AppColors.lightContainerColor,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                           width: 1,
//                           color: selectedId == 0
//                               ? AppColors.buttonColor
//                               : Colors.transparent)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               selectedId == 1
//                                   ? /*  ThemeService().isDarkMode
//                                       ? "assest/images/unSelectedRadioL.png"
//                                       : */
//                                   "assets/images/unSelectedRadio.png"
//                                   : "assets/images/selectedRadio.png",
//                               height: 20,
//                               width: 20,
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Monthly",
//                                   style: TextStyle(
//                                     color: Get.isDarkMode
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Poppins',
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "Pay monthly, cancel any time",
//                                   style: TextStyle(
//                                     color: Color(0xFF218DCA),
//                                     fontSize: 9,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               "\$3.99",
//                               style: TextStyle(
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 21,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                             Text(
//                               "/m",
//                               style: TextStyle(
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: 'Poppins',
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               // InkWell(
//               //   onTap: () {
//               //     setState(() {
//               //       selectedId = 1;
//               //     });
//               //   },
//               //   child: Container(
//               //     padding: const EdgeInsets.symmetric(horizontal: 20),
//               //     height: 90,
//               //     width: double.infinity,
//               //     decoration: BoxDecoration(
//               //         color: Get.isDarkMode
//               //             ? AppColors.darkContainerColor
//               //             : AppColors.lightContainerColor,
//               //         borderRadius: BorderRadius.circular(16),
//               //         border: Border.all(
//               //             width: 1,
//               //             color: selectedId == 1
//               //                 ? AppColors.buttonColor
//               //                 : Colors.transparent)),
//               //     child: Padding(
//               //       padding: const EdgeInsets.only(left: 8.0),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: [
//               //           Row(
//               //             children: [
//               //               Image.asset(
//               //                 selectedId == 0
//               //                     ? /* ThemeService().isDarkMode
//               //                         ? "assest/images/unSelectedRadioL.png"
//               //                         :  */
//               //                     "assets/images/unSelectedRadio.png"
//               //                     : "assets/images/selectedRadio.png",
//               //                 height: 20,
//               //                 width: 20,
//               //               ),
//               //               const SizedBox(
//               //                 width: 20,
//               //               ),
//               //               Column(
//               //                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                 mainAxisAlignment: MainAxisAlignment.center,
//               //                 children: [
//               //                   Text(
//               //                     "Yearly",
//               //                     style: TextStyle(
//               //                       color: Get.isDarkMode
//               //                           ? Colors.white
//               //                           : Colors.black,
//               //                       fontSize: 17,
//               //                       fontWeight: FontWeight.w600,
//               //                       fontFamily: 'Poppins',
//               //                     ),
//               //                   ),
//               //                   SizedBox(
//               //                     height: 5,
//               //                   ),
//               //                   Text(
//               //                     "Pay for a full year",
//               //                     style: TextStyle(
//               //                       color: Get.isDarkMode
//               //                           ? Colors.white
//               //                           : Colors.black,
//               //                       fontSize: 11,
//               //                       fontWeight: FontWeight.w400,
//               //                       fontFamily: 'Poppins',
//               //                     ),
//               //                   ),
//               //                 ],
//               //               ),
//               //             ],
//               //           ),
//               //           Row(
//               //             crossAxisAlignment: CrossAxisAlignment.end,
//               //             children: [
//               //               Text(
//               //                 "\$ 129.99",
//               //                 style: TextStyle(
//               //                   color: Get.isDarkMode
//               //                       ? Colors.white
//               //                       : Colors.black,
//               //                   fontSize: 21,
//               //                   fontWeight: FontWeight.w600,
//               //                   fontFamily: 'Poppins',
//               //                 ),
//               //               ),
//               //               Text(
//               //                 "/y",
//               //                 style: TextStyle(
//               //                   color: Get.isDarkMode
//               //                       ? Colors.white
//               //                       : Colors.black,
//               //                   fontSize: 12,
//               //                   fontWeight: FontWeight.w400,
//               //                   fontFamily: 'Poppins',
//               //                 ),
//               //                 textAlign: TextAlign.center,
//               //               ),
//               //             ],
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               const Expanded(child: SizedBox()),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(
//                   "7 Days Trial - Credit card required for sign up",
//                   style: TextStyle(
//                     color: Get.isDarkMode ? Colors.white : Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               CustomButton.commonButton(
//                 buttonText: "Continue with free trial",
//                 onTap: () {},
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Privacy Policy",
//                       style: TextStyle(
//                         color: Get.isDarkMode ? Colors.white : Colors.black,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     Container(
//                       height: 20,
//                       width: 1.5,
//                       color: Get.isDarkMode ? Colors.white : Colors.black,
//                     ),
//                     Text(
//                       "Restore Purchase",
//                       style: TextStyle(
//                         color: Get.isDarkMode ? Colors.white : Colors.black,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     Container(
//                       height: 20,
//                       width: 1.5,
//                       color: Get.isDarkMode ? Colors.white : Colors.black,
//                     ),
//                     Text(
//                       "Terms of use",
//                       style: TextStyle(
//                         color: Get.isDarkMode ? Colors.white : Colors.black,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 "You can cancel your subscription or trial anytime by cancelling your subscription through your iTunes account settings, or it will automatically renew. This must be done 24 hours before the end of the trial or any subscription period to avoid being charged. Subscription",
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Poppins',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
