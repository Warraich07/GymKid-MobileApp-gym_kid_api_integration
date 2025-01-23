import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget authShadow() {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0x0C1B1B1B), Color(0xFF1B1B1B)],
            ),
          ),
        ),
        Container(
          height: 50.h,
          decoration: const BoxDecoration(color: Color(0xff1B1B1B)),
        ),
      ],
    ),
  );
}
