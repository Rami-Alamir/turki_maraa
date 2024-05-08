import 'package:flutter/material.dart';
import 'app_localizations.dart';

class ShowSnackBar {
  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(message),
      textAlign: TextAlign.center,
    )));
  }
}
