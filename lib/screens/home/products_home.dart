import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/widgets/home/discover_section.dart';
import 'package:new_turki/widgets/home/food_appbar.dart';
import 'package:new_turki/widgets/home/products_section.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class ProductsHome extends StatefulWidget {
  final int id;

  const ProductsHome({required this.id});
  @override
  _ProductsHomeState createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.getFoodsPageData(widget.id);
    super.initState();
  }

  //used to change appbar icons and title color when user scroll down
  bool get _changeColor {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: _homeProvider.foodsIsLoading
          ? SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : _homeProvider.foodsRetry
              ? Retry(
                  padding: EdgeInsets.only(top: 60),
                  onPressed: () {
                    _homeProvider.getFoodsPageData(widget.id);
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                  onRefresh: () async {
                    await _homeProvider.getFoodsPageData(widget.id,
                        isLoading: false);
                  },
                  child: CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        FoodAppBar(
                          changeColor: _changeColor,
                          banners: _homeProvider.bannersList,
                        ),
                        DiscoverSection(
                          discoverList: _homeProvider.discoverList,
                        ),
                        // // // HtmlSection(),
                        SliverToBoxAdapter(
                            child: ProductsSection(
                                products: _homeProvider.productsList)),
                      ])),
    );
  }
}
