import 'dart:ui';

import 'package:flutter/material.dart';

class FeelingsLogs {
  String heading;
  String emoji;
  String description;
  String date;
  Color color;
  DateTime fulldate;
  FeelingsLogs({
    required this.date,
    required this.emoji,
    required this.description,
    required this.heading,
    required this.color,
    required this.fulldate
  });
}

