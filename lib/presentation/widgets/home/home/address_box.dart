import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/address_provider.dart';
import '../../../../controllers/location_provider.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/enum/location_service_status.dart';
import '../../../../core/utilities/get_strings.dart';
import '../../../../core/utilities/size_config.dart';

class AddressBox extends StatelessWidget {
  final bool selected;
  final bool isPickup;

  const AddressBox({super.key, required this.selected, required this.isPickup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
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
                            color: Theme.of(context).colorScheme.tertiary,
                            size: 17.5,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth! - 130,
                            child: Text(
                              locationName(context,
                                  context.watch<LocationProvider>(), isPickup),
                              maxLines: 3,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ],
                      )),
                  Icon(
                    selected
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
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
    LocationServiceStatus locationServiceStatus =
        locationProvider.locationServiceStatus;
    if (isPickup) {
      return AppLocalizations.of(context)!.tr('soon');
    }
    if (locationProvider.customerHaveLocation) {
      return locationProvider.selectedLocationDescription;
    } else if (context.watch<AddressProvider>().selectedAddress == -1) {
      switch (locationServiceStatus) {
        case LocationServiceStatus.savedLocation:
          return locationProvider.selectedLocationDescription;
        case LocationServiceStatus.beingDetermined:
          return AppLocalizations.of(context)!
              .tr('your_location_is_being_determined');
        case LocationServiceStatus.noAccess:
          return ("${AppLocalizations.of(context)!.tr('delivery_to')} ${AppLocalizations.of(context)!.tr('choose')}");
        case LocationServiceStatus.fetched:
          return ("${AppLocalizations.of(context)!.tr('delivery_to')} ${sl<GetStrings>().currentLocation(context, locationProvider.currentLocationDescriptionAr, locationProvider.currentLocationDescriptionEn)}");
        default:
          return ("${AppLocalizations.of(context)!.tr('delivery_to')} ${AppLocalizations.of(context)!.tr('choose')}");
      }
    } else {
      return locationProvider.selectedLocationDescription;
    }
  }
}
