import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../models/user_address.dart';
import '../../../controllers/address_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import '../../../controllers/location_provider.dart';
import 'address_card_item.dart';

class AddressCard extends StatelessWidget {
  final Data userAddress;
  final int index;

  const AddressCard({Key? key, required this.userAddress, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
        child: Container(
          constraints: const BoxConstraints(minHeight: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: SizedBox(
                  width: SizeConfig.screenWidth! * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.72,
                        child: Text(
                          userAddress.label ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  width: SizeConfig.screenWidth! * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 4.0, 0),
                            child: Icon(
                              TURKIICONS.home_location_white,
                              size: 17.5,
                              color:
                                  Theme.of(context).textTheme.headline4!.color,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth! * 0.72,
                            child: Text(
                              userAddress.address ?? "",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth! * 0.72,
                              child: Text(
                                userAddress.comment ?? "",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.15),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AddressCardItem(
                          title: AppLocalizations.of(context)!.tr('edit'),
                          onTap: () {
                            final AddressProvider addressProvider =
                                Provider.of<AddressProvider>(context,
                                    listen: false);
                            if (index == addressProvider.selectedAddress) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                AppLocalizations.of(context)!.tr(
                                    'the_address_used_as_a_delivery_address_cannot_be_edited'),
                                textAlign: TextAlign.center,
                              )));
                            } else {
                              final LocationProvider locationProvider =
                                  Provider.of<LocationProvider>(context,
                                      listen: false);
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                      locationProvider.isHms ? hmsMap : gmsMap,
                                      arguments: index);
                            }
                          },
                        ),
                        Container(
                          width: 1,
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer
                              .withOpacity(0.15),
                        ),
                        AddressCardItem(
                            title: AppLocalizations.of(context)!.tr('remove'),
                            onTap: () {
                              final AddressProvider addressProvider =
                                  Provider.of<AddressProvider>(context,
                                      listen: false);
                              if (index == addressProvider.selectedAddress) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  AppLocalizations.of(context)!.tr(
                                      'the_address_used_as_a_delivery_address_cannot_be_deleted'),
                                  textAlign: TextAlign.center,
                                )));
                              } else {
                                addressProvider.deleteAddress(
                                    context,
                                    addressProvider
                                        .userAddress!.data![index].id!);
                              }
                            }),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
