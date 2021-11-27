import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class ItemColumn extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  const ItemColumn(
      {required this.title,
      required this.value,
      required this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          AppLocalizations.of(context)!.tr(title),
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              height: 1.6,
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
