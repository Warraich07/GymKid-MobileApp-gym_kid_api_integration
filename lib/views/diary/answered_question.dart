import 'package:delayed_display/delayed_display.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/views/diary/components/progress_indicator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:motion/motion.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../res/styles.dart';
import '../auth/components/backround_video.dart';
import '../homescreen/components/shimmer_previous_questions.dart';

class AnsweredQuestion extends StatefulWidget {
  const AnsweredQuestion({super.key});

  @override
  State<AnsweredQuestion> createState() => _AnsweredQuestionState();
}

class _AnsweredQuestionState extends State<AnsweredQuestion> {
  final String todayFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gymController.getPreviousAnswers('2024-08-23');

  }
  GymController _gymController=Get.find();
  String selectDate = '';
  Widget newQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Obx(
    ()=>_gymController.isLoading.value==true?ShimmerPreviousQuestionScreen() :Container(
            height: 300,
            child:_gymController.previousAnsweredList.isEmpty?Center(
              child: Text("No Answers",style: TextStyle(color: Colors.white),),
            ): PageView.builder(
                itemCount: _gymController.previousAnsweredList.length,
                itemBuilder: (context,index){
                  String originalDate = _gymController.questionsList[index].date;
                  final DateFormat originalFormat = DateFormat('dd-MM-yyyy');
                  final DateTime dateTime = originalFormat.parse(originalDate);
                  final DateFormat newFormat = DateFormat('dd/MM/yyyy');
                  String newDate = newFormat.format(dateTime);
              return Motion.elevated(
                filterQuality: FilterQuality.medium,
                elevation: 50,
                glare: true,
                borderRadius: BorderRadius.circular(20),
                // controller: MotionController(),
                child: Container(
                  margin:   EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  decoration: ShapeDecoration(
                    color: AppColors.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 46,
                              height: 46,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/icons/profile.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(64),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Eleanor Pena',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Admin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          _gymController.previousAnsweredList[index].title.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _gymController.previousAnsweredList[index].totalAnswers.toString()+ ' answers',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.16,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                            itemCount: _gymController.previousAnsweredList[index].getOptions.length,
                            itemBuilder: (context,index1){
                              // Find the maximum value in the list
                              double maxValue = _gymController.previousAnsweredList[index]
                                  .getOptions
                                  .map((option) => option.totalAnswers.toDouble())
                                  .reduce((a, b) => a > b ? a : b);

                              // Get the current value
                              double currentValue = _gymController.previousAnsweredList[index]
                                  .getOptions[index1]
                                  .totalAnswers
                                  .toDouble();

                              // Determine progress color
                              Color progressColor = currentValue == maxValue
                                  ? Colors.green  // Set to green if the current value is the maximum
                                  : Color(0xffE0AD3A);  // Default color
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyCustomProgressBar(
                              value: _gymController.previousAnsweredList[index].getOptions[index1].totalAnswers.toDouble(),
                              text: _gymController.previousAnsweredList[index].getOptions[index1].option,
                              check: true,
                              progressColor: progressColor,
                            ),
                          );
                        }),

                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // MyCustomProgressBar(
                        //   value: 30,
                        //   text: 'No. I didn’t feel any change',
                        //   check: false,
                        // ),
                        /*  ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 50 / 100, // Convert to a value between 0 and 1
                          minHeight: 30, // Adjust the height as needed
                          backgroundColor: Color(0xFF333333), // Background color
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.buttonColor), // Progress color
                        ),
                      ), */
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _gymController.previousAnsweredList[index].time.toString()+",  "+newDate,
                            // '9:04 pm, 14/09/2023',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4000000059604645),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:
      //     Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   automaticallyImplyLeading: false,
      //   title: CustomAppBar(
      //     pageTitle: "Previous Questions",
      //     onTap: () {
      //       Get.back();
      //     },
      //   ),
      // ),
      body: BackgroundImage(
        child: Padding(
          padding: PAD_SYM_H20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5.h,
              ),
              SizedBox(width: 20,),
              Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                  Text('Answered Questions', style: headingHomeStyle)
                ],
              ),
              DelayedDisplay(
                slidingBeginOffset: Offset(0, 0),
                child: _timelineCalendar(),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white.withOpacity(0.3),
              ),
              const SizedBox(
                height: 20,
              ),
              todayFormatted==selectDate? Text('Today\s Questions', style: headingHomeStyle):Container(),
              const SizedBox(
                height: 20,
              ),
              // selectDate == '23'
              //     ? Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             SizedBox(
              //                 height: 250,
              //                 child: ColorFiltered(
              //                     colorFilter: const ColorFilter.mode(
              //                         Colors.blue, BlendMode.srcATop),
              //                     child:
              //                         Lottie.asset('assets/no_data_found.json'))),
              //             const SizedBox(
              //               height: 20,
              //             ),
              //             Text(
              //               'No Data Found',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color:
              //                       Get.isDarkMode ? Colors.white : Colors.black,
              //                   fontSize: 20),
              //             )
              //           ],
              //         ),
              //       )
              //     :
              newQuestion()
            ],
          ),
        ),
      ),
    );
  }

  _timelineCalendar() {
    bool isPreviousDateSelected = false;
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
      initialDate:specificDate,
      onDateChange: (selectedDate) {
        // print(selectedDate);
        selectDate = selectedDate.day.toString();
        // print(selectDate);
        // setState(() {});
        final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        final String formattedDate = dateFormat.format(selectedDate);
        print('Selected Date (formatted): $formattedDate');
        _gymController.getPreviousAnswers(formattedDate);

        setState(() {});
        // selectDate = selectedDate.day.toString();
        // setState(() {});
        // print(selectedDate);
        //`selectedDate` the new date selected.
      },
      activeColor: isPreviousDateSelected
          ? Colors.green // Arrow color when a previous date is selected
          : AppColors.fontColor,
      headerProps: EasyHeaderProps(
          showMonthPicker:true,
        monthStyle: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.white,fontWeight: FontWeight.w600,),
        selectedDateStyle: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.white,fontWeight: FontWeight.w800,),
        monthPickerType: MonthPickerType.switcher,
        selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
      ),
      dayProps: EasyDayProps(
        todayHighlightStyle: TodayHighlightStyle.withBorder,
        todayStyle: DayStyle(
                dayNumStyle: TextStyle(
                fontSize: 20,
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Get.isDarkMode ? AppColors.forgroundColor : Color(0xffF6F6F6),
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
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      timeLineProps: const EasyTimeLineProps(
        hPadding: 16.0, // padding from left and right
        separatorPadding: 16.0, // padding between days
      ),
    );
  }
}
