import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:motion/motion.dart';

import '../../components/custom_button.dart';
import '../../constants/custom_validators.dart';
import '../../helper/custom_dialogbox.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../auth/components/backround_video.dart';

class CreateFeed extends StatefulWidget {
  const CreateFeed({Key? key}) : super(key: key);

  @override
  State<CreateFeed> createState() => _CreateFeedState();
}

class _CreateFeedState extends State<CreateFeed> {
  List<String> topics = [
    'General',
    'Healthy Diet',
    'Action plan',
    'Motivational quotes',
    'Ask a question',
    'Space to vent'
  ];
  List<String> selectedTopics = [];
  TextEditingController messageController=TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  GymController _gymController=Get.find();
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(

      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: DelayedDisplay(
          slidingBeginOffset: const Offset(0, 1),
          delay: const Duration(milliseconds: 500),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PreferredSize(
                //   preferredSize: const Size.fromHeight(80.0),
                //   child: AppBar(
                //       elevation: 1,
                //       shadowColor: Get.isDarkMode ? Colors.white : Colors.black,
                //       bottom: PreferredSize(
                //         preferredSize: const Size.fromHeight(
                //             40.0), // Set your desired height for the bottom area
                //         child: Align(
                //           alignment: Alignment.bottomLeft,
                //           child: DelayedDisplay(
                //             slidingBeginOffset: const Offset(0, 0),
                //             delay: const Duration(milliseconds: 500),
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 10),
                //               child: Row(
                //                 children: [
                //                   IconButton(
                //                       onPressed: () {
                //                         Get.back();
                //                       },
                //                       icon: Icon(Icons.arrow_back, color: Get.isDarkMode ? Colors.white : Colors.black,)),
                //                   Container(
                //                     margin: const EdgeInsets.only(
                //                       left: 30.0,
                //                     ), // Add space around the bottom title
                //                     child:
                //                     Text('Create new feed', style: AppStyles.style20),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       backgroundColor:
                //       Get.isDarkMode ? AppColors.backgroundColor : Colors.white),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back, color: Get.isDarkMode ? Colors.white : Colors.white,)),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 30.0,
                            ), // Add space around the bottom title
                            child:
                            Text('Create new feed', style: AppStyles.style20),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(height:5,color: AppColors.fontColor,),
                      SizedBox(height: 10,),
                      Text(
                        'Your Message',
                        style: AppStyles.style20.copyWith(color: Get.isDarkMode ? Colors.white : Colors.white,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => CustomValidator.isEmpty(value),
                        controller: messageController,
                        maxLines: 11,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          fillColor:
                          Get.isDarkMode ? const Color(0xFF434242):const Color(0xFF434242),
                          filled: true,
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                          border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Get.isDarkMode ? Colors.transparent : Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Get.isDarkMode ? Colors.transparent : Colors.grey,
                              width: 0, // Set the width to 0 to make it disappear
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0, // Set the width to 0 to make it disappear
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Get.isDarkMode ? Colors.transparent : Colors.grey,
                              width: 0, // Set the width to 0 to make it disappear
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Get.isDarkMode ? Colors.transparent : Colors.grey,
                              width: 0, // Set the width to 0 to make it disappear
                            ),
                          ),
                          hintText: 'Write something',
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Select Topics',
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.07,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    height: 47, // Set your desired height
                    width: Get.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                          topics.length ~/ 2, // Divide topics list into two parts
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(topics[index])) {
                                selectedTopics.remove(topics[index]);
                              } else {
                                selectedTopics.add(topics[index]);
                              }
                              _gymController.updateSelectedTopics(selectedTopics);
                              print(selectedTopics);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: ShapeDecoration(
                                color:  Get.isDarkMode ? const Color(0xFF434242) : const Color(0xFF434242),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: selectedTopics.contains(topics[index])
                                        ? BorderSide(color: AppColors.secondaryColor, width: 2)
                                        : const BorderSide(width: 2, color: Colors.transparent)),
                              ),
                              child: Center(
                                child: Text(
                                  topics[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Get.isDarkMode? Colors.white.withOpacity(0.8) :  Colors.white.withOpacity(0.8),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: -0.17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 47, // Set your desired height
                    width: Get.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: topics.length ~/ 2 +
                          (topics.length %
                              2), // Include the remaining item for odd lengths
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics
                                  .contains(topics[index + (topics.length ~/ 2)])) {
                                selectedTopics
                                    .remove(topics[index + (topics.length ~/ 2)]);
                              } else {
                                selectedTopics
                                    .add(topics[index + (topics.length ~/ 2)]);
                              }
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: ShapeDecoration(
                                color: Get.isDarkMode ?const Color(0xFF434242): const Color(0xFF434242),
                                shape: RoundedRectangleBorder(
                                  side: selectedTopics.contains(
                                          topics[index + (topics.length ~/ 2)])
                                      ? BorderSide(color: AppColors.secondaryColor, width: 2)
                                      : const BorderSide(width: 2, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  topics[index + (topics.length ~/ 2)],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Get.isDarkMode? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.8),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: -0.17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton.commonButton(
                    buttonText: 'Post',
                    onTap: () {
                      if(_key.currentState!.validate()){
                        if(selectedTopics.isEmpty){
                          CustomDialog.showErrorDialog(description: "Please select at least one topic");
                        }else{
                          _gymController.postsList.clear();
                          _gymController.postsCurrentPage.value=0;
                          _gymController.postsLastPage.value=0;
                          setState(() {

                          });
                          _gymController.createPost(messageController.text.toString());

                          // PageTransition.pageNavigation(page: AddReason());
                        }
                      }


                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
