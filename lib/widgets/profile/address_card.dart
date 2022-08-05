import 'package:flutter/material.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../provider/home_provider.dart';

class AddressCard extends StatelessWidget {
  final Data userAddress;
  final int index;

  const AddressCard({required this.userAddress, required this.index});

  @override
  Widget build(BuildContext context) {
    return MainCard(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
        child: Container(
          constraints: BoxConstraints(minHeight: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: Container(
                  width: SizeConfig.screenWidth! * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                child: Container(
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
                          Container(
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
                            Container(
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
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        item(
                          context: context,
                          title: AppLocalizations.of(context)!.tr('edit'),
                          onTap: () {
                            final _addressProvider =
                                Provider.of<AddressProvider>(context,
                                    listen: false);

                            if (index == _addressProvider.selectedAddress)
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                AppLocalizations.of(context)!.tr(
                                    'the_address_used_as_a_delivery_address_cannot_be_edited'),
                                textAlign: TextAlign.center,
                              )));
                            else {
                              final _homeProvider = Provider.of<HomeProvider>(
                                  context,
                                  listen: false);

                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                      _homeProvider.isHms
                                          ? '/HMSMap'
                                          : '/GMSMap',
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
                        item(
                            context: context,
                            title: AppLocalizations.of(context)!.tr('remove'),
                            onTap: () {
                              final _addressProvider =
                                  Provider.of<AddressProvider>(context,
                                      listen: false);

                              if (index == _addressProvider.selectedAddress)
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  AppLocalizations.of(context)!.tr(
                                      'the_address_used_as_a_delivery_address_cannot_be_deleted'),
                                  textAlign: TextAlign.center,
                                )));
                              else {
                                final _auth =
                                    Provider.of<Auth>(context, listen: false);
                                _addressProvider.deleteAddress(
                                    context,
                                    _auth.accessToken,
                                    _addressProvider
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

  Widget item(
      {required BuildContext context,
      required String title,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: SizeConfig.screenWidth! / 2 - 15,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
