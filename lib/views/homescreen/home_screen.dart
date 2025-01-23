import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/components/page_navigation.dart';
import 'package:gym_kid/controllers/auth_controller.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/views/diary/answered_question.dart';
import 'package:gym_kid/views/homescreen/components/gauge_meter.dart';
import 'package:gym_kid/views/mood_history/mood_history.dart';
import 'package:intl/intl.dart';
import 'package:motion/motion.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../components/note.dart';
import '../../controllers/gym_controller.dart';
import '../../models/feeling_logs_model.dart';
import '../../res/styles.dart';
import '../auth/components/backround_video.dart';
import '../calendar/emotions.dart';
import 'components/chart.dart';
import 'components/shimmer_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool question = false;
  GymController _gymController = Get.find();
  AuthController _authController=Get.find();
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool cardIndex = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    // final String formattedDate = dateFormat.format(DateTime.now());
    _gymController.getQuestions('2024-08-23');
    _gymController.getNotes();

    // _gymController.getPreviousAnswers('2024-08-23');

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
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
      //   elevation: 0,
      //   title:                 Padding(
      //     padding: const EdgeInsets.only(top: 10.0),
      //     child: DelayedDisplay(
      //       delay: const Duration(milliseconds: 1000),
      //       slidingBeginOffset: const Offset(0, 0),
      //       child: Text.rich(
      //         TextSpan(
      //           children: [
      //             TextSpan(
      //               text: 'Welcome Marvin 👋',
      //               style: TextStyle(
      //                 color:
      //                 Get.isDarkMode ? Colors.white : Colors.black,
      //                 fontSize: 20,
      //                 fontFamily: 'Poppins',
      //                 fontWeight: FontWeight.w400,
      //                 height: 0.07,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      //
      // ),
      body: BackgroundImage(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: PAD_SYM_H20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DelayedDisplay(
                //   delay: const Duration(milliseconds: 1000),
                //   slidingBeginOffset: const Offset(0, 0),
                //   child: Text.rich(
                //     TextSpan(
                //       children: [
                //         TextSpan(
                //           text: 'Welcome Marvin 👋',
                //           style: TextStyle(
                //             color:
                //             Get.isDarkMode ? Colors.white : Colors.black,
                //             fontSize: 20,
                //             fontFamily: 'Poppins',
                //             fontWeight: FontWeight.w400,
                //             height: 0.07,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // DelayedDisplay(
                //   delay: const Duration(milliseconds: 500),
                //   slidingBeginOffset: const Offset(0, -1),
                //   child: CustomTextField.authInputFields(
                //       textEditingController: TextEditingController(),
                //       hint: "Search",
                //       prefixIcon: Image.asset(
                //         'assets/icons/search.png',
                //       )),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 60,bottom: 25),
                  child: Text(
                    'Welcome ${_authController.userData.value!.name} 👋',
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.07,
                    ),
                  ),
                ),
                DelayedDisplay(
                    delay: const Duration(milliseconds: 500),
                    slidingBeginOffset: const Offset(0, -1),
                    child: question ? newQuestion() : newQuestion()),
                const SizedBox(
                  height: 20,
                ),
               _gymController.notesList.isEmpty?Container(): DelayedDisplay(
                  delay: const Duration(milliseconds: 1000),
                  slidingBeginOffset: const Offset(-1, 0),
                  child: Text(
                    'Today’s mood score',
                    style: headingHomeStyle,
                  ),

                ),
                _gymController.notesList.isEmpty?Container(): const SizedBox(
                  height: 10,
                ),
                _gymController.notesList.isEmpty?Container(): Obx(
                    ()=> DelayedDisplay(
                    delay: const Duration(milliseconds: 1000),
                    slidingBeginOffset: const Offset(0, 0),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: const Color(0xffA9EFE1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 35.h,
                              width: Get.width,
                              child: GaugeMeterWidget(
                                percentage:  _gymController.gageMeterPercentage.value,
                                gageMeterSuggestionText: _gymController.gageMeterSuggestionText.value,
                                needleValue:_gymController.needleValue.value,
                                topPosition: 25.h,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Suggestion for you:',
                                style: TextStyle(
                                  color: Color(0xFF70B25D),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                _gymController.suggestions.value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ZoomTapAnimation(
                //   onTap: () {
                //     // Get.to(() => const MoodHistory());
                //   },
                //   child: Container(
                //     width: Get.width,
                //     height: 58,
                //     alignment: Alignment.center,
                //     decoration: ShapeDecoration(
                //       shape: RoundedRectangleBorder(
                //         side: const BorderSide(
                //             width: 1.50, color: Color(0xFFA0D88D)),
                //         borderRadius: BorderRadius.circular(35),
                //       ),
                //     ),
                //     child: const Text(
                //       'View mood history',
                //       style: TextStyle(
                //         color: Color(0xFF70B25D),
                //         fontSize: 18,
                //         fontFamily: 'Poppins',
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                DelayedDisplay(
                  delay: const Duration(milliseconds: 500),
                  slidingBeginOffset: const Offset(0, -1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Previous Notes', style: headingHomeStyle),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const Emotions());
                          // Dialogbox.showHappyDialog(context);
                        },
                        child: const Text(
                          'Add new',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  ()=>_gymController.notesList.isNotEmpty? Container(
                    height: 400,
                    child: PageView.builder(
                      itemCount: _gymController.notesList.length,
                      physics:const PageScrollPhysics() ,
                        itemBuilder: (context,index){
                          final reasons = _gymController.notesList[index].reason;
                          final formattedReasons = formatReasons(reasons);
                      return  Stack(
                        alignment: Alignment.topRight,
                        children: [
                          // Image.asset
                          Container(
                            height: 400,
                            width: 95.w,
                            child: Image.asset(
                              'assets/images/note.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          // Rotated TextField
                          Positioned(
                            left: 35,
                            top: 20,
                            right: 20,
                            child: Transform.rotate(
                              angle: -3.5 * 3.141592653589793 / 180, // Rotate 90 degrees counterclockwise
                              child: Container(
                                // color:Colors.green,
                                padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                                height: 340, // Initial height of the TextField
                                width: 300, // Set the desired width of the TextField
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          _gymController.getEmoji(_gymController.notesList[index].mood.toString()),
                                          height: 50,
                                        ),
                                        Text(
                                          _gymController.notesList[index].mood.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Text(
                                          "You were ",style: TextStyle(color: AppColors.primaryColor,fontSize: 16),
                                        ),
                                        Text(
                                          _gymController.notesList[index].mood.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 16,fontWeight: FontWeight.w500),
                                        ),

                                      ],
                                    ),
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
                                    // const SizedBox(height: 8,),
                                    Text(
                                      "Note:",style: TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      _gymController.notesList[index].note.toString(),
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
                  ):Column(
                    children: [
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        child: Text("You have not added any feeling or notes yet",textAlign: TextAlign.center,),
                      ),
                      SizedBox(height: 20,),
                      CustomButton.commonButton(onTap: (){
                        Get.to(() => const Emotions());

                      }, buttonText: "Add Now"),
                      SizedBox(height: 40,),
                    ],
                  ),
                )

                /* Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-0.05),
                  child: Container(
                    width: Get.width * 0.8,
                    height: 275.35,
                    decoration: const BoxDecoration(color: Color(0xFF333333)),
                  ),
                ), */
                //  DelayedDisplay(
                //   delay: Duration(milliseconds: 500),
                //   slidingBeginOffset: Offset(0, -1),
                //   child: AddNote(),
                // ),,
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget dailyQuestionChart() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Daily Question Chart',
  //         style: headingHomeStyle,
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       Container(
  //         width: Get.width,
  //         height: 40.h,
  //         decoration: ShapeDecoration(
  //           color: const Color(0xFF333333),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ),
  //         child: Padding(
  //           padding: PAD_ALL_20,
  //           child: Column(
  //             children: <Widget>[
  //               Row(
  //                 children: <Widget>[
  //                   Container(
  //                     width: 10,
  //                     height: 10,
  //                     decoration: const ShapeDecoration(
  //                       color: Color(0xFF218DCA),
  //                       shape: OvalBorder(),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 10,
  //                   ),
  //                   const Text(
  //                     'Majority',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 10,
  //                       fontFamily: 'Poppins',
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 20,
  //                   ),
  //                   Container(
  //                     width: 10,
  //                     height: 10,
  //                     decoration: const ShapeDecoration(
  //                       color: Color(0xFF595959),
  //                       shape: OvalBorder(),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 10.0,
  //                   ),
  //                   const Text(
  //                     'Minority',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 10,
  //                       fontFamily: 'Poppins',
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   Text.rich(
  //                     TextSpan(
  //                       children: [
  //                         const TextSpan(
  //                           text: 'Saturday,',
  //                           style: TextStyle(
  //                             color: Color(0xFF218DCA),
  //                             fontSize: 10,
  //                             fontFamily: 'Poppins',
  //                             fontWeight: FontWeight.w500,
  //                             height: 0.16,
  //                           ),
  //                         ),
  //                         TextSpan(
  //                           text: ' 16/09/2023',
  //                           style: TextStyle(
  //                             color: Colors.white.withOpacity(0.4),
  //                             fontSize: 10,
  //                             fontFamily: 'Poppins',
  //                             fontWeight: FontWeight.w500,
  //                             height: 0.16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const Spacer(),
  //               const Text(
  //                 'See Previously Answered Questions',
  //                 style: TextStyle(
  //                   color: Color(0xFF218DCA),
  //                   fontSize: 12,
  //                   fontFamily: 'Poppins',
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget newQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DelayedDisplay(
                delay: const Duration(milliseconds: 1000),
                slidingBeginOffset: const Offset(-1, 0),
                child: Text('New Question', style: headingHomeStyle)),
            TextButton(
              onPressed: () {
                PageTransition.pageNavigation(page: const AnsweredQuestion());
              },
              child: DelayedDisplay(
                delay: const Duration(milliseconds: 1000),
                slidingBeginOffset: const Offset(1, 0),
                child: Text(
                  'Previous Questions',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        Obx(
          () => _gymController.isLoading.value==true?const ShimmerHomeScreen(): Container(
              height: 300,
              child: PageView.builder(
                // physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: _gymController.questionsList.length,
                // Number of pages
                itemBuilder: (context, index) {
                  String originalDate = _gymController.questionsList[index].date;
                  final DateFormat originalFormat = DateFormat('dd-MM-yyyy');
                  final DateTime dateTime = originalFormat.parse(originalDate);
                  final DateFormat newFormat = DateFormat('dd/MM/yyyy');
                  String newDate = newFormat.format(dateTime);
                  return Padding(
                    padding: const EdgeInsets.only(right: 2,left: 1),
                    child: Motion.elevated(
                      filterQuality: FilterQuality.medium,
                      elevation: 50,
                      glare: true,
                      borderRadius: BorderRadius.circular(20),
                      // controller: MotionController(),
                      child: Container(
                        width: Get.width,
                        decoration: ShapeDecoration(
                          color: AppColors.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/profile.png'),
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _gymController.questionsList[index].title
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              ListView.builder(
                                padding: EdgeInsets.only(top: 10),
                                  itemCount: _gymController.questionsList[index].getOptions.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index1) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5,right: 5,bottom: 7),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomButton.borderButton(
                                            border: Border.all(
                                                color: _gymController
                                                        .questionsList[index]
                                                        .getOptions[index1]
                                                        .selectedIndex
                                                    ? Colors.black
                                                    : Colors.white,
                                                width: 1),
                                            onTap: () {
                                              if(_gymController.questionsList.length-1==index){
                                                question=true;
                                                setState(() {});
                                              }
                                              if (_gymController.questionsList[index].getOptions[index1].selectedIndex) {
                                                _gymController.questionsList[index].getOptions[index1].selectedIndex = false;
                                              } else {
                                                _gymController.questionsList[index].getOptions[index1].selectedIndex = true;
                                                print(_gymController.questionsList[index].getOptions[index1].id);
                                                print(_gymController.questionsList[index].getOptions[index1].questionId);
                                                  _gymController.saveAnswers(_gymController.questionsList[index].getOptions[index1].questionId.toString(),_gymController.questionsList[index].getOptions[index1].id.toString());
                                                // _gymController.questionsList[index].getOptions.where((e) => e.id != _gymController.questionsList[index].getOptions[index1].id).map((e) => e.selectedIndex = false);
                                                for(int i=0;i<_gymController.questionsList[index].getOptions.length;i++){
                                                  if(_gymController.questionsList[index].getOptions[i].id!=_gymController.questionsList[index].getOptions[index1].id){
                                                    _gymController.questionsList[index].getOptions[i].selectedIndex = false;
                                                  }
                                                }
                                              }
                                              setState(() {});
                                              int newIndex = (_currentIndex + 1) % 5;
                                              _changePage(newIndex);
                                            },
                                            buttonText: _gymController
                                                .questionsList[index]
                                                .getOptions[index1]
                                                .option),
                                      ),
                                    );
                                  }),

                              // const SizedBox(
                              //   height: 8,
                              // ),
                              // CustomButton.borderButton(
                              //     border: Border.all(color: _gymController.questionsList[index].getOptions[1].selectedIndex? Colors.black:Colors.white,width: 1),
                              //
                              //     onTap: () {
                              //       _gymController.questionsList[index].getOptions[1].selectedIndex=true;
                              //       setState(() {
                              //
                              //       });
                              //       int newIndex = (_currentIndex + 1) % 5; // Example: Move to next page
                              //       _changePage(newIndex);
                              //     }, buttonText: _gymController.questionsList[index].getOptions[1].option),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // CustomButton.borderButton(
                              //   border: Border.all(color: _gymController.questionsList[index].getOptions[2].selectedIndex? Colors.black:Colors.white,width: 1),
                              //     onTap: () {
                              //       _gymController.questionsList[index].getOptions[2].selectedIndex=true;
                              //       setState(() {
                              //
                              //       });
                              //       int newIndex = (_currentIndex + 1) % 5; // Example: Move to next page
                              //       _changePage(newIndex);
                              //     }, buttonText: _gymController.questionsList[index].getOptions[2].option),
                              // CustomButton.borderButton(
                              //     onTap: () {
                              //       setState(() {
                              //         question = true;
                              //       });
                              //     },
                              //     buttonText: 'Yes , by following fitness journey'),


                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  _gymController.questionsList[index].time +
                                      ",  " +
                                      newDate,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.40),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              // GestureDetector(
                              //   onTap: () {
                              //     PageTransition.pageNavigation(
                              //         page: const AnsweredQuestion());
                              //   },
                              //   child: const Text(
                              //     'See Previously Answered Questions',
                              //     style: TextStyle(
                              //       color: Color(0xFF218DCA),
                              //       fontSize: 12,
                              //       fontFamily: 'Poppins',
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ),
        // Motion.elevated(
        //   filterQuality: FilterQuality.medium,
        //   elevation: 50,
        //   glare: true,
        //   borderRadius: BorderRadius.circular(20),
        //   // controller: MotionController(),
        //   child: Container(
        //     width: Get.width,
        //     decoration: ShapeDecoration(
        //       color: AppColors.cardColor,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: <Widget>[
        //           Row(
        //             children: <Widget>[
        //               Container(
        //                 width: 46,
        //                 height: 46,
        //                 decoration: ShapeDecoration(
        //                   image: const DecorationImage(
        //                     image: AssetImage('assets/icons/profile.png'),
        //                     fit: BoxFit.fill,
        //                   ),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(64),
        //                   ),
        //                 ),
        //               ),
        //               const SizedBox(
        //                 width: 10,
        //               ),
        //               const Text(
        //                 'Eleanor Pena',
        //                 style: TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 14,
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //               const SizedBox(
        //                 width: 10,
        //               ),
        //               const Text(
        //                 'Admin',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 13,
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               )
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           const Text(
        //             'Can you build muscle and lose fat at the same time?',
        //             style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 15,
        //               fontFamily: 'Poppins',
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           CustomButton.borderButton(
        //               onTap: () {
        //                 setState(() {
        //                   question = true;
        //                 });
        //               },
        //               buttonText: 'Yes , by following fitness journey'),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           CustomButton.borderButton(
        //               onTap: () {}, buttonText: 'No, that is impossible'),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Align(
        //             alignment: Alignment.bottomRight,
        //             child: Text(
        //               '9:04 pm, 14/09/2023',
        //               style: TextStyle(
        //                 color: Colors.black.withOpacity(0.40),
        //                 fontSize: 10,
        //                 fontFamily: 'Poppins',
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           // GestureDetector(
        //           //   onTap: () {
        //           //     PageTransition.pageNavigation(
        //           //         page: const AnsweredQuestion());
        //           //   },
        //           //   child: const Text(
        //           //     'See Previously Answered Questions',
        //           //     style: TextStyle(
        //           //       color: Color(0xFF218DCA),
        //           //       fontSize: 12,
        //           //       fontFamily: 'Poppins',
        //           //       fontWeight: FontWeight.w600,
        //           //     ),
        //           //   ),
        //           // )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget barChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Question Chart',
          style: headingHomeStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFCB39C),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF70B25D),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Majority',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFE0AD3A),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Minority',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.16,
                      ),
                    ),
                    const Spacer(),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Saturday',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.16,
                            ),
                          ),
                          TextSpan(
                            text: ', 16/09/2023',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: Get.width, height: 200, child: BarChartSample1()),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AnsweredQuestion());
                  },
                  child: const Text(
                    'See Previously Answered Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _changePage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = pageIndex;
    });
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
