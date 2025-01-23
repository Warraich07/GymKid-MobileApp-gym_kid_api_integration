import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/res/styles.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:intl/intl.dart';
import 'package:motion/motion.dart';
import 'package:sizer/sizer.dart';

import 'diary_pages.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  String dateToday='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateFormat dateFormat = DateFormat('EEEE, d MMM, yyyy');
    dateToday = dateFormat.format(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child:  SingleChildScrollView(
          child: Padding(
            padding: PAD_SYM_H20,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DelayedDisplay(
                      slidingBeginOffset: Offset(-1,0),
                      delay: Duration(milliseconds: 500),
                      child: Text(
                        'My Diary',
                        style: headingHomeStyle,
                      ),
                    ),
                    DelayedDisplay(
                      slidingBeginOffset: Offset(1,0),
                      delay: Duration(milliseconds: 500),
                      child: Text(
                        dateToday,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.30,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DelayedDisplay(
                  delay: const Duration(milliseconds: 500),
                  slidingBeginOffset: const Offset(1, 0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(BookPageFlip(),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 600));

                    },
                    child: Motion.elevated(
                      filterQuality: FilterQuality.medium,
                      elevation: 50,
                      shadow: false,
                      glare: false,
                      borderRadius: BorderRadius.circular(20),
                      // controller: MotionController(),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/diary.png",
                            height: 70.h,
                          ),
                          // Positioned(
                          //   top: 10.h,
                          //   left: 15.w,
                          //   child: Text(
                          //     'My\ngym_kid\nDiary',
                          //     style: TextStyle(
                          //         color: Colors.black,
                          //         fontSize: 55,
                          //         fontFamily: 'Poppins',
                          //         fontWeight: FontWeight.w900,
                          //         height: 0.9,
                          //         letterSpacing: -2.3),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
}
