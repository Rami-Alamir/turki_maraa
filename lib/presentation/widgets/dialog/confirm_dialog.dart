import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utilities/app_localizations.dart';

class ConfirmDialog extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final Function confirmAction;
  final String message;
  final String title;
  final String? icon;

  const ConfirmDialog({
    super.key,
    this.confirmText = 'yes',
    this.cancelText = 'cancel',
    required this.confirmAction,
    required this.message,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        backgroundColor: Theme.of(context).colorScheme.background,
        contentPadding: const EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
              height: icon != null ? 140 : 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 25, 10, 15),
                    child: icon != null
                        ? SvgPicture.asset(
                            icon!,
                            height: 45,
                            width: 45,
                            fit: BoxFit.fill,
                          )
                        : Container(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.tr(title),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.tr(message),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.tr(cancelText),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                ),
                Container(
                    width: 2,
                    height: 25,
                    color: Theme.of(context).colorScheme.secondaryContainer),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await confirmAction();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.tr(confirmText),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
