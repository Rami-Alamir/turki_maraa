import 'package:flutter/material.dart';
import '../shared/product_card.dart';
import '../../../../models/best_seller.dart';
import '../../../../core/utilities/size_config.dart';

class ProductsSection2 extends StatelessWidget {
  final BestSeller? products;
  final String title;

  const ProductsSection2({super.key, this.products, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((products!.data!.length).toString().isNotEmpty)
          SizedBox(
            width: SizeConfig.screenWidth,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, bottom: 5, left: 20, top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0, 5, 15.0, 0),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemCount: products!.data!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ProductCard(
                            id: products!.data![index].id!,
                            categoryId: products!.data![index].category!.id!,
                            price: products!.data![index].price!,
                            salePrice: products!.data![index].salePrice!,
                            nameAr: products!.data![index].nameAr!,
                            nameEn: products!.data![index].nameEn!,
                            image: products!.data![index].images![0].imageUrl!,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
