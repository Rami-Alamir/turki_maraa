import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/shared/product_card.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/products_provider.dart';

class ProductsList extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProductsList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: data['title'],
        back: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 4.0),
            child:
                Consumer<ProductsProvider>(builder: (_, productsProvider, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      for (int i = 0;
                          i <
                              ((productsProvider.productsList
                                      .data?[data['index']].products?.length) ??
                                  0);
                          i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ProductCard(
                            isLarge: true,
                            id: productsProvider.productsList
                                .data![data['index']].products![i].id!,
                            categoryId: productsProvider.productsList
                                .data![data['index']].products![i].categoryId!,
                            nameAr: productsProvider.productsList
                                .data![data['index']].products![i].nameAr!,
                            nameEn: productsProvider.productsList
                                .data![data['index']].products![i].nameEn!,
                            image: ((productsProvider
                                            .productsList
                                            .data![data['index']]
                                            .products![i]
                                            .productImages
                                            ?.length ??
                                        0) >
                                    0)
                                ? (productsProvider
                                    .productsList
                                    .data![data['index']]
                                    .products![i]
                                    .productImages!
                                    .first
                                    .imageUrl!)
                                : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                            price: productsProvider.productsList
                                .data![data['index']].products![i].price!,
                            salePrice: productsProvider.productsList
                                .data![data['index']].products![i].salePrice!,
                            tag: (productsProvider.productsList
                                .data![data['index']].products?[i].tags),
                          ),
                        )
                    ],
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
