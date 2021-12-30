import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class ConfirmDialog extends StatelessWidget {
  final String msg;
  final String confirmText;
  final String cancelText;
  final Function confirmAction;

  const ConfirmDialog({
    required this.msg,
    this.confirmText = 'yes',
    this.cancelText = 'cancel',
    required this.confirmAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        AppLocalizations.of(context)!.tr(msg),
        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.tr(cancelText),
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.tr(confirmText),
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12),
          ),
          onPressed: () async {
            Navigator.pop(context);

            await confirmAction();
          },
        )
      ],
    );
  }
}
