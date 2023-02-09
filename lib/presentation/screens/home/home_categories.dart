import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/home/address_container.dart';
import '../../widgets/home/categories_group.dart';
import '../../widgets/home/location_disabled.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/products_section2.dart';
import '../../widgets/shared/whatsapp.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({Key? key}) : super(key: key);
  @override
  HomeCategoriesState createState() => HomeCategoriesState();
}

class HomeCategoriesState extends State<HomeCategories> {
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
      appBar: const HomeAppBar(
        back: true,
        // color: Color.fromRGBO(99, 58, 163, 1.0),
      ),
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
                          color: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
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
                                          .titleMedium),
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
