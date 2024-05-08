import 'package:flutter/material.dart';
import '../../shared/main_card.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class OrderNote extends StatelessWidget {
  final String note;
  const OrderNote({super.key, required this.note});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.tr('note'),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        MainCard(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: SizeConfig.screenWidth! * 0.8,
                  child: Text(note,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.5)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
