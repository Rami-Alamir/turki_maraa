import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/address_container.dart';
import 'package:new_turki/widgets/home/almaraa_card.dart';
import 'package:new_turki/widgets/home/category_app_bar.dart';
import 'package:new_turki/widgets/home/location_disabled.dart';
import 'package:new_turki/widgets/home/order_type.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:new_turki/widgets/shared/whatsapp.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldStateKey;

  const Home({required this.parentScaffoldStateKey});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final _auth = Provider.of<Auth>(context, listen: false);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    _addressProvider
        .getAddressList(_auth.isAuth ? "Bearer ${_auth.accessToken}" : "");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (state == AppLifecycleState.resumed &&
        _homeProvider.locationServiceStatus == 0) {
      print("rami:" + AppLifecycleState.values.first.toString());
      _homeProvider.getHomePageData(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    _homeProvider.showNewVersion(context);
    print('${SizeConfig.screenWidth!}');
    print('${SizeConfig.screenHeight!}');
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
                                                  AppLocalizations.of(context)!
                                                      .tr('shops'),
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                            ),
                                          ),
                                          AlmaraaCard(
                                              appKey: widget
                                                  .parentScaffoldStateKey),
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
