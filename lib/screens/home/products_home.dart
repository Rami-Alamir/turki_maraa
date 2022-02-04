import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/home/discover_section.dart';
import 'package:new_turki/widgets/home/food_appbar.dart';
import 'package:new_turki/widgets/home/products_section.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
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
      appBar: ((_homeProvider.bannersData?.data?[0].banners?.length ?? 0) == 0)
          ? PrimaryAppBar(
              action: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, "/Search"),
                  icon: Icon(
                    RA7ICONS.search,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          : null,
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
                        if ((_homeProvider
                                    .bannersData?.data?[0].banners?.length ??
                                0) >
                            0)
                          FoodAppBar(
                            changeColor: _changeColor,
                            bannersData: _homeProvider.bannersData!,
                          ),
                        if (_homeProvider.discoverData != null)
                          DiscoverSection(
                            discoverList: _homeProvider.discoverData!,
                          ),
                        // // // HtmlSection(),
                        SliverToBoxAdapter(
                            child: ProductsSection(
                                products: _homeProvider.productsList)),
                      ])),
    );
  }
}
