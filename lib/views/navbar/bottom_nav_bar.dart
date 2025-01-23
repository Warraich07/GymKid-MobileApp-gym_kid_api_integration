
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/auth_controller.dart';

import '../../controllers/general_controller.dart';
import '../../res/colors.dart';
import '../community/commnuity.dart';
import '../diary/Diary.dart';
import '../homescreen/home_screen.dart';
import '../profile/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({Key? key}) : super(key: key);

  final GeneralController _generalController = Get.find<GeneralController>();
  final AuthController _authController = Get.find();

  final List<Widget> _pages = [
    const HomeScreen(),
    const Community(),
    const Diary(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _pages[_generalController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _generalController.onBottomBarTapped(value);
          },
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              const TextStyle(color: Colors.black, fontSize: 10),
          unselectedLabelStyle:
              const TextStyle(color: Colors.grey, fontSize: 10),
          backgroundColor: Get.isDarkMode ? AppColors.backgroundColor :AppColors.backgroundColor,
          selectedItemColor: Color(0xff033d94),
          unselectedItemColor: Colors.black.withOpacity(.60),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Image.asset(
                          'assets/icons/home.png',
                          color: _generalController.currentIndex == 0
                              ? AppColors.secondaryColor
                              : AppColors.unSelectedColor,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 10,
                            color: _generalController.currentIndex == 0
                                ? AppColors.secondaryColor
                                : AppColors.unSelectedColor),
                      )
                    ],
                  ),
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 2,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Image.asset(
                          'assets/icons/community.png',
                          color: _generalController.currentIndex == 1
                              ? AppColors.secondaryColor
                              : AppColors.unSelectedColor,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Community",
                        style: TextStyle(
                            fontSize: 10,
                            color: _generalController.currentIndex == 1
                                ? AppColors.secondaryColor
                                : AppColors.unSelectedColor),
                      )
                    ],
                  ),
                ),
                label: "Community"),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 4,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                        child: Image.asset(
                          'assets/icons/analytic_off.png',
                          color: _generalController.currentIndex == 2
                              ? AppColors.secondaryColor
                              : AppColors.unSelectedColor,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Diary",
                        style: TextStyle(
                            fontSize: 10,
                            color: _generalController.currentIndex == 2
                                ? AppColors.secondaryColor
                                : AppColors.unSelectedColor),
                      )
                    ],
                  ),
                ),
                label: "Diary"),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 4,
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(

                              shape: BoxShape.circle,
                              border:  _generalController.currentIndex == 3
                                  ? Border.all(color: AppColors.secondaryColor,width: 2)
                                  : null),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
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
                                  Image.asset(
                                    "assets/img.png",scale: 5.3,
                                    // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
                                                    
                                  ),
                              fit: BoxFit.cover,
                              // scale:20 ,
                              // width: double.infinity,
                              // height: 250,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 10,
                            color: _generalController.currentIndex == 3
                                ? AppColors.secondaryColor
                                : AppColors.unSelectedColor),
                      )
                    ],
                  ),
                ),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
