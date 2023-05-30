import 'package:flutter/material.dart';
import '../shared/product_card.dart';
import '../../../../models/product.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class SimilarProductsSection extends StatelessWidget {
  final Product products;
  final int productId;
  final int subCategoryId;
  const SimilarProductsSection(
      {Key? key,
      required this.products,
      required this.productId,
      required this.subCategoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemCount: products.data!.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Visibility(
                      visible: products.data![index].products!.length > 1 &&
                          subCategoryId ==
                              products
                                  .data![index].products?.first.subCategoryId,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 10, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .tr('You_may_also_like'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 5, 15, 0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ScrollPhysics(),
                                  itemCount:
                                      products.data![index].products!.length,
                                  itemBuilder: (BuildContext ctxt, int index2) {
                                    return Visibility(
                                      visible: productId !=
                                          products.data![index]
                                              .products![index2].id!,
                                      child: ProductCard(
                                        tag: products.data![index]
                                            .products![index2].tags,
                                        id: products
                                            .data![index].products![index2].id!,
                                        categoryId: products.data![index]
                                            .products![index2].categoryId!,
                                        image: products
                                            .data![index]
                                            .products![index2]
                                            .productImages!
                                            .first
                                            .imageUrl!,
                                        salePrice: products.data![index]
                                            .products![index2].salePrice!,
                                        price: products.data![index]
                                            .products![index2].price!,
                                        nameEn: products.data![index]
                                            .products![index2].nameEn!,
                                        nameAr: products.data![index]
                                            .products![index2].nameAr!,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
