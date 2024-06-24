import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_localizations.dart';

class ShowSnackBar {
  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.black10,
        content: Text(
          AppLocalizations.of(context)!.tr(message),
          textAlign: TextAlign.center,
        )));
  }
}
