import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/address_container.dart';
import '../../widgets/home/categories_group.dart';
import '../../widgets/home/location_disabled.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/products_section2.dart';
import '../../widgets/shared/whatsapp.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../../core/utilities/size_config.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldStateKey;

  const Home({Key? key, required this.parentScaffoldStateKey})
      : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //used to get data after change location premonition
    if (mounted) {
      final LocationProvider locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      if (locationProvider.latLng == null &&
          state == AppLifecycleState.resumed &&
          (locationProvider.locationServiceStatus == 0 ||
              locationProvider.locationServiceStatus == 2)) {
        final HomeProvider homeProvider =
            Provider.of<HomeProvider>(context, listen: false);
        homeProvider.setIsLoading = true;
        locationProvider.initLatLng();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    appProvider.showAlert(context);
    // used to init map marker
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    if (addressProvider.myMarker == null) {
      addressProvider.initMapMarker();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: const Whatsapp(),
      appBar: const HomeAppBar(),
      body: Stack(children: [
        (homeProvider.locationServiceStatus == 0 ||
                    homeProvider.locationServiceStatus == 2) &&
                homeProvider.latLng == null
            ? LocationDisabled(
                locationStatus: homeProvider.locationServiceStatus)
            : homeProvider.requestStatus == RequestStatus.isLoading ||
                    homeProvider.latLng == null
                ? SpinkitIndicator(
                    padding: EdgeInsets.only(top: SizeConfig.homeAppBarHeight),
                  )
                : homeProvider.requestStatus == RequestStatus.error
                    ? Retry(
                        padding:
                            EdgeInsets.only(top: SizeConfig.homeAppBarHeight),
                        onPressed: () {
                          homeProvider.getHomePageData();
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.homeAppBarHeight + 20),
                        child: RefreshIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          onRefresh: () async {
                            await homeProvider.getHomePageData(notify: false);
                          },
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, top: 65),
                                child: Visibility(
                                  visible: (homeProvider
                                              .categoryData?.data?.length ??
                                          0) >
                                      0,
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .tr('what_would_you_want_today'),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ),
                              ),
                              const CategoriesGroup(),
                              Visibility(
                                visible: ((homeProvider
                                            .categoryData?.data?.length) ??
                                        0) !=
                                    0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ProductsSection2(
                                    title: AppLocalizations.of(context)!
                                        .tr('most_wanted'),
                                    products: homeProvider.bestSeller,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
        Positioned(
          top: SizeConfig.homeAppBarHeight,
          child: const AddressContainer(),
        ),
      ]),
    );
  }
}
