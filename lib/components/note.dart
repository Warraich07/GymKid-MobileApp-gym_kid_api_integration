import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/gym_controller.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../helper/custom_dialogbox.dart';
import '../res/dimens.dart';
import '../res/styles.dart';
import '../views/homescreen/components/page_view_button.dart';
import 'custom_appbar.dart';

class AddNote extends StatefulWidget {
   AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
TextEditingController noteController=TextEditingController();
GymController _gymController=Get.find();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object");
    print(_gymController.userEmotion.value);

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
              children: [
                // SizedBox(height: 20,),
                // Row(
                //   children: [
                //     IconButton(color: Colors.white, onPressed: () {
                //       Get.back();
                //     }, icon: Icon(Icons.arrow_back),),
                //   ],
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
                  _gymController.noteHeading.value,
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
                  'Add your notes on any thought that reflects your feelings',
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
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    // Image.asset
                    Container(
                      height: 320, // Set the height for the image
                      width: 95.w,  // Set the width for the image
                      child: Image.asset(
                        'assets/images/note_dark_mode.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Rotated TextField
                    Positioned(
                      left: 35,
                      top: 22,
                      right: 20,
                      child: SizedBox(
                        // color: Colors.green,
                        height: 275,
                        width: 95.w,
                        child: TextField(
                          maxLength: 200,
                          maxLines: 10,
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.only(
                              bottom: 40,
                              right: 15,
                              left: 15
                            ),
                            hintText: 'Enter your note...',
                          ),
                          style: TextStyle(fontSize: 16,color: Colors.black),
                          controller: noteController,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:100
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(-10, 0),
                  delay: const Duration(milliseconds:100),
                  child: ZoomTapAnimation(
                                onTap: (){
                  if(noteController.text.isEmpty){
                    CustomDialog.showErrorDialog(description: "Please add note");
                  }else{
                    _gymController.addNote(noteController.text.toString(),context);
                  }
                                },
                                child: Center(
                  child: Container(
                    width: Get.width * 0.8,
                    height: 61,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFA0D88D), Color(0xFF70B25D)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: subHeadingStyle.copyWith(color: Colors.white),
                    ),
                  ),
                                ),
                              ),
                )
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotePlane extends StatelessWidget {
  const NotePlane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Image.asset(
          'assets/images/note_plane.png',
          height: 350,
          width: 350,
        ),
        Positioned(
          top: 10,
          left: 70,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/emoji (4).png',
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Happy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'You felt ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7400000095367432),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(
                        text: 'Peaceful and Excited',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Because of',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7400000095367432),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(
                        text: ' Hobbies',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Note:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const SizedBox(
                  width: 227.66,
                  child: Text(
                    'Today at practice i realized that Physical activity stimulates various brain chemicals that may leave you feeling happier, more relaxed and less anxious.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.95,
                    ),
                  ),
                ),
                // CustomButton.commonButton(
                //     onTap: () {
                //       if(selectedList.isEmpty){
                //         CustomDialog.showErrorDialog(description: "Please add reason");
                //       }else if(selectedList.isNotEmpty){
                //         _gymController.updateReason(selectedList);
                //         Get.to(() => const Note());
                //       }
                //     },
                //     buttonText: 'Next'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
