import 'package:flutter/material.dart';
import 'package:new_turki/widgets/dialog/confirm_dialog.dart';

class ShowConfirmDialog {
  Future confirmDialog(BuildContext context, String msg, confirmAction) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return ConfirmDialog(msg: msg, confirmAction: confirmAction);
      },
    );
  }
}
