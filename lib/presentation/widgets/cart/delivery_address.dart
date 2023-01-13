import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_address'),
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10.0, top: 15, left: 10),
          constraints: const BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! * .75,
                    child: Text(
                        getAddress(
                          context,
                        ),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getAddress(context) {
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    String address;
    if (addressProvider.selectedAddress == -1) {
      address = GetStrings().currentLocation(
          context,
          cartProvider.currentLocationDescriptionAr,
          cartProvider.currentLocationDescriptionEn);
    } else {
      address = addressProvider
          .userAddress!.data![addressProvider.selectedAddress].label!;
    }
    cartProvider.selectedAddress = address;
    return address;
  }
}
