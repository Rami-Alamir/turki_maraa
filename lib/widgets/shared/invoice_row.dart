import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class InvoiceRow extends StatelessWidget {
  final String title;
  final String value;
  final Color fontColor;
  final bool visible;

  const InvoiceRow(
      {required this.title,
      required this.value,
      this.visible = true,
      this.fontColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.tr(title),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w600, color: fontColor),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w600, color: fontColor),
            ),
          ],
        ),
      ),
    );
  }
}
