import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class Badge extends StatelessWidget {
  final Widget child; // our Badge widget will wrap this child widget
  final int value; // what displays inside the badge

  Badge({
    required this.child,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned.directional(
          top: 0,
          start: 2,
          textDirection:
              AppLocalizations.of(context)!.locale == Locale('ar', '')
                  ? TextDirection.ltr
                  : TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: value == 0
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: value == 0 ? Colors.transparent : Colors.white,
                  height: 1.4),
            ),
          ),
        )
      ],
    );
  }
}
