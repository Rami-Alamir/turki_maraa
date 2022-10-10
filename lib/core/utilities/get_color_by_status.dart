import 'package:flutter/material.dart';

class GetSColorByStatus {
  Color statusColor(int code) {
    switch (code) {
      case 4000:
        return Colors.red;
      case 102:
      case 103:
        return Colors.amber;
      case 14:
      case 200:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
