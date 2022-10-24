import 'package:flutter/material.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../widgets/home/address_container.dart';
import '../../widgets/home/almaraa_card.dart';
import '../../widgets/home/location_disabled.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/order_type.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/whatsapp.dart';

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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    homeProvider.showNewVersion(context);
    // used to init map marker
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    if (addressProvider.myMarker == null) {
      addressProvider.initMapMarker();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: const Whatsapp(),
      appBar: HomeAppBar(
        parentScaffoldKey: widget.parentScaffoldStateKey,
      ),
      body: Stack(children: [
        (homeProvider.locationServiceStatus == 0 ||
                    homeProvider.locationServiceStatus == 2) &&
                homeProvider.latLng == null
            ? LocationDisabled(
                locationStatus: homeProvider.locationServiceStatus)
            : homeProvider.isLoading || homeProvider.latLng == null
                ? const SpinkitIndicator(
                    padding: EdgeInsets.only(top: 170),
                  )
                : homeProvider.retry
                    ? Retry(
                        padding: const EdgeInsets.only(top: 170),
                        onPressed: () {
                          homeProvider.setIsLoading = true;
                          homeProvider.getHomePageData();
                        },
                      )
                    : RefreshIndicator(
                        color: Theme.of(context).primaryColor,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        onRefresh: () async {
                          await homeProvider.getHomePageData(isLoading: false);
                        },
                        child: ListView(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 189),
                              child: AlmaraaCard(),
                            ),
                          ],
                        ),
                      ),
        Positioned(
          top: 55 + statusBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: homeProvider.canPickup,
                child: OrderType(
                  visible: homeProvider.canPickup,
                ),
              ),
              const AddressContainer(),
            ],
          ),
        ),
      ]),
    );
  }
}
