import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/address_container.dart';
import 'package:new_turki/widgets/home/best_seller_section.dart';
import 'package:new_turki/widgets/home/categories_group.dart';
import 'package:new_turki/widgets/home/category_app_bar.dart';
import 'package:new_turki/widgets/home/location_disabled.dart';
import 'package:new_turki/widgets/home/order_type.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
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
    WidgetsBinding.instance!.addObserver(this);
    final _auth = Provider.of<Auth>(context, listen: false);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    _addressProvider
        .getAddressList(_auth.isAuth ? "Bearer ${_auth.accessToken}" : "");
    //  initDynamicLinks();
  }

  // Future<void> initDynamicLinks() async {
  //   print('initDynamicLinks');
  //   FirebaseHelper.dynamicLinks!.onLink.listen((dynamicLinkData) {
  //     print(dynamicLinkData.asMap().toString());
  //     final Uri uri = dynamicLinkData.link;
  //     final queryParams = uri.queryParameters;
  //     if (queryParams.isNotEmpty) {
  //       String? productId = queryParams["id"];
  //       Navigator.pushNamed(context, dynamicLinkData.link.path,
  //           arguments: {"productId": int.parse(productId!)});
  //     } else {
  //       Navigator.pushNamed(
  //         context,
  //         dynamicLinkData.link.path,
  //       );
  //     }
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }

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
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    final _homeProvider = Provider.of<HomeProvider>(context);
    final _appLanguage = Provider.of<AppLanguage>(context);
    final _addressProvider = Provider.of<AddressProvider>(context);
    if (_addressProvider.latLng == LatLng(0, 0) &&
        _homeProvider.latLng != null) {
      _addressProvider.latLng = _homeProvider.latLng!;
      _addressProvider.isoCountryCode = _homeProvider.isoCountryCode;
      _addressProvider.initMapData(_appLanguage.language);
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CategoryAppBar(
          parentScaffoldKey: widget.parentScaffoldStateKey,
        ),
        body: Stack(
          children: [
            _homeProvider.locationServiceStatus == 0
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
                                    latLng: _addressProvider.latLng,
                                    countryId: _addressProvider.isoCountryCode,
                                  );
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                  top: _homeProvider.canPickup
                                      ? 230.0 - _statusBarHeight
                                      : 100,
                                ),
                                child: RefreshIndicator(
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  onRefresh: () async {
                                    await _homeProvider.getHomePageData(
                                      _addressProvider.selectedAddress == -1,
                                      latLng: _addressProvider.latLng,
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
                                          visible: (_homeProvider.categoryData
                                                      .data?.length ??
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
                                      BestSellerSection(
                                        products: _homeProvider.bestSeller!,
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
