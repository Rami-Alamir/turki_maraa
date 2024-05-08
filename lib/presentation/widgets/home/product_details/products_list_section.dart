import 'package:flutter/material.dart';
import 'products_section.dart';
import '../../../../models/product.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class ProductsListSection extends StatelessWidget {
  final Product products;

  const ProductsListSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');

    return Container(
      constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight!,
          maxWidth: SizeConfig.screenWidth!),
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
                  return products.data![index].products!.isNotEmpty
                      ? ProductsSection(
                          title: isAr
                              ? products.data![index].typeAr!
                              : products.data![index].typeEn!,
                          products: products.data![index],
                          index: index)
                      : const SizedBox.shrink();
                }),
          ),
        ],
      ),
    );
  }
}
