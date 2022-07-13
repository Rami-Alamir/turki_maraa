import 'package:flutter/material.dart';
import 'package:new_turki/provider/products_provider.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/product_card_large.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductsList({required this.data});

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: widget.data['title'],
        back: true,
      ),
      body: ListView(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: SizeConfig.screenWidth! - 360,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.8),
              itemCount: _productsProvider
                  .productsList.data![widget.data['index']].products!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      index % 2 == 0 ? 10 : 0, 0, index % 2 != 0 ? 10 : 00, 0),
                  child: ProductCardLarge(
                    categoryId: _productsProvider
                        .productsList
                        .data![widget.data['index']]
                        .products![index]
                        .categoryId!,
                    id: _productsProvider.productsList
                        .data![widget.data['index']].products![index].id!,
                    nameAr: _productsProvider.productsList
                        .data![widget.data['index']].products![index].nameAr!,
                    nameEn: _productsProvider.productsList
                        .data![widget.data['index']].products![index].nameEn!,
                    image: ((_productsProvider
                                    .productsList
                                    .data![widget.data['index']]
                                    .products![index]
                                    .productImages
                                    ?.length ??
                                0) >
                            0)
                        ? (_productsProvider
                            .productsList
                            .data![widget.data['index']]
                            .products![index]
                            .productImages!
                            .first
                            .imageUrl!)
                        : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                    price: _productsProvider.productsList
                        .data![widget.data['index']].products![index].price!,
                    salePrice: _productsProvider
                        .productsList
                        .data![widget.data['index']]
                        .products![index]
                        .salePrice!,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
