import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../shared/rectangle_text_field.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../controllers/location_provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/user_address.dart';

class MapBottomSheet extends StatelessWidget {
  final int addressIndex;
  final int userAddressId;
  final String addressDescription;

  const MapBottomSheet(
      {super.key,
      required this.addressIndex,
      required this.userAddressId,
      required this.addressDescription});
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (_, addressProvider, __) {
      return InkWell(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        splashColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25.0),
              topLeft: Radius.circular(25.0),
            ),
          ),
          constraints: const BoxConstraints(maxHeight: 360),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tr("delivery_address"),
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        addressDescription,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.tr("address_name"),
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(height: 2),
                    ),
                  ],
                ),
              ),
              RectangleTextField(
                customWidth: SizeConfig.screenWidth! - 40,
                hint: AppLocalizations.of(context)!.tr('address_name_hint'),
                maxLength: 40,
                controller: addressProvider.addressNameController,
                padding: const EdgeInsets.only(
                    bottom: 20, right: 20, left: 20, top: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  AppLocalizations.of(context)!.tr('additional_notes'),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              RectangleTextField(
                customWidth: SizeConfig.screenWidth! - 40,
                maxLength: 80,
                hint: AppLocalizations.of(context)!.tr('additional_notes'),
                controller: addressProvider.descriptionController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              Center(
                child: RoundedRectangleButton(
                  title: AppLocalizations.of(context)!.tr('confirm'),
                  fontSize: 16.0,
                  width: SizeConfig.screenWidth! - 40,
                  padding: const EdgeInsets.all(10),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (addressIndex == -100) {
                      int statusCode =
                          await addressProvider.addNewAddress(context);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        final locationProvider = Provider.of<LocationProvider>(
                            context,
                            listen: false);
                        switch (statusCode) {
                          case 200:
                            final Data address = addressProvider.userAddress!
                                .data![addressProvider.selectedAddress];
                            locationProvider.updateLocationData(
                                address.countryIosCode!,
                                LatLng(double.parse(address.lat!),
                                    double.parse(address.long!)),
                                id: address.id!,
                                address: address.address!);
                            Navigator.of(context).pop();
                            break;
                          // 1 mean user not auth and will use address without add it on server
                          case 1:
                            locationProvider.updateLocationData(
                                addressProvider.mapCountryCode!,
                                addressProvider.mapLatLng,
                                language: AppLocalizations.of(context)!
                                    .locale!
                                    .languageCode,
                                setSelected: true);
                            break;
                          default:
                            sl<ShowSnackBar>().show(
                                context,
                                statusCode == 400
                                    ? "region_not_supported"
                                    : "unexpected_error");
                            break;
                        }
                      }
                    } else {
                      int statusCode = await addressProvider.updateAddress(
                          context, userAddressId);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        switch (statusCode) {
                          case 200:
                            Navigator.of(context).pop();
                            break;
                          default:
                            sl<ShowSnackBar>().show(
                                context,
                                statusCode == 400
                                    ? "region_not_supported"
                                    : "unexpected_error");
                            break;
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
