import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:gym_kid/res/colors.dart';

class MyCustomProgressBar extends StatelessWidget {
  final double value; // Value out of 100
  final String text;
  final bool check;
  final Color progressColor;
  MyCustomProgressBar(
      {required this.value, required this.text, required this.check,required this.progressColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30, // Height of the progress bar
          width: Get.width, // Width of the progress bar

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // AnimatedContainer(
              //   duration: Duration(seconds: 1), // Animation duration
              //   width: Get.width *
              //       (value / 100), // Adjust the width based on the value
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10), // Rounded corners
              //     color: check
              //         ? AppColors.secondaryColor
              //         : Color(0xFFE0AD3A), // Progress color
              //   ),
              // ),
              FAProgressBar(
                backgroundColor: Colors.black26,
                progressColor: progressColor ,
                changeColorValue: 41,
                changeProgressColor: AppColors.secondaryColor,
                animatedDuration: const Duration(milliseconds: 2000),
                currentValue: value,
                displayText: null,
              ),
              Positioned(
                left: 10,
                child: Row(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                child: Countup(
                  begin: 0,
                  end: value,
                  duration: const Duration(seconds: 2),
                  separator: ',',
                  style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                ),
                // Text(
                //   value.toInt().toString(),
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 10,
                //     fontFamily: 'Poppins',
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
