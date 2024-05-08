import 'package:flutter/material.dart';
import '../../shared/main_card.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class DeliveryAddress extends StatelessWidget {
  final String address;

  const DeliveryAddress({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_address'),
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        MainCard(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(Icons.location_pin,
                    color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                width: SizeConfig.screenWidth! * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(address,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(height: 1.8)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
