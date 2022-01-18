import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/firebase_helper.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/address_container.dart';
import 'package:new_turki/widgets/home/categories_g1.dart';
import 'package:new_turki/widgets/home/categories_g2.dart';
import 'package:new_turki/widgets/home/categories_g3.dart';
import 'package:new_turki/widgets/home/categories_g4.dart';
import 'package:new_turki/widgets/home/categories_large.dart';
import 'package:new_turki/widgets/home/category_app_bar.dart';
import 'package:new_turki/widgets/home/not_supported_area.dart';
import 'package:new_turki/widgets/home/order_type.dart';
import 'package:new_turki/widgets/home/product_card.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldStateKey;

  const Home({required this.parentScaffoldStateKey});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final _auth = Provider.of<Auth>(context, listen: false);
    _homeProvider.getHomePageData();
    _addressProvider.initMapData();
    _addressProvider
        .getAddressList(_auth.isAuth ? "Bearer ${_auth.accessToken}" : "");
    initDynamicLinks();
    super.initState();
  }

  Future<void> initDynamicLinks() async {
    print('initDynamicLinks');
    FirebaseHelper.dynamicLinks!.onLink.listen((dynamicLinkData) {
      print(dynamicLinkData.asMap().toString());
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        String? productId = queryParams["id"];
        Navigator.pushNamed(context, dynamicLinkData.link.path,
            arguments: {"productId": int.parse(productId!)});
      } else {
        Navigator.pushNamed(
          context,
          dynamicLinkData.link.path,
        );
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    final _homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CategoryAppBar(
          onTap: () {},
          parentScaffoldKey: widget.parentScaffoldStateKey,
        ),
        body: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onRefresh: () async {
              _homeProvider.getHomePageData();
            },
            child: Stack(
              children: [
                _homeProvider.isLoading
                    ? SpinkitIndicator(
                        padding: EdgeInsets.only(top: 170),
                      )
                    : _homeProvider.retry
                        ? Retry(
                            padding: EdgeInsets.only(top: 170),
                            onPressed: () {
                              _homeProvider.setIsLoading = true;
                              _homeProvider.getHomePageData();
                            },
                          )
                        : ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: _homeProvider.canPickup
                                        ? 220.0 - _statusBarHeight
                                        : 100,
                                    right: 20,
                                    left: 20),
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .tr('what_would_you_want_today'),
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                              categoriesGroup(
                                  _homeProvider.categoryData.data?.length ?? 0,
                                  _homeProvider),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, left: 5, bottom: 8, top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .tr('most_wanted'),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .tr('view_all'),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10)),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    height: 200,
                                    child: ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: const ScrollPhysics(),
                                        itemCount:
                                            DummyData.bestSellerList.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    index == 0 ? 8 : 3.0,
                                                    0,
                                                    0,
                                                    0),
                                            child: ProductCard(
                                                product: DummyData
                                                    .bestSellerList[index]),
                                          );
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                Positioned(
                  top: 56 + _statusBarHeight,
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
              ],
            )));
  }

  Widget categoriesGroup(int length, HomeProvider homeProvider) {
    if (SizeConfig.screenWidth! > 590)
      return CategoriesLarge(categoriesList: homeProvider.categoryData.data!);
    else
      switch (length) {
        case 0:
          return Padding(
            padding: EdgeInsets.only(top: 240.0),
            child: NotSupportedArea(),
          );
        case 1:
          return CategoriesG1(
            categoryData: homeProvider.categoryData.data![0],
          );
        case 2:
          return CategoriesG2(categoriesList: homeProvider.categoryData.data!);
        case 3:
          return CategoriesG3(categoriesList: homeProvider.categoryData.data!);
        default:
          return CategoriesG4(categoriesList: homeProvider.categoryData.data!);
      }
  }
}
