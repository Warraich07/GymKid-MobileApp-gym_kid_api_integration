import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/styles.dart';

class HeadingText extends StatefulWidget {
  final String text;
  final TextAlign? textAlign;
  const HeadingText(
      {super.key, required this.text, this.textAlign = TextAlign.center});

  @override
  State<HeadingText> createState() => _HeadingTextState();
}

class _HeadingTextState extends State<HeadingText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: boldStyle.copyWith(
        color: Get.isDarkMode ? AppColors.fontColor : Colors.white,
      ),
    );
  }
}

class SubHeadingText extends StatefulWidget {
  final String text;
  const SubHeadingText({super.key, required this.text});

  @override
  State<SubHeadingText> createState() => _SubHeadingTextState();
}

class _SubHeadingTextState extends State<SubHeadingText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: subHeadingStyle.copyWith(
        color: Get.isDarkMode
            ? Colors.white.withOpacity(0.6)
            : Colors.white.withOpacity(0.6),
        height: 1.4
      ),
    );
  }
}
