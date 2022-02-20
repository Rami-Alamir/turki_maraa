import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';

class DeliveryAddress extends StatelessWidget {
  final String address;

  const DeliveryAddress({required this.address});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_address'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        MainCard(
          height: 50,
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
              Container(
                width: SizeConfig.screenWidth! * 0.8,
                child: Text(address,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.5)),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
