import 'package:flutter/material.dart';
import '../widgets/dialog/confirm_dialog.dart';

class ShowConfirmDialog {
  Future confirmDialog(
      BuildContext context, confirmAction, String message, String title,
      {String? icon}) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      // barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return ConfirmDialog(
            confirmAction: confirmAction,
            message: message,
            title: title,
            icon: icon);
      },
    );
  }
}
