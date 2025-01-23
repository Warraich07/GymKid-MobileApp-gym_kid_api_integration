import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GaugeMeter extends StatefulWidget {
  @override
  _GaugeMeterState createState() => _GaugeMeterState();
}

class _GaugeMeterState extends State<GaugeMeter> {
  double pinPosition = 0.5; // Initial pin position (0.0 to 1.0)

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          // Adjust the pin position based on the drag movement
          pinPosition = (pinPosition + details.delta.dx / 100).clamp(0.0, 1.0);
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Add your gauge background image
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/meter.png')),
          // Position the pin image based on pinPosition
          Positioned(
            top: 90,
            child: Image.asset(
              'assets/images/pin.png',
              height: 40,
            ),
          ),
          Positioned(
            top: 160,
            child: Text(
              '45%',
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 30,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0.02,
              ),
            ),
          ),
          Positioned(
            top: 180,
            child: Text(
              'Okay, but room\nto improve!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF848484),
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
