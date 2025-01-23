import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/page_navigation.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/note.dart';
import '../../controllers/gym_controller.dart';
import '../../models/feeling_logs_model.dart';
import '../calendar/calendar.dart';

class MyDiary extends StatefulWidget {
  const MyDiary({super.key});

  @override
  State<MyDiary> createState() => _MyDiaryState();
}

class _MyDiaryState extends State<MyDiary> {
  GymController _gymController = Get.find();
 String dateToday='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    dateToday = dateFormat.format(DateTime.now());

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
          Get.isDarkMode ? AppColors.backgroundColor : AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: "My diary",
          onTap: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          InkWell(
            onTap: (){
              Get.to(() => CalenderScreen());
              },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dateToday,
                    style: TextStyle(
                      color: Get.isDarkMode ? Color(0xCCFFF8F8) : Color(0xCCFFF8F8),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                 Image.asset(
                        'assets/icons/calendar.png',
                        height: 20,
                        color: AppColors.secondaryColor,
                      ),

                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'My today’s notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0.05,
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/Lines.png',
                height: 73.h,
                color: Get.isDarkMode ? Colors.white : Colors.black,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 28,
                  left: 20,
                  child: Column(
                    children: <Widget>[
                     
                      Container(
                        width: 380,
                        height: 400,
                        child: _gymController.todaysNotes.isEmpty?const Center(
                          child: Padding(
                            padding: EdgeInsets.only(right: 50),
                            child: Text("No Notes",style: TextStyle(color: Colors.white),),
                          ),
                        ) :PageView.builder(

                            itemCount: _gymController.todaysNotes.length,
                            physics:PageScrollPhysics() ,
                            itemBuilder: (context,index){
                              final reasons = _gymController.todaysNotes[index].reason;
                              final formattedReasons = formatReasons(reasons);
                              return  Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  // Image.asset
                                  Container(

                                    margin: EdgeInsets.only(right: 50),
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
                                    top: 20,
                                    right: 70,

                                    child: Transform.rotate(
                                      angle: -3.5 * 3.141592653589793 / 180, // Rotate 90 degrees counterclockwise
                                      child: Container(
                                        // color:Colors.green,
                                        // color:Colors.green,
                                        padding: const EdgeInsets.only(right: 0,top: 5),
                                        height: 322, // Initial height of the TextField
                                        width: 300, // Set the desired width of the TextField
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  _gymController.getEmoji(_gymController.todaysNotes[index].mood.toString()),
                                                  height: 50,
                                                ),
                                                Text(
                                                  _gymController.todaysNotes[index].mood.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: [
                                                Text(
                                                  "You were ",style: TextStyle(color: AppColors.primaryColor,fontSize: 16),
                                                ),
                                                Text(
                                                  _gymController.todaysNotes[index].mood.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 16,fontWeight: FontWeight.w500),
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
                      )
                    ],
                  )),

              // Positioned(
              //   top: 270,
              //   child: Container(
              //     margin: EdgeInsets.only(left: 10, right: 20),
              //     width: Get.width - 40,
              //     child: Stack(
              //       alignment: Alignment.topRight,
              //       children: [
              //         Transform(
              //           transform: Matrix4.identity()
              //             ..translate(0.0, 0.0)
              //             ..rotateZ(-0.05),
              //           child: Container(
              //             margin: const EdgeInsets.only(bottom: 27),
              //             decoration: BoxDecoration(
              //                 color: AppColors.forgroundColor,
              //                 borderRadius: BorderRadius.circular(20)),
              //             child: Padding(
              //               padding: const EdgeInsets.only(
              //                   top: 12, left: 12, right: 12),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Image.asset(
              //                         feelingsList[0].emoji,
              //                         height: 50,
              //                       ),
              //                       const SizedBox(
              //                         width: 10,
              //                       ),
              //                       Text(feelingsList[0].heading,
              //                           style: const TextStyle(
              //                               color: Colors.white,
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 27)),
              //                       /*  Image.asset(
              //                                         'assets/icons/emoji (1).png',
              //                                         height: 15,
              //                                         width: 15,
              //                                       ) */
              //                     ],
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                     feelingsList[0].description,
              //                     style: const TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 14,
              //                         height: 1.2),
              //                   ),
              //                   const SizedBox(
              //                     height: 8,
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.end,
              //                     children: [
              //                       Text(
              //                         DateFormat('EEEE, dd MMMM h:mma')
              //                             .format(feelingsList[0].fulldate),
              //                         style: TextStyle(
              //                           fontSize: 12,
              //                           color: Colors.grey.withOpacity(0.5),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(10.0),
              //           child: Image.asset(
              //             'assets/icons/pin.png',
              //             height: 30,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          )
        ],
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
