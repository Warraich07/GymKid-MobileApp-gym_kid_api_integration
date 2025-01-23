import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/calendar/select_date.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_textfield.dart';
import '../../components/note.dart';
import '../../helper/custom_dialogbox.dart';
import '../../res/colors.dart';

class AddReason extends StatefulWidget {
  const AddReason({super.key});

  @override
  State<AddReason> createState() => _EmotionsState();
}

class _EmotionsState extends State<AddReason> {
  List<String> addReason = [
    'Workout',
    'Hobbies',
    'Family',
    'Weather',
    // 'Wife',
    // 'Food',
    // 'Love',
    // 'Husband',
    // 'Breakup',
    // 'Party',
    // 'Social',
    // 'Self-Esteem',
    // 'Sleep',
  ];
  List<String> selectedList = [];
  int select = -1;
  TextEditingController reasonController=TextEditingController();
  GymController _gymController=Get.find();
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(

      child: Padding(
        padding: PAD_SYM_H20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AppBar(
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            //   automaticallyImplyLeading: false,
            //   title: CustomAppBar(
            //     pageTitle: "",
            //     onTap: () {
            //       Get.back();
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ZoomTapAnimation(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    height: 25,
                    width: 25,
                    child: Icon(
                      Icons.arrow_back,
                      color: Get.isDarkMode ? Colors.white : Colors.white,
                    )
                ),
              ),
            ),
            Text(
              'What’s the reason making you feel this way?',
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Select the reason that reflect your emotions',
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(0.7)
                    :  Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 72.w,
                  height: 60,
                  child: CustomTextField(
                    hintText: 'Add Reason',
                    controller: reasonController,
                  ),
                ),
                GestureDetector(
                  onTap: (){

                    if(reasonController.text.isEmpty){
                      CustomDialog.showErrorDialog(description: "Please add reason");
                    }else{
                      addReason.add(reasonController.text.toString());
                      setState(() {
                      });
                      reasonController.clear();
                      // print(selectedList);
                      // _gymController.updateReason(selectedList);
                      // Get.to(() => const Note());
                      // // CustomDialog.showProfileCompleteDialog(buttonText: "Next",description: "Reason Added",onTap: (){
                      // //
                      // // });
                    }

                    // selectedList.add(reasonController.text.toString());
                    // print(selectedList);
                  },
                  child: Container(
                    width: 57,
                    height: 57,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFFFD985), Color(0xFFE0AD3A)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Wrap(
              alignment: WrapAlignment.center,

              spacing: 9.0, // Adjust the spacing between categories
              runSpacing: 8.0, // Adjust the spacing between rows of categories
              children: addReason.map((category) {
                final textPainter = TextPainter(
                  text: TextSpan(
                    text: category,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                );
                textPainter.layout();
                final textWidth = textPainter.width;
                return GestureDetector(
                  onTap: () {
                    if (!selectedList.contains(category)) {
                      selectedList.add(category);
                      print(selectedList);

                    } else {
                      selectedList.remove(category);
                      print(selectedList);
                    }
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      height: 46,
                      width: textWidth + 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: ShapeDecoration(
                        color: Get.isDarkMode
                            ? Color(0xFF292929)
                            : Color(0xFF292929),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              color: selectedList.contains(category)
                                  ? AppColors.secondaryColor
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: SizedBox(),
            ),
            DelayedDisplay(
              slidingBeginOffset: const Offset(-10, 0),
              delay: const Duration(milliseconds:100),
              child: CustomButton.commonButton(
                  onTap: () {
                    if(selectedList.isEmpty){
                      CustomDialog.showErrorDialog(description: "Please add reason");
                    }else if(selectedList.isNotEmpty){
                      _gymController.updateReason(selectedList);
                      Get.to(() =>  AddNote());
                    }
                  },
                  buttonText: 'Next'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
