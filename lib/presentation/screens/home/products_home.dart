import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/products_list_section.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/discover_section.dart';
import '../../widgets/home/food_appbar.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/products_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class ProductsHome extends StatefulWidget {
  final int id;

  const ProductsHome({Key? key, required this.id}) : super(key: key);
  @override
  ProductsHomeState createState() => ProductsHomeState();
}

class ProductsHomeState extends State<ProductsHome> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.getFoodsPageData(
      widget.id,
    );
    super.initState();
  }

  //used to change appbar icons and title color when user scroll down
  bool get _changeColor {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: ((productsProvider.bannersData?.data?.length ?? 0) == 0)
          ? PrimaryAppBar(
              action: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, search),
                  icon: Icon(
                    TURKIICONS.search,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          : null,
      body: productsProvider.foodsIsLoading
          ? const SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : productsProvider.foodsRetry
              ? Retry(
                  padding: const EdgeInsets.only(top: 60),
                  onPressed: () {
                    productsProvider.getFoodsPageData(widget.id);
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                  onRefresh: () async {
                    await productsProvider.getFoodsPageData(widget.id,
                        isLoading: false);
                  },
                  child: CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        if ((productsProvider.bannersData?.data?.length ?? 0) >
                            0)
                          FoodAppBar(
                            changeColor: _changeColor,
                            bannersData: productsProvider.bannersData!,
                          ),
                        if (productsProvider.discoverData != null)
                          DiscoverSection(
                            discoverList: productsProvider.discoverData!,
                          ),
                        SliverToBoxAdapter(
                            child: ProductsListSection(
                                products: productsProvider.productsList)),
                      ])),
    );
  }
}