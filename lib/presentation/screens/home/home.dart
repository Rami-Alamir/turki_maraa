import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/address_container.dart';
import '../../widgets/home/almaraa_card.dart';
import '../../widgets/home/location_disabled.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/shared/whatsapp.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
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
      floatingActionButton: const Whatsapp(),
      appBar: HomeAppBar(
        parentScaffoldKey: widget.parentScaffoldStateKey,
      ),
      extendBodyBehindAppBar: true,
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
                          homeProvider.setIsLoading = true;
                          homeProvider.getHomePageData();
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.homeAppBarHeight + 50),
                        child: RefreshIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          onRefresh: () async {
                            await homeProvider.getHomePageData(notify: false);
                          },
                          child: ListView(
                            padding: const EdgeInsets.only(top: 20),
                            children: const [
                              AlmaraaCard(),
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
