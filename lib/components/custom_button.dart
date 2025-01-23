import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/res/styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomButton {
  static Widget commonButton(
      {required Function()? onTap, required String buttonText}) {
    return ZoomTapAnimation(
      onTap: onTap,
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
            buttonText,
            textAlign: TextAlign.center,
            style: subHeadingStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  static Widget borderButton(

      {required Function()? onTap, required String buttonText,required BoxBorder? border}) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: Get.width * 0.6,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white,border: border),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/* class CustomButton extends StatefulWidget {
  final String buttonText;
  final Function onTap;
  final double? height;
  final double? width;

  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.height = 58.0,
      this.width = 100.0})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ZoomTapAnimation(
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: AssetImage(
                  "assest/images/btnRectangle.png",
                ),
                fit: BoxFit.cover,
              ),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Color(0xFFFF0000), // Start color
              //     Color(0xFFFF8700), // End color
              //   ],
              //   stops: [0.0, 1.0], // Color stops
              //   transform: GradientRotation(
              //       268.5 * 3.1415926535 / 180), // Angle in radians
              // ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  widget.buttonText.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

 */
