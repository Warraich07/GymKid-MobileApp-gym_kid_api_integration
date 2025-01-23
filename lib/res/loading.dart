import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_kid/res/colors.dart';

final spinkit = SpinKitFadingCircle(
  size: 50.0, // Adjust the size of the circles
  itemBuilder: (BuildContext context, int index) {
    return SizedBox(
      width: 5.0, // Adjust the spacing between circles
      height: 5.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.loaderColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  },
);
