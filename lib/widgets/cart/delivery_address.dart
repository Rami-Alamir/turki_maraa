import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class DeliveryAddress extends StatelessWidget {
  final String address;

  const DeliveryAddress({required this.address});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 30, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_address'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 15, left: 10),
          child: Container(
            constraints: BoxConstraints(minHeight: 56),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_pin,
                      color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: SizeConfig.screenWidth! * .75,
                      child: Text(address,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
