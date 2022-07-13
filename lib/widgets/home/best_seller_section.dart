import 'package:flutter/material.dart';
import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/product_card.dart';
import '../../models/products.dart';

class BestSellerSection extends StatelessWidget {
  final BestSeller products;

  const BestSellerSection({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeConfig.screenWidth,
          child: Visibility(
            visible: (products.data?.length ?? 0) > 0,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.tr('most_wanted'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemCount: products.data!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ProductCard(
                              product: ProductData(
                            id: products.data![index].id,
                            nameAr: products.data![index].nameAr,
                            nameEn: products.data![index].nameEn,
                            categoryId: -1,
                            productImages: <ProductImages>[
                              ProductImages(
                                  imageUrl: products
                                      .data![index].images!.first.imageUrl)
                            ],
                            price: products.data![index].price,
                            salePrice: products.data![index].salePrice,
                          ));
                        }),
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
