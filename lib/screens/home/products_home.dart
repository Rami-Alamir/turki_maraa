import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/products_provider.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/home/discover_section.dart';
import 'package:new_turki/widgets/home/food_appbar.dart';
import 'package:new_turki/widgets/home/products_list_sections.dart';
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
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final _productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _productsProvider.getProductsHomePageData(widget.id,
        _addressProvider.selectedLatLng, _addressProvider.isoCountryCode);
    super.initState();
  }

  //used to change appbar icons and title color when user scroll down
  bool get _changeColor {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<ProductsProvider>(context);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    return Scaffold(
      appBar: ((_productsProvider.bannersData?.data?.length ?? 0) == 0)
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
      body: _productsProvider.productsHomeIsLoading
          ? SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : _productsProvider.productsHomeRetry
              ? Retry(
                  padding: EdgeInsets.only(top: 60),
                  onPressed: () {
                    _productsProvider.setProductIsLoading = true;
                    _productsProvider.getProductsHomePageData(
                        widget.id,
                        _addressProvider.selectedLatLng,
                        _addressProvider.isoCountryCode);
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                  onRefresh: () async {
                    await _productsProvider.getProductsHomePageData(
                        widget.id,
                        _addressProvider.selectedLatLng,
                        _addressProvider.isoCountryCode,
                        isLoading: false);
                  },
                  child: CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        if ((_productsProvider.bannersData?.data?.length ?? 0) >
                            0)
                          FoodAppBar(
                            changeColor: _changeColor,
                            bannersData: _productsProvider.bannersData!,
                          ),
                        if (_productsProvider.discoverData != null)
                          DiscoverSection(
                            discoverList: _productsProvider.discoverData!,
                          ),
                        // // HtmlSection(),
                        SliverToBoxAdapter(
                            child: ProductsListSections(
                                products: _productsProvider.productsList)),
                      ])),
    );
  }
}
