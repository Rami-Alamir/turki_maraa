import 'package:flutter/material.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class AddressContainer extends StatefulWidget {
  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    final _addressProvider = Provider.of<AddressProvider>(context);

    final List<Data>? _addressList = _addressProvider.userAddress?.data;
    return AnimatedContainer(
      duration: Duration(microseconds: 1),
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
        },
        child: Container(
          color: Colors.transparent,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).backgroundColor == Colors.black
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).primaryColor,
                height: 35,
              ),
              Visibility(
                visible: _selected,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 60),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7)),
                      color: Theme.of(context).backgroundColor,
                      boxShadow: [],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                                visible: _homeProvider.selectedOrderType == 0,
                                child: InkWell(
                                  onTap: () {
                                    _addressProvider.setSelectedAddress = -1;
                                    _selected = false;
                                    final _homeProvider =
                                        Provider.of<HomeProvider>(context,
                                            listen: false);
                                    _homeProvider.setIsLoading = true;

                                    _homeProvider.getHomePageData(true,
                                        latLng: _homeProvider.latLng!,
                                        countryId: _homeProvider
                                            .currentIsoCountryCode);
                                    _addressProvider.isoCountryCode =
                                        _homeProvider.currentIsoCountryCode;
                                    _addressProvider.latLng =
                                        _homeProvider.latLng!;
                                  },
                                  child: addressRow(
                                      _addressProvider.addressDescription ??
                                          AppLocalizations.of(context)!
                                              .tr('current_location'),
                                      divider: true),
                                )),
                            Container(
                              width: SizeConfig.screenWidth,
                              constraints: BoxConstraints(
                                maxHeight: SizeConfig.screenHeight! * .4,
                              ),
                              child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemCount:
                                      _homeProvider.selectedOrderType == 0
                                          ? _addressList?.length ?? 0
                                          : 1,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onTap: () {
                                        if (_homeProvider.selectedOrderType ==
                                            0) {
                                          if (_addressProvider
                                                  .selectedAddress !=
                                              index) {
                                            _addressProvider
                                                .initSelectedAddress(index);

                                            _homeProvider.setIsLoading = true;
                                            _homeProvider.getHomePageData(
                                              false,
                                              latLng: _addressProvider.latLng,
                                              countryId: _addressProvider
                                                  .isoCountryCode,
                                            );
                                          }
                                        } else
                                          _homeProvider.setSelectedAddress2 =
                                              index;
                                        _selected = false;
                                        setState(() {});
                                      },
                                      child: addressRow(
                                          _homeProvider.selectedOrderType == 0
                                              ? _addressList![index].address!
                                              : AppLocalizations.of(context)!
                                                  .tr('soon'),
                                          divider: index !=
                                              (_homeProvider.selectedOrderType ==
                                                          0
                                                      ? _addressProvider
                                                          .selectedAddress
                                                      : _homeProvider
                                                          .selectedAddress2) -
                                                  1),
                                    );
                                  }),
                            ),
                            Visibility(
                                visible: _homeProvider.selectedOrderType == 0,
                                child: addNewAddress())
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Theme.of(context).backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryVariant
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
                            Container(
                              width: SizeConfig.screenWidth! - 120,
                              child: Text(
                                  _homeProvider.selectedOrderType == 0
                                      ? _addressProvider.selectedAddress == -1
                                          ? _addressProvider
                                                  .addressDescription ??
                                              AppLocalizations.of(context)!
                                                  .tr('current_location')
                                          : _addressList![_addressProvider
                                                  .selectedAddress]
                                              .address!
                                      : AppLocalizations.of(context)!
                                          .tr('soon'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal)),
                            ),
                            Icon(
                              _selected
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color:
                                  Theme.of(context).textTheme.subtitle2!.color,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressRow(String title, {bool divider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
        ),
        divider
            ? Divider(
                indent: 20,
                endIndent: 20,
                height: 2,
                color: Theme.of(context)
                    .colorScheme
                    .secondaryVariant
                    .withOpacity(0.3),
              )
            : Padding(
                padding: const EdgeInsets.all(4.0),
              ),
      ],
    );
  }

  Widget addNewAddress() {
    return InkWell(
      onTap: () {
        final _auth = Provider.of<Auth>(context, listen: false);
        if (_auth.isAuth) {
          _selected = false;
          Navigator.pushNamed(context, '/AddNewAddress');
        } else
          Navigator.of(context, rootNavigator: true).pushNamed('/Login');
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            RoundedRectangleButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0),
              width: 22,
              height: 22,
              fontSize: 18,
              title: '+',
            ),
            Text(AppLocalizations.of(context)!.tr('add_new_delivery_address'),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
