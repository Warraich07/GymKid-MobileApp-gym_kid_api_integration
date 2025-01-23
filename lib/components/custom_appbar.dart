import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomAppBar extends StatefulWidget {
  final String pageTitle;
  final Function onTap;
  final Widget? leadingButton;

  const CustomAppBar(
      {Key? key,
      required this.pageTitle,
      required this.onTap,
      this.leadingButton})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ZoomTapAnimation(
            onTap: () {
              widget.onTap();
            },
            onLongTap: () {},
            enableLongTapRepeatEvent: false,
            longTapRepeatDuration: const Duration(milliseconds: 100),
            begin: 1.0,
            end: 0.93,
            beginDuration: const Duration(milliseconds: 20),
            endDuration: const Duration(milliseconds: 120),
            beginCurve: Curves.decelerate,
            endCurve: Curves.fastOutSlowIn,
            child: Container(
                height: 25,
                width: 25,
                // decoration: BoxDecoration(
                //     color: AppColors.primaryColor,
                //     borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.arrow_back,
                  color: Get.isDarkMode ? Colors.white : Colors.white,
                ) /*  Image.asset(
                  ThemeService().isDarkMode
                      ? "assest/images/backSquareL.png"
                      : "assest/images/backSquare.png",
                  height: 14,
                  width: 7,
                ) */
                ),
          ),
          Text(
            widget.pageTitle,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ? Colors.white : Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }
}
