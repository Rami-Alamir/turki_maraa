import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../other/new_version.dart';
import '../../widgets/dialog/gift_credit_dialog.dart';
import '../../widgets/home/home/not_supported_area.dart';
import '../../widgets/dialog/special_message_dialog.dart';
import '../../widgets/home/home/address_container.dart';
import '../../widgets/home/home/categories_group.dart';
import '../../widgets/home/home/location_disabled.dart';
import '../../widgets/home/home/home_app_bar.dart';
import '../../widgets/home/home/products_section2.dart';
import '../../widgets/shared/maintenance.dart';
import '../../widgets/shared/whatsapp.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/app_language.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/dialog_helper.dart';
import '../../../core/utilities/enum/location_service_status.dart';
import '../../../core/service/service_locator.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldStateKey;

  const Home({super.key, required this.parentScaffoldStateKey});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //used to get data after change location permission
    if (mounted) {
      final LocationProvider locationProvider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );
      if (locationProvider.latLng == null &&
          state == AppLifecycleState.resumed &&
          (locationProvider.locationServiceStatus ==
                  LocationServiceStatus.noAccess ||
              locationProvider.locationServiceStatus ==
                  LocationServiceStatus.unableToDetermine)) {
        final HomeProvider homeProvider = Provider.of<HomeProvider>(
          context,
          listen: false,
        );
        homeProvider.setIsLoading = true;
        locationProvider.initLatLng(context.read<AppLanguage>().language);
      }
    }
  }

  @override
  void didChangeDependencies() async {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    final Auth auth = Provider.of<Auth>(context);
    bool status = await appProvider.showEidMessage();
    if (status) {
      if (!mounted) return;
      sl<DialogHelper>().show(context, const SpecialMessageDialog());
    }
    if (appProvider.canUpdate) {
      if (!mounted) return;
      Future.microtask(() {
        if (!mounted) return;
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const NewVersion(),
          ),
          ModalRoute.withName('/'),
        );
      });
    }
    if (auth.isNewUser &&
        (auth.userData?.data?.name ?? "user") != "user" &&
        double.parse(auth.userData?.data?.wallet ?? '0') > 0) {
      auth.isNewUser = false;
      if (!mounted) return;
      sl<DialogHelper>().show(context, const GiftCreditDialog());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: const Whatsapp(),
      appBar: const HomeAppBar(),
      body: Consumer<HomeProvider>(
        builder: (_, homeProvider, _) {
          return Stack(
            children: [
              (homeProvider.locationServiceStatus ==
                              LocationServiceStatus.noAccess ||
                          homeProvider.locationServiceStatus ==
                              LocationServiceStatus.unableToDetermine) &&
                      homeProvider.latLng == null
                  ? LocationDisabled(
                      locationStatus: homeProvider.locationServiceStatus,
                    )
                  : homeProvider.requestStatus == RequestStatus.isLoading ||
                        homeProvider.latLng == null
                  ? SpinkitIndicator(
                      padding: EdgeInsets.only(
                        top: SizeConfig.homeAppBarHeight,
                      ),
                    )
                  : homeProvider.requestStatus == RequestStatus.error
                  ? Retry(
                      padding: EdgeInsets.only(
                        top: SizeConfig.homeAppBarHeight,
                      ),
                      onPressed: () {
                        homeProvider.getHomePageData();
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.homeAppBarHeight + 20,
                      ),
                      child: RefreshIndicator(
                        color: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        onRefresh: () async {
                          await homeProvider.getHomePageData(notify: false);
                        },
                        child: homeProvider.maintenanceStatus
                            ? const Maintenance()
                            : ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  if ((homeProvider
                                              .categoryData
                                              ?.data
                                              ?.length ??
                                          0) >
                                      0)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20,
                                        left: 20,
                                        top: 65,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.tr('what_would_you_want_today'),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                    ),
                                  if (homeProvider.locationServiceStatus !=
                                          LocationServiceStatus
                                              .beingDetermined &&
                                      !homeProvider.areaStatus) ...[
                                    const NotSupportedArea(),
                                  ] else ...[
                                    const CategoriesGroup(),
                                  ],
                                  if (((homeProvider
                                              .categoryData
                                              ?.data
                                              ?.length) ??
                                          0) !=
                                      0)
                                    if (homeProvider.bestSeller != null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: ProductsSection2(
                                          title: AppLocalizations.of(
                                            context,
                                          )!.tr('most_wanted'),
                                          products: homeProvider.bestSeller,
                                        ),
                                      ),
                                ],
                              ),
                      ),
                    ),
              Positioned(
                top: SizeConfig.homeAppBarHeight,
                child: const AddressContainer(),
              ),
            ],
          );
        },
      ),
    );
  }
}
