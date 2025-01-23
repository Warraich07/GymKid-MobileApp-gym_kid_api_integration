// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gym_kid/components/custom_button.dart';
// import 'package:gym_kid/components/page_navigation.dart';
// import 'package:gym_kid/res/dimens.dart';
// import 'package:gym_kid/views/auth/components/backround_video.dart';
// import 'package:intl/intl.dart';
//
// import '../../components/custom_appbar.dart';
// import '../../res/colors.dart';
// import 'note.dart';
//
// class SelectDate extends StatefulWidget {
//   const SelectDate({super.key});
//
//   @override
//   State<SelectDate> createState() => _SelectDateState();
// }
//
// class _SelectDateState extends State<SelectDate> {
//   List<String> emotions = [
//     'Confused',
//     'Excited',
//     'Cool',
//     'Peaceful',
//     'Bad',
//     'Terrible'
//   ];
//   int select = -1;
//   String _selectedDate = 'Select date';
//   String _selectedTime = 'Select time';
//   DateTime date = DateTime.now();
//   TimeOfDay time = TimeOfDay.now();
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? d = await showDatePicker(
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             dialogBackgroundColor: AppColors.bottombarColor,
//             colorScheme: ColorScheme.light(
//               primary: Colors.white, // <-- SEE HERE
//               onPrimary: Colors.black, // <-- SEE HERE
//               onSurface: Colors.white, // <-- SEE HERE
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(5090),
//     );
//     if (d != null) {
//       setState(() {
//         date = d;
//         _selectedDate = DateFormat.yMMMMd("en_US").format(d);
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? selectedTime = await showTimePicker(
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             // Use ThemeData.dark() for a black theme
//             primaryColor: Colors.white,
//             hintColor: Colors.white,
//             colorScheme: ColorScheme.dark(
//               primary: Colors.white,
//               onPrimary: Colors.white,
//               surface: AppColors.forgroundColor,
//               onSurface: Colors.white,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (selectedTime != null) {
//       setState(() {
//         time = selectedTime;
//         _selectedTime =
//             selectedTime.format(context); // Format the selected time
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BackgroundImage(
//
//       child: Padding(
//         padding: PAD_SYM_H20,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             AppBar(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               automaticallyImplyLeading: false,
//               title: CustomAppBar(
//                 pageTitle: "",
//                 onTap: () {
//                   Get.back();
//                 },
//               ),
//             ),
//             Text(
//               'Select date and time',
//               style: TextStyle(
//                 color: Get.isDarkMode ? Colors.white : Colors.white,
//                 fontSize: 25,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Select  date and time to add your emotion to gym_kid',
//               style: TextStyle(
//                 color: Get.isDarkMode
//                     ? Colors.white.withOpacity(0.7)
//                     : Colors.white.withOpacity(0.7),
//                 fontSize: 15,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             Text(
//               'Date:',
//               style: TextStyle(
//                 color: Get.isDarkMode ? Colors.white : Colors.white,
//                 fontSize: 15,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 53,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(40),
//                   color: Get.isDarkMode
//                       ? AppColors.forgroundColor.withOpacity(0.65)
//                       : AppColors.forgroundColor.withOpacity(0.65),),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       InkWell(
//                         child: Text(_selectedDate,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.white)),
//                         onTap: () {
//                           _selectDate(context);
//                         },
//                       ),
//                       IconButton(
//                         icon: Image.asset(
//                           'assets/icons/calendar.png',
//                           height: 30,
//                           width: 30,
//                         ),
//                         tooltip: 'Select date',
//                         onPressed: () {
//                           _selectDate(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 60,
//             ),
//             Text(
//               'Time:',
//               style: TextStyle(
//                 color: Get.isDarkMode ? Colors.white : Colors.white,
//                 fontSize: 15,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 53,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(40),
//                   color: Get.isDarkMode
//                       ? AppColors.forgroundColor.withOpacity(0.65)
//                       :  AppColors.forgroundColor.withOpacity(0.65),),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       InkWell(
//                         child: Text(_selectedTime,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.white)),
//                         onTap: () {
//                           _selectDate(context);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.access_time_outlined,
//                           size: 25,
//                           color: AppColors.buttonColor,
//                         ),
//                         tooltip: 'Select Time',
//                         onPressed: () {
//                           _selectTime(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const Expanded(
//               child: SizedBox(),
//             ),
//             CustomButton.commonButton(
//                 onTap: () {
//                   PageTransition.pageNavigation(page: const Note());
//                 },
//                 buttonText: 'Next'),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
