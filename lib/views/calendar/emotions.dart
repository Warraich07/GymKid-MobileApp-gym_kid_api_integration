import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/components/page_navigation.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/components/custom_text_field.dart';
import 'package:gym_kid/views/calendar/add_reason.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../components/custom_appbar.dart';
import '../../helper/custom_dialogbox.dart';
import '../../res/colors.dart';

class Emotions extends StatefulWidget {
  const Emotions({super.key});

  @override
  State<Emotions> createState() => _EmotionsState();
}

class _EmotionsState extends State<Emotions> {
  List<String> emotions = [
    'Distracted',
    'Motivated',
    'Beast Mode',
    'Focused',
    'Tired',
    'Injured'
  ];
  List<String> filteredEmotions = [];
  int select = -1;
  final TextEditingController _searchController = TextEditingController();
  GymController _gymController=Get.find();
  @override
  void initState() {
    _gymController.updateEmotion('');
    super.initState();
    filteredEmotions = List.from(emotions); // Initialize filteredEmotions with the full list
    _searchController.addListener(() {
      // Update filteredEmotions when the search text changes
      filterEmotions(_searchController.text);
    });
  }

  void filterEmotions(String query) {
    final filteredList = emotions
        .where((emotion) => emotion.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredEmotions = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(

        child: SingleChildScrollView(
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
                  'Today at practice I felt',
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
                  'Choose emotion according to what you felt at practice',
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? Colors.white.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // CustomTextField.authInputFields(
                //   onChanged: (value){
                //     filterEmotions(value);
                //   },
                //     hint: 'Search Emotion',
                //
                //     textEditingController: _searchController,
                //
                //     prefixIcon: Image.asset(
                //       'assets/icons/search.png',
                //       color: Get.isDarkMode
                //           ? Colors.white.withOpacity(0.6)
                //           : Colors.white.withOpacity(0.6),
                //     )),
                // SizedBox(
                //   height: 5.h,
                // ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: filteredEmotions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 40),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        select = index;
                        setState(() {});
                        // print(emotions[index]);
                        _gymController.updateEmotion(emotions[index]);
                      },
                      child: Column(
                        children: [
                          Container(

                            width: 82,
                            height: 82,
                            decoration: ShapeDecoration(
                              color: Get.isDarkMode
                                  ? const Color(0xFF333333)
                                  :  const Color(0xFF333333),
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: select == index
                                          ? AppColors.loaderColor
                                          : Colors.transparent)),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/emoji (${index + 1}).gif',
                                height: 60,
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            emotions[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(

                              color: Get.isDarkMode ? Colors.white : Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Expanded(
                //   child: SizedBox(),
                // ),
                SizedBox(
                  height: 20.h,
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(-10, 0),
                  delay: const Duration(milliseconds:100),
                  child: CustomButton.commonButton(
                      onTap: () {
                        print(_gymController.userEmotion.value);
                        if(_gymController.userEmotion.isEmpty){
                          CustomDialog.showErrorDialog(description: "Please select emotion");
                        }else{
                          // _gymController.saveSuggestions(_gymController.userEmotion.value);
                          _gymController.saveNoteHeading(_gymController.userEmotion.value);
                          PageTransition.pageNavigation(page: AddReason());
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
        ),
      ),
    );
  }
}
