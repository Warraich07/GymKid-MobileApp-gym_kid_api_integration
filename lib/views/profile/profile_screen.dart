import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../components/page_navigation.dart';
import '../../controllers/auth_controller.dart';
import '../../helper/shared_preference.dart';
import '../../res/colors.dart';
import '../calendar/calendar.dart';
import 'change_password.dart';
import 'edit_profile.dart';
import 'sub_plans.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false /* ThemeService().isDarkMode */;
  bool loader = false;
  late PickedFile pickedFile;
  String? imageUrl;
  File? imageFile;
  final picker = ImagePicker();
  bool processingStatus = false;
  XFile? pickedImage;
  final AuthPreference _authPreference = AuthPreference.instance;
  AuthController _authController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_authController.userData.value!.image.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Get.isDarkMode
          ? AppColors.backgroundColor
          : AppColors.lightBackgroundColor,
      body: BackgroundImage(
        child: Padding(
          padding:
              EdgeInsets.only(top: 5.h, left: 20.0, right: 20.0, bottom: 15.0),
          child: DelayedDisplay(
            slidingBeginOffset: const Offset(0, 0),
            delay: const Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: CachedNetworkImage(
                      // memCacheWidth: 150,
                      // memCacheHeight: 150,
                      // maxHeightDiskCache: 150,
                      // maxWidthDiskCache: 150,
                      imageUrl:_authController.userData.value!.image.toString(),
                      placeholder: (context, url) =>
                          Center(
                              child: CircularProgressIndicator()),
                      errorWidget: (context, url,
                          error) =>
                          Container(
                            // height: 120,
                            // width: 120,
                            child: Image.asset(
                              "assets/img.png",scale: 2.5,
                              // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,

                            ),
                          ),
                      fit: BoxFit.cover,
                      // scale:20 ,
                      // width: double.infinity,
                      // height: 250,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  ()=> Text(
                    _authController.userData.value!.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                // GestureDetector(
                //   onTap: () {
                //     PageTransition.pageNavigation(page: const ChoosePlan());
                //   },
                //   child: Container(
                //     width: Get.width,
                //     // height: 100,
                //     decoration: BoxDecoration(
                //       color: Get.isDarkMode
                //           ? AppColors.darkContainerColor
                //           : AppColors.lightContainerColor,
                //       borderRadius: BorderRadius.circular(
                //           15.0), // Adjust the radius as needed
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Container(
                //                 width: 37.12,
                //                 height: 18,
                //                 decoration: ShapeDecoration(
                //                   color: AppColors.yellowColor,
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(4.66),
                //                   ),
                //                 ),
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   'PRO',
                //                   style: TextStyle(
                //                     color: Get.isDarkMode
                //                         ? Colors.white
                //                         : Colors.black,
                //                     fontSize: 11,
                //                     fontFamily: 'Poppins',
                //                     fontWeight: FontWeight.w700,
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 5,
                //               ),
                //               Text(
                //                 "Upgrade to Premium",
                //                 style: TextStyle(
                //                   color:
                //                       Get.isDarkMode ? Colors.white : Colors.black,
                //                   fontSize: 17,
                //                   fontFamily: 'Poppins',
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 5,
                //               ),
                //               Text(
                //                 "This subscription is auto-renewable",
                //                 style: TextStyle(
                //                   color:
                //                       Get.isDarkMode ? Colors.white : Colors.black,
                //                   fontSize: 13,
                //                   fontFamily: 'Poppins',
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 10.0),
                //           child: Icon(
                //             Icons.arrow_forward_ios,
                //             color: Get.isDarkMode ? Colors.white : Colors.black,
                //             size: 20.0,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    PageTransition.pageNavigation(page: const EditProfile());
                  },
                  child: Container(
                    width: 100.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkContainerColor
                          : AppColors.darkContainerColor,
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Get.isDarkMode ? Colors.white : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            size: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    PageTransition.pageNavigation(page: const ChangePassword());
                  },
                  child: Container(
                    width: 100.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkContainerColor
                          : AppColors.darkContainerColor,
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Get.isDarkMode ? Colors.white : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            size: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    PageTransition.pageNavigation(page: const CalenderScreen());
                  },
                  child: Container(
                    width: 100.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkContainerColor
                          : AppColors.darkContainerColor,
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Feeling Logs",
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Get.isDarkMode ? Colors.white : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            size: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                /*  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 100.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                          12.0), // Adjust the radius as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                /*  ThemeService().isDarkMode */ true
                                    ? "Light Mode"
                                    : "Dark Mode",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Center(
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    // ThemeService().switchTheme();
                                    // mode.value = ThemeService().isDarkMode;
                                    // setState(() {});
                                    isSwitched = value;
                                  });
                                },
                                activeTrackColor: Colors.black,
                                activeColor: Colors.white,
                              ),
                            )),
                        // Icon(
                        //   ThemeService().isDarkMode
                        //       ? Icons.brightness_4
                        //       : Icons.brightness_2,
                        //   size: 20,
                        // ),
                      ],
                    ),
                  ),
                ), */
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheetForLogout(context);
                  },
                  child: Container(
                    width: 100.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkContainerColor
                          : AppColors.darkContainerColor,
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Out",
                                style: TextStyle(
                                  color: Color(0xFF218DCA),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            size: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: Container(
                    width: 100.w,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkContainerColor
                          : AppColors.darkContainerColor,
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius as needed
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Delete Account",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            size: 20.0,
                          ),
                        )
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
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900], // Dark theme background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Delete button color
                    ),
                    onPressed: () {
                      _authController.deleteAccount();
                    },
                    child: Text('Delete',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  void _showBottomSheetForLogout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900], // Dark theme background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF218DCA), // Delete button color
                    ),
                    onPressed: () {
                      _authPreference.setUserLoggedIn(false);

                      // setUserLoggedIn(false);
                      // FirebaseAuth.instance.signOut();
                      PageTransition.pageProperNavigation(page: const Login());
                    },
                    child: Text('Yes',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
