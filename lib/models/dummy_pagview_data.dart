import 'package:flutter/material.dart';

class PageData {
  final String profileImage;
  final String name;
  final String role;
  final String question;
  final List<ProgressBarData> progressBars;
  final String timestamp;

  PageData({
    required this.profileImage,
    required this.name,
    required this.role,
    required this.question,
    required this.progressBars,
    required this.timestamp,
  });
}

class ProgressBarData {
  final double value;
  final String text;
  final bool check;

  ProgressBarData({
    required this.value,
    required this.text,
    required this.check,
  });
}