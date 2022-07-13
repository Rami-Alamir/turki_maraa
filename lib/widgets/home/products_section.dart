import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'product_card.dart';
import 'package:new_turki/models/products.dart';

class ProductsSection extends StatelessWidget {
  final Products? products;
  final int id;

  const ProductsSection({this.products, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeConfig.screenWidth,
          child: Visibility(
            visible: (products?.data?.length ?? 0) > 0,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .tr('similar_products'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    child: Container(
                      height: 220,
                      child: ListView.builder(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemCount: products?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  products?.data?[index].products?.length ?? 0,
                              itemBuilder: (BuildContext ctxt, int index2) {
                                return Visibility(
                                  visible: products!
                                          .data![index].products![index2].id !=
                                      id,
                                  child: ProductCard(
                                      product: ProductData(
                                    id: products!
                                        .data![index].products![index2].id,
                                    nameAr: products!
                                        .data![index].products![index2].nameAr,
                                    nameEn: products!
                                        .data![index].products![index2].nameEn,
                                    productImages: products!.data![index]
                                        .products![index2].productImages!,
                                    price: products!
                                        .data![index].products![index2].price,
                                    salePrice: products!.data![index]
                                        .products![index2].salePrice,
                                  )),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
