import 'package:flutter/material.dart';
import '../../presentation/widgets/dialog/indicator_dialog.dart';

class DialogHelper {
  Future show(BuildContext context, Widget dialog) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void showIndicatorDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const IndicatorDialog();
        });
  }
}
