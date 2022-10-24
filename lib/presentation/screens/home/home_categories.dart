import 'package:flutter/material.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/home/address_container.dart';
import '../../widgets/home/categories_group.dart';
import '../../widgets/home/location_disabled.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/order_type.dart';
import '../../widgets/home/products_section2.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/whatsapp.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({Key? key}) : super(key: key);
  @override
  HomeCategoriesState createState() => HomeCategoriesState();
}

class HomeCategoriesState extends State<HomeCategories> {
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 189),
                              child: Visibility(
                                visible:
                                    (homeProvider.categoryData?.data?.length ??
                                            0) >
                                        0,
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .tr('what_would_you_want_today'),
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                            CategoriesGroup(
                                categoryData: homeProvider.categoryData),
                            Visibility(
                              visible:
                                  ((homeProvider.categoryData?.data?.length) ??
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
        Positioned(
          top: 55 + statusBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: homeProvider.canPickup,
                child: OrderType(
                  visible: homeProvider.canPickup,
                  // color: const Color.fromRGBO(99, 58, 163, 1.0),
                ),
              ),
              const AddressContainer(
                  // color: Color.fromRGBO(99, 58, 163, 1.0),
                  ),
            ],
          ),
        ),
      ]),
    );
  }
}
