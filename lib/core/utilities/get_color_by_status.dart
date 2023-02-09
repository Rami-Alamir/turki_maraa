import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class GetColorByStatus {
  Color statusColor(int code) {
    switch (code) {
      case 4000:
        return AppColors.red;
      case 102:
      case 103:
        return AppColors.amber;
      case 14:
      case 200:
        return AppColors.green1;
      default:
        return AppColors.grey;
    }
  }
}
