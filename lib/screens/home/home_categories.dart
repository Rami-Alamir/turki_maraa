import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/address_container.dart';
import 'package:new_turki/widgets/home/categories_group.dart';
import 'package:new_turki/widgets/home/category_app_bar.dart';
import 'package:new_turki/widgets/home/location_disabled.dart';
import 'package:new_turki/widgets/home/order_type.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:new_turki/widgets/shared/whatsapp.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/best_seller_section.dart';

class HomeCategories extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldStateKey;

  const HomeCategories({required this.parentScaffoldStateKey});
  @override
  _HomeCategoriesState createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    _homeProvider.showNewVersion(context);

    double _statusBarHeight = MediaQuery.of(context).padding.top;
    final _appLanguage = Provider.of<AppLanguage>(context);
    final _addressProvider = Provider.of<AddressProvider>(context);
    if (_addressProvider.myMarker == null) {
      _addressProvider.initMapData(_appLanguage.language);
    }
    if (_addressProvider.selectedLatLng ==
            LatLng(24.727726176454684, 46.58666208381939) &&
        _homeProvider.latLng != null) {
      _addressProvider.setSelectedLatLng = _homeProvider.latLng!;
      _addressProvider.mapLatLng = _homeProvider.latLng!;
      _addressProvider.isoCountryCode = _homeProvider.isoCountryCode;
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: Visibility(
            visible: (!_homeProvider.isLoading && !_homeProvider.retry) ||
                _homeProvider.locationServiceStatus == 0,
            child: Whatsapp()),
        appBar: CategoryAppBar(
          back: true,
          parentScaffoldKey: widget.parentScaffoldStateKey,
        ),
        body: Stack(
          children: [
            _homeProvider.locationNotAvailable &&
                    _homeProvider.locationServiceStatus != 0
                ? Container()
                : _homeProvider.locationServiceStatus == 0
                    ? LocationDisabled()
                    : _homeProvider.locationServiceStatus == -1
                        ? SpinkitIndicator(
                            padding: EdgeInsets.only(top: 170),
                          )
                        : _homeProvider.isLoading
                            ? SpinkitIndicator(
                                padding: EdgeInsets.only(top: 170),
                              )
                            : _homeProvider.retry
                                ? Retry(
                                    padding: EdgeInsets.only(top: 170),
                                    onPressed: () {
                                      _homeProvider.setIsLoading = true;
                                      _homeProvider.getHomePageData(
                                        _addressProvider.selectedAddress == -1,
                                        latLng: _addressProvider.selectedLatLng,
                                        countryId:
                                            _addressProvider.isoCountryCode,
                                      );
                                    },
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      top: _homeProvider.canPickup
                                          ? 230.0 - _statusBarHeight
                                          : 150,
                                    ),
                                    child: RefreshIndicator(
                                      color: Theme.of(context).primaryColor,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onRefresh: () async {
                                        await _homeProvider.getHomePageData(
                                          _addressProvider.selectedAddress ==
                                              -1,
                                          latLng:
                                              _addressProvider.selectedLatLng,
                                          countryId:
                                              _addressProvider.isoCountryCode,
                                        );
                                      },
                                      child: ListView(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 20, left: 20),
                                            child: Visibility(
                                              visible: (_homeProvider
                                                          .categoryData
                                                          .data
                                                          ?.length ??
                                                      0) >
                                                  0,
                                              child: Text(
                                                  AppLocalizations.of(context)!.tr(
                                                      'what_would_you_want_today'),
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                            ),
                                          ),
                                          CategoriesGroup(
                                              categoryData:
                                                  _homeProvider.categoryData),
                                          Visibility(
                                            visible: (_homeProvider.categoryData
                                                        .data?.length ??
                                                    0) >
                                                0,
                                            child: BestSellerSection(
                                              products:
                                                  _homeProvider.bestSeller!,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
            Positioned(
              top: 55 + _statusBarHeight,
              child: Visibility(
                visible: (!_homeProvider.isLoading && !_homeProvider.retry) ||
                    _homeProvider.locationServiceStatus == 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: _homeProvider.canPickup,
                      child: OrderType(
                        visible: _homeProvider.canPickup,
                      ),
                    ),
                    if (!_homeProvider.isLoading) AddressContainer(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}