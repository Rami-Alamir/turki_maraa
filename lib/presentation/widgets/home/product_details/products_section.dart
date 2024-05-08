import 'package:flutter/material.dart';
import '../shared/product_card.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../models/product.dart';

class ProductsSection extends StatelessWidget {
  final String title;
  final Data products;
  final int? index;
  const ProductsSection(
      {super.key, required this.products, this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  Visibility(
                    visible: index != null,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, productsList,
                              arguments: {"title": title, "index": index}),
                          child: Text(
                              AppLocalizations.of(context)!.tr('view_all'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 10,
                                  )),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Theme.of(context).textTheme.titleSmall!.color,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: products.products!.length,
                itemBuilder: (BuildContext ctxt, int index2) {
                  return ProductCard(
                    tag: products.products![index2].tags,
                    id: products.products![index2].id!,
                    categoryId: products.products![index2].categoryId!,
                    image: products
                        .products![index2].productImages!.first.imageUrl!,
                    salePrice: products.products![index2].salePrice!,
                    price: products.products![index2].price!,
                    nameEn: products.products![index2].nameEn!,
                    nameAr: products.products![index2].nameAr!,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
