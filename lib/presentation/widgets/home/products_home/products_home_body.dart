import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'discover_section.dart';
import 'food_appbar.dart';
import '../product_details/products_list_section.dart';
import '../../../../controllers/products_provider.dart';

class ProductsHomeBody extends StatelessWidget {
  final int id;
  final ScrollController scrollController;
  final bool changeColor;
  const ProductsHomeBody(
      {super.key,
      required this.scrollController,
      required this.changeColor,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (_,productsProvider,__) {
        return RefreshIndicator(
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
    );
  }
}
