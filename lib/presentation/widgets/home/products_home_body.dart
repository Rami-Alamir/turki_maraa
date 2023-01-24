import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/products_list_section.dart';
import '../../../controllers/products_provider.dart';
import 'discover_section.dart';
import 'food_appbar.dart';

class ProductsHomeBody extends StatelessWidget {
  final int id;
  final ScrollController scrollController;
  final bool changeColor;
  const ProductsHomeBody(
      {Key? key,
      required this.scrollController,
      required this.changeColor,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);

    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).backgroundColor,
      onRefresh: () async {
        await productsProvider.getFoodsPageData(id, isLoading: false);
      },
      child: CustomScrollView(controller: scrollController, slivers: <Widget>[
        if ((productsProvider.bannersData?.data?.length ?? 0) > 0)
          FoodAppBar(
            changeColor: changeColor,
            bannersData: productsProvider.bannersData!,
          ),
        if (productsProvider.discoverData != null) const DiscoverSection(),
        SliverToBoxAdapter(
            child:
                ProductsListSection(products: productsProvider.productsList)),
      ]),
    );
  }
}
