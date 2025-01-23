import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/common_widget.dart';
import 'package:gym_kid/controllers/auth_controller.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_textfield.dart';
import '../../res/colors.dart';
import '../auth/components/custom_validator.dart';
import '../auth/components/profile_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  AuthController _authController=Get.find();
  bool loader = false;
  late PickedFile pickedFile;
  String? imageUrl;
  File? imageFile;
  final picker = ImagePicker();
  bool processingStatus = false;
  // FirebaseStorage storage = FirebaseStorage.instance;
  XFile? pickedImage;
  // final GlobalKey<FormState> profileField = GlobalKey();

  // getData() {
  //   setState(() {
  //     nameController.text = userData.displayName;
  //     ageController.text = userData.age;
  //     phoneController.text = userData.phoneNumber;
  //     imageUrl = userData.imageUrl;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=_authController.userData.value!.name;
    emailController.text=_authController.userData.value!.email;
    ageController.text=_authController.userData.value!.age;
    genderController.text=_authController.userData.value!.gender;
    imageUrl=_authController.userData.value!.image;
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BackgroundImage(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   automaticallyImplyLeading: false,
        //   title: CustomAppBar(
        //     pageTitle: "Edit Profile",
        //     onTap: () {
        //       Get.back();
        //     },
        //   ),
        // ),
        // resizeToAvoidBottomInset: false,
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.0, left: 18.0, right: 18.0, bottom: 10.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 10,),
                CustomAppBar(
                  pageTitle: "Edit Profile",
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 20,),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 400),
                          slidingBeginOffset: const Offset(0, 0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ProfilePicker(forMyProfile: true,imagePath: imageUrl,isFromSignUp: false,),

                              // CircleAvatar(
                              //   radius: 62,
                              //   backgroundColor: AppColors.buttonColor,
                              //   child: const CircleAvatar(
                              //       radius: 60,
                              //       backgroundImage: AssetImage(
                              //         "assets/icons/profile.png",
                              //       ) /* imageFile != null
                              //         ? FileImage(imageFile!) as ImageProvider
                              //         : (userData.imageUrl != "" &&
                              //                 userData.imageUrl != null)
                              //             ? NetworkImage(userData.imageUrl)
                              //                 as ImageProvider
                              //             : AssetImage(
                              //                 "assest/images/profile.png",
                              //               ), */
                              //       ),
                              // ),
                              // Positioned(
                              //   right: 1.w,
                              //   bottom: 1.h,
                              //   child: ZoomTapAnimation(
                              //     onTap: () {
                              //       _upload("gallery");
                              //     },
                              //     onLongTap: () {},
                              //     enableLongTapRepeatEvent: false,
                              //     longTapRepeatDuration:
                              //         const Duration(milliseconds: 100),
                              //     begin: 1.0,
                              //     end: 0.93,
                              //     beginDuration: const Duration(milliseconds: 20),
                              //     endDuration: const Duration(milliseconds: 120),
                              //     beginCurve: Curves.decelerate,
                              //     endCurve: Curves.fastOutSlowIn,
                              //     child: CircleAvatar(
                              //         radius: 16,
                              //         backgroundColor: AppColors.buttonColor,
                              //         child: Icon(
                              //           Icons.camera_alt,
                              //           color: Colors.white,
                              //           size: 16,
                              //         )),
                              //   ),
                              // ),
                            ],
                          ),
                          // Stack(
                          //   children: [
                          //     SizedBox(
                          //       height: 15.h,
                          //       width: double.infinity,
                          //       child: Container(
                          //         child: imageFile != null
                          //             ? Image.file(imageFile!)
                          //             : (userData.imageUrl != "" &&
                          //                     userData.imageUrl != null)
                          //                 ? Image.network(userData.imageUrl)
                          //                 : Image.asset(
                          //                     "assest/images/profile.png",
                          //                   ),
                          //
                          //         //-------
                          //         // Image.asset(
                          //         //   "assest/images/profile.png",
                          //         // ),
                          //       ),
                          //     ),
                          //     Positioned(
                          //       right: 26.w,
                          //       bottom: 1.h,
                          //       child: ZoomTapAnimation(
                          //         onTap: () {
                          //           _upload("gallery");
                          //         },
                          //         onLongTap: () {},
                          //         enableLongTapRepeatEvent: false,
                          //         longTapRepeatDuration:
                          //             const Duration(milliseconds: 100),
                          //         begin: 1.0,
                          //         end: 0.93,
                          //         beginDuration:
                          //             const Duration(milliseconds: 20),
                          //         endDuration:
                          //             const Duration(milliseconds: 120),
                          //         beginCurve: Curves.decelerate,
                          //         endCurve: Curves.fastOutSlowIn,
                          //         child: const CircleAvatar(
                          //             radius: 16,
                          //             backgroundColor: AppColors.primaryColor,
                          //             child: Icon(
                          //               Icons.camera_alt,
                          //               color: Colors.white,
                          //               size: 16,
                          //             )),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 500),
                          slidingBeginOffset: const Offset(0, -1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name:",
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: nameController,
                                validator: (value) =>
                                    CustomValidator.isEmptyUserName(value),
                                hintText: 'Full Name',
                                isHint: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 500),
                          slidingBeginOffset: const Offset(0, -1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email Address:",
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                               CustomTextField(
                                 controller:emailController,
                                 validator: (value) =>
                                     CustomValidator.email(value),
                                hintText: 'Email',
                                isReadOnly: false,
                                /*  suffixIcon: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 18.0, end: 30.0),
                                  child: Image.asset(
                                    "assets/icons/email.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ), */
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 500),
                          slidingBeginOffset: const Offset(0, -1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Age:",
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller:ageController,
                                validator: (value) =>
                                    CustomValidator.age(value),
                                hintText: "Age",
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 500),
                          slidingBeginOffset: const Offset(0, -1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender:",

                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: genderController,
                                validator: (value) =>
                                    CustomValidator.gender(value),
                                hintText: "Gender",
                                // keyboardType: TextInputType.,
                              ),
                              // GenderDropdown(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 1000),
                          slidingBeginOffset: const Offset(0, 0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomButton.commonButton(
                              buttonText: "Save Changes",
                              onTap: () async {
                                if (_key.currentState!.validate()) {
                                  _authController.editProfile(nameController.text.toString(), emailController.text.toString(), ageController.text.toString(), genderController.text.toString());
                                  // Get.defaultDialog(
                                  //     barrierDismissible: false,
                                  //     title: "Mood Meter",
                                  //     middleText: "",
                                  //     content: Column(
                                  //       children: [
                                  //         Center(
                                  //             child: CircularProgressIndicator(
                                  //           color: AppColors.primaryColor,
                                  //         ))
                                  //       ],
                                  //     ));
                                  //
                                  // setState(() {});
                                  // Get.back();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _upload(String inputSource) async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "Mood Meter",
        middleText: "",
        content: Column(
          children: [
            Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
          ],
        ));
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      setState(() {
        processingStatus = true;
      });
      final String fileName = path.basename(pickedImage!.path);
      try {
        // Uploading the selected image with some custom meta data
        {
          imageFile = File(pickedImage!.path);
          // await storage.ref(fileName).putFile(imageFile!).then((p0) async {
          //   imageUrl = await p0.ref.getDownloadURL();
          //   setState(() {});
          //   if (p0.state == TaskState.success) {
          //     setState(() {
          //       processingStatus = false;
          //     });
          //   }
          // });
        }
        // Refresh the UI
        Get.back();
        setState(() {});
      } on FirebaseException catch (error) {
        Get.back();
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      Get.back();
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
