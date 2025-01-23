import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:flutter_timeline_calendar/timeline/provider/instance_provider.dart';
import 'package:flutter_timeline_calendar/timeline/utils/datetime_extension.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/page_navigation.dart';
import 'package:gym_kid/controllers/general_controller.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/homescreen/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/note.dart';
import '../../controllers/gym_controller.dart';
import '../../models/feeling_logs_model.dart';
import '../../res/colors.dart';
import '../navbar/bottom_nav_bar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late CalendarDateTime selectedDateTime;
  late DateTime? weekStart;
  late DateTime? weekEnd;
  List<FeelingsLogs> filtedList = [];
  String selectDate = '0';
  GymController _gymController=Get.find();
  @override
  void initState() {
    super.initState();
    TimelineCalendar.calendarProvider = createInstance();
    selectedDateTime = TimelineCalendar.calendarProvider.getDateTime();
    getLatestWeek();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String formattedDate = dateFormat.format(DateTime.now());
    _gymController.filterNotes(formattedDate);
  }

  getLatestWeek() {
    setState(() {
      weekStart = selectedDateTime.toDateTime().findFirstDateOfTheWeek();
      weekEnd = selectedDateTime.toDateTime().findLastDateOfTheWeek();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FeelingsLogs> feelingsList = [
      FeelingsLogs(
          date: '19',
          emoji: 'assets/icons/emoji (1).png',
          fulldate: DateTime(2023, 9, 19),
          description:
              'Today at practice i realized that Physical activity stimulates various brain chemicals that may leave you feeling happier, more relaxed and less anxious.',
          heading: 'Feeling Happy',
          color: Colors.blue),
      FeelingsLogs(
          date: '19',
          emoji: 'assets/icons/emoji (3).png',
          fulldate: DateTime(2023, 9, 19),
          description:
              'Today at practice i realized that Physical activity stimulates various brain chemicals that may leave you feeling happier, more relaxed and less anxious.',
          heading: 'Feeling Happy',
          color: Colors.yellow),
      FeelingsLogs(
          date: '23',
          emoji: 'assets/icons/emoji (1).png',
          fulldate: DateTime(2023, 9, 23),
          description:
              'Today at practice i realized that Physical activity stimulates various brain chemicals that may leave you feeling happier, more relaxed and less anxious.',
          heading: 'Feeling Happy',
          color: Colors.green),
      FeelingsLogs(
          date: '23',
          emoji: 'assets/icons/emoji (6).png',
          fulldate: DateTime(2023, 9, 23),
          description:
              'Today at practice i realized that Physical activity stimulates various brain chemicals that may leave you feeling happier, more relaxed and less anxious.',
          heading: 'Feeling Happy',
          color: Colors.pink),
    ];
    GymController _gymController = Get.find();
GeneralController _generalController=Get.find();

    return BackgroundImage(

      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  Get.back();
                }, icon: Icon(Icons.arrow_back),color: Colors.white,),
                Text("Calender",style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),),
                IconButton(
                    onPressed: () {
                      print("object");
                      _generalController.onBottomBarTapped(0);
                      Get.back();
                      Get.back();
                      // PageTransition.pageProperNavigation(page: CustomBottomNavBar());

                      // PageTransition.pageNavigation(page: const HomeScreen());
                    },
                    icon: Icon(
                      Icons.home_rounded,
                      color: Get.isDarkMode ? Colors.white : Colors.white,
                    ))
              ],
            ),
            _timelineCalendar(),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(
              height: 10,
            ),
            // selectDate == '22'
            //     ? Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           SizedBox(
            //               height: 250,
            //               child: ColorFiltered(
            //                   colorFilter: ColorFilter.mode(
            //                       Colors.blue, BlendMode.srcATop),
            //                   child: Lottie.asset('assets/no_data_found.json'))),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           Text(
            //             'No data Found',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 color: Get.isDarkMode ? Colors.white : Colors.white,
            //                 fontSize: 20),
            //           )
            //         ],
            //       )
            //     :
            Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Obx(
                        ()=>_gymController.isLoading.value==true?Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondaryColor,
                          ),
                        ):
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Notes',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            // const SizedBox(
                            //   height: ,
                            // ),
                           Container(
                                width: 95.w,
                                height: 400,
                                child:_gymController.filteredNotes.isEmpty?Center(
                                  child: Text("No Data Found",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w600),),
                                ): PageView.builder(

                                    itemCount: _gymController.filteredNotes.length,
                                    physics:PageScrollPhysics() ,
                                    itemBuilder: (context,index){
                                      final reasons = _gymController.notesList[index].reason;
                                      final formattedReasons = formatReasons(reasons);
                                      return  Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          // Image.asset
                                          Container(
                                            // margin: EdgeInsets.only(right: 50),
                                            height: 400, // Set the height for the image
                                            width: 95.w,
                                            child: Image.asset(
                                              'assets/images/note.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          // Rotated TextField
                                          Positioned(
                                            left: 50,
                                            top: 25,
                                            right: 20,
                                            child: Transform.rotate(
                                              angle: -3.5 * 3.141592653589793 / 180, // Rotate 90 degrees counterclockwise
                                              child: Container(
                                                // padding: EdgeInsets.only(right: 20),
                                                // color: Colors.green,
                                                height: 322, // Initial height of the TextField
                                                // width: 40.w,// Set the desired width of the TextField
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          _gymController.getEmoji(_gymController.filteredNotes[index].mood.toString()),
                                                          height: 50,
                                                        ),
                                                        Text(
                                                          _gymController.filteredNotes[index].mood.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                    // SizedBox(height: 8,),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "You were ",style: TextStyle(color: AppColors.primaryColor,fontSize: 16),
                                                        ),
                                                        Text(
                                                          _gymController.filteredNotes[index].mood.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 16,fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),
                                                    // Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       "Because of ",style: TextStyle(color: AppColors.primaryColor,fontSize: 16,),
                                                    //     ),
                                                    //     Text(
                                                    //       formattedReasons.toString(),style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 16),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    Container(
                                                      width: 300,
                                                      // color: Colors.green,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "Because of ", // The regular part of the sentence
                                                          style: TextStyle(
                                                            color: AppColors.primaryColor,
                                                            fontSize: 16,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: formattedReasons, // The formatted part with different style
                                                              style: TextStyle(
                                                                color: AppColors.primaryColor,
                                                                fontWeight: FontWeight.w500, // Bold for formattedReasons
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8,),
                                                    Text(
                                                      "Note:",style: TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w500),
                                                    ),
                                                    Text(
                                                      _gymController.filteredNotes[index].note.toString(),
                                                      maxLines: 7,
                                                      style: TextStyle(
                                                        color: AppColors.primaryColor,fontSize: 16,),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            // Expanded(
                            //   child: ListView.builder(
                            //     padding: EdgeInsets.zero,
                            //     physics: BouncingScrollPhysics(),
                            //     itemCount: 3,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       print(feelingsList[index].date);
                            //       return feelingsList[index].date == selectDate
                            //           ? NotePlane()
                            //           // Stack(
                            //           //         alignment: Alignment.topRight,
                            //           //         children: [
                            //           //           Transform(
                            //           //             transform: Matrix4.identity()
                            //           //               ..translate(0.0, 0.0)
                            //           //               ..rotateZ(-0.05),
                            //           //             child: Container(
                            //           //               margin: const EdgeInsets.only(
                            //           //                   bottom: 27),
                            //           //               decoration: BoxDecoration(
                            //           //                   color: AppColors.forgroundColor,
                            //           //                   borderRadius:
                            //           //                       BorderRadius.circular(20)),
                            //           //               child: Padding(
                            //           //                 padding: const EdgeInsets.only(
                            //           //                     top: 12, left: 12, right: 12),
                            //           //                 child: Column(
                            //           //                   crossAxisAlignment:
                            //           //                       CrossAxisAlignment.start,
                            //           //                   children: [
                            //           //                     Row(
                            //           //                       children: [
                            //           //                         Image.asset(
                            //           //                           feelingsList[index]
                            //           //                               .emoji,
                            //           //                           height: 50,
                            //           //                         ),
                            //           //                         const SizedBox(
                            //           //                           width: 10,
                            //           //                         ),
                            //           //                         Text(
                            //           //                             feelingsList[index]
                            //           //                                 .heading,
                            //           //                             style:
                            //           //                                 const TextStyle(
                            //           //                                     color: Colors
                            //           //                                         .white,
                            //           //                                     fontWeight:
                            //           //                                         FontWeight
                            //           //                                             .bold,
                            //           //                                     fontSize:
                            //           //                                         27)),
                            //           //                         /*  Image.asset(
                            //           //                     'assets/icons/emoji (1).png',
                            //           //                     height: 15,
                            //           //                     width: 15,
                            //           //                   ) */
                            //           //                       ],
                            //           //                     ),
                            //           //                     const SizedBox(
                            //           //                       height: 5,
                            //           //                     ),
                            //           //                     Text(
                            //           //                       feelingsList[index]
                            //           //                           .description,
                            //           //                       style: const TextStyle(
                            //           //                           color: Colors.white,
                            //           //                           fontSize: 14,
                            //           //                           height: 1.2),
                            //           //                     ),
                            //           //                     const SizedBox(
                            //           //                       height: 8,
                            //           //                     ),
                            //           //                     Row(
                            //           //                       mainAxisAlignment:
                            //           //                           MainAxisAlignment.end,
                            //           //                       children: [
                            //           //                         Text(
                            //           //                           DateFormat(
                            //           //                                   'EEEE, dd MMMM h:mma')
                            //           //                               .format(
                            //           //                                   feelingsList[
                            //           //                                           index]
                            //           //                                       .fulldate),
                            //           //                           style: TextStyle(
                            //           //                             fontSize: 12,
                            //           //                             color: Colors.grey
                            //           //                                 .withOpacity(0.5),
                            //           //                           ),
                            //           //                         ),
                            //           //                       ],
                            //           //                     ),
                            //           //                     const SizedBox(
                            //           //                       height: 10,
                            //           //                     ),
                            //           //                   ],
                            //           //                 ),
                            //           //               ),
                            //           //             ),
                            //           //           ),
                            //           //           Padding(
                            //           //             padding: const EdgeInsets.all(10.0),
                            //           //             child: Image.asset(
                            //           //               'assets/icons/pin.png',
                            //           //               height: 30,
                            //           //             ),
                            //           //           )
                            //           //         ],
                            //           //       )
                            //           : const SizedBox.shrink();
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _timelineCalendar() {
    GymController _gymController = Get.find();
    final DateTime specificDate = DateTime(2024, 8, 23);
    final DateTime today = DateTime.now();

    // Generate list of future dates starting from tomorrow
    List<DateTime> disabledFutureDates = [];
    DateTime nextDay = today.add(const Duration(days: 1));

    while (nextDay.isBefore(DateTime(2100))) { // Adjust as necessary for far future
      disabledFutureDates.add(nextDay);
      nextDay = nextDay.add(const Duration(days: 1));
    }
    return EasyDateTimeLine(
      disabledDates: disabledFutureDates,
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        // print(selectedDate);
        selectDate = selectedDate.day.toString();
        // print(selectDate);
        // setState(() {});
        final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        final String formattedDate = dateFormat.format(selectedDate);
        print('Selected Date (formatted): $formattedDate');
        _gymController.filterNotes(formattedDate);

        setState(() {});
      },
      activeColor: AppColors.buttonColor,
      headerProps: EasyHeaderProps(
        monthStyle:
            TextStyle(color: Get.isDarkMode ? Colors.white : Colors.white),
        selectedDateStyle:
            TextStyle(color: Get.isDarkMode ? Colors.white : Colors.white),
        monthPickerType: MonthPickerType.switcher,
        selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
      ),
      dayProps: EasyDayProps(
        todayHighlightStyle: TodayHighlightStyle.withBorder,
        todayStyle: DayStyle(
            dayNumStyle: TextStyle(
                fontSize: 20,
                color: Get.isDarkMode ? Colors.white : Colors.white
                ,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:
                  Get.isDarkMode ? AppColors.forgroundColor : AppColors.forgroundColor,
            )),
        borderColor: Colors.transparent,
        activeDayStyle: DayStyle(
            borderRadius: 32.0,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50), bottom: Radius.circular(50)))),
        inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColors.forgroundColor
                    : AppColors.forgroundColor,
                borderRadius: BorderRadius.circular(40)),
            borderRadius: 32.0,
            dayNumStyle: TextStyle(
                fontSize: 20,
                color: Get.isDarkMode ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      timeLineProps: const EasyTimeLineProps(
        hPadding: 16.0, // padding from left and right
        separatorPadding: 16.0, // padding between days
      ),
    );
  }
  String formatReasons(List<String> reasons) {
    if (reasons.isEmpty) {
      return '';
    } else if (reasons.length == 1) {
      return reasons[0];
    } else if (reasons.length == 2) {
      return '${reasons[0]} and${reasons[1]}';
    } else {
      final lastReason = reasons.removeLast();
      return '${reasons.join(',')}, and$lastReason';    }
  }
}
