import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/home/address_box.dart';
import '../../widgets/shared/add_new_address.dart';
import 'package:provider/provider.dart';
import '../../../models/user_address.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import 'address_row.dart';

class AddressContainer extends StatefulWidget {
  final Color? color;
  const AddressContainer({Key? key, this.color}) : super(key: key);

  @override
  AddressContainerState createState() => AddressContainerState();
}

class AddressContainerState extends State<AddressContainer> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return AnimatedContainer(
      duration: const Duration(microseconds: 1),
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).backgroundColor == Colors.black
                    ? Theme.of(context).colorScheme.secondary
                    : widget.color ?? Theme.of(context).primaryColor,
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
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: homeProvider.selectedOrderType == 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: SizeConfig.screenWidth,
                                      constraints: BoxConstraints(
                                        minHeight: 70,
                                        maxHeight:
                                            SizeConfig.screenHeight! * .4,
                                      ),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        children: [
                                          Visibility(
                                            visible:
                                                locationProvider.latLng != null,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Visibility(
                                                visible: locationProvider
                                                        .locationServiceStatus !=
                                                    0,
                                                child: AddressRow(
                                                  onTap: () {
                                                    addressProvider
                                                        .selectedAddress = -1;
                                                    locationProvider
                                                        .selectCurrentLocation();
                                                    _selected = !_selected;
                                                  },
                                                  selected: addressProvider
                                                          .selectedAddress ==
                                                      -1,
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .tr('current_location'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              itemCount: (addressProvider
                                                      .userAddress
                                                      ?.data
                                                      ?.length ??
                                                  0),
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return AddressRow(
                                                  divider: (addressProvider
                                                              .userAddress
                                                              ?.data
                                                              ?.length ??
                                                          0) !=
                                                      index + 1,
                                                  onTap: () {
                                                    _selected = !_selected;
                                                    addressProvider
                                                            .selectedAddress =
                                                        index;
                                                    Data address =
                                                        addressProvider
                                                            .userAddress!
                                                            .data![index];
                                                    locationProvider
                                                        .updateLocationData(
                                                            address
                                                                .countryIosCode!,
                                                            LatLng(
                                                                double.parse(
                                                                    address
                                                                        .lat!),
                                                                double.parse(
                                                                    address
                                                                        .long!)));
                                                  },
                                                  selected: addressProvider
                                                          .selectedAddress ==
                                                      index,
                                                  title: addressProvider
                                                      .userAddress!
                                                      .data![index]
                                                      .label!,
                                                );
                                              }),
                                        ],
                                      )),
                                  Visibility(
                                      visible:
                                          homeProvider.selectedOrderType == 0,
                                      child: const AddNewAddress())
                                ],
                              )
                            : Container()),
                  ),
                ),
              ),
              AddressBox(
                selected: _selected,
                isPickup: homeProvider.selectedOrderType == 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
