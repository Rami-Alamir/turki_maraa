import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';

class AddressBox extends StatelessWidget {
  final bool selected;
  final bool isPickup;

  const AddressBox({Key? key, required this.selected, required this.isPickup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: Theme.of(context).backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.3),
                  blurRadius: 6,
                  spreadRadius: 0.5,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: SizeConfig.screenWidth! - 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.place,
                            color: Theme.of(context).primaryColor,
                            size: 17.5,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth! - 130,
                            child: Text(
                              locationName(context, locationProvider, isPickup),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      )),
                  Icon(
                    selected
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).textTheme.subtitle2!.color,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String locationName(
      BuildContext context, LocationProvider locationProvider, bool isPickup) {
    int locationServiceStatus = locationProvider.locationServiceStatus;
    if (isPickup) {
      return AppLocalizations.of(context)!.tr('soon');
    }
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    if (addressProvider.selectedAddress == -1) {
      switch (locationServiceStatus) {
        case -1:
          return AppLocalizations.of(context)!
              .tr('your_location_is_being_determined');
        case 0:
          return ("${AppLocalizations.of(context)!.tr('delivery_to')} ${AppLocalizations.of(context)!.tr('choose')}");
        case 1:
          return ("${AppLocalizations.of(context)!.tr('delivery_to')} ${sl<GetStrings>().currentLocation(context, locationProvider.currentLocationDescriptionAr, locationProvider.currentLocationDescriptionEn)}");
        default:
          return ("${AppLocalizations.of(context)!.tr('delivery_to')} ${AppLocalizations.of(context)!.tr('choose')}");
      }
    } else {
      return locationProvider.selectedLocationDescription;
    }
  }
}
