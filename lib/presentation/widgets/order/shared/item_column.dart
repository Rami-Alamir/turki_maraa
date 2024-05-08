import 'package:flutter/material.dart';
import '../../../../core/utilities/app_localizations.dart';

class ItemColumn extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  const ItemColumn(
      {super.key,
      required this.title,
      required this.value,
      required this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          AppLocalizations.of(context)!.tr(title),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                height: 1.6,
                fontSize: 10,
              ),
        ),
      ],
    );
  }
}
