import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';

class CommonContainer extends StatefulWidget {
  final bool selected;
  final String text;
  const CommonContainer({Key? key, required this.selected, required this.text})
      : super(key: key);

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 52,
      decoration: ShapeDecoration(
        color: Get.isDarkMode
            ? AppColors.darkContainerColor
            : AppColors.darkContainerColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(
                color: widget.selected
                    ? AppColors.secondaryColor
                    : Colors.transparent)),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.white,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
