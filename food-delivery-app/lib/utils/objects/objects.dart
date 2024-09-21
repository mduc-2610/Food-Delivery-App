import 'package:flutter/material.dart';

class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeOfDayRange({required this.start, required this.end});

  @override
  String toString() {
    return "${start} - ${end}";
  }
}
