import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/product_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/home/product_information.dart';
import '../../widgets/home/product_description.dart';
import '../../widgets/home/product_header.dart';
import '../../widgets/home/extras_list.dart';
import '../../widgets/home/shalwata_extra.dart';
import '../../widgets/home/similar_products_section.dart';
import '../../widgets/home/without_extra.dart';
import '../../widgets/home/not_available.dart';

class ProductDetailsList extends StatelessWidget {
  final int index;
  final int similarIndex;
  const ProductDetailsList(
      {Key? key, required this.index, required this.similarIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProductHeader(
          imgList: productProvider.productData[index].data!.images!,
        ),
        Visibility(
            visible: !productProvider.productData[index].data!.isActive!,
            child: const NotAvailable()),
        ProductDescription(
            isFavourite: productProvider.isFavourite,
            product: productProvider.productData[index],
            salePrice: productProvider.getProductSalePrice(index),
            price: productProvider.getProductPrice(index)),
        ProductInformation(
          product: productProvider.productData[index],
          weight: productProvider.getProductWeight(index),
        ),
        Visibility(
          visible: productProvider.productData[index].data!.sizes!.length > 1,
          child: ExtrasList(
            title: AppLocalizations.of(context)!.tr('size'),
            tags: productProvider.productData[index].data!.sizes!,
            onTap: (value) {
              productProvider.setSelectedSize = value;
            },
            selected: productProvider.selectedSize,
          ),
        ),
        ExtrasList(
          title: AppLocalizations.of(context)!.tr('chopping'),
          tags: productProvider.productData[index].data!.chopping!,
          selected: productProvider.selectedChopping,
          onTap: (value) {
            productProvider.setSelectedChopping = value;
          },
        ),
        ExtrasList(
          title: AppLocalizations.of(context)!.tr('packaging'),
          tags: productProvider.productData[index].data!.packaging!,
          selected: productProvider.selectedPackaging,
          onTap: (value) {
            productProvider.setSelectedPackaging = value;
          },
        ),
        if (productProvider.productData[index].data!.isShalwata!)
          ShalwataExtra(
            selected: productProvider.selectedShalwata,
            onTap: (value) {
              productProvider.setSelectedShalwata = value;
            },
          ),
        Visibility(
            visible: productProvider.productData[index].data!.isActive!,
            child: WithoutExtra(product: productProvider.productData[index])),
        Visibility(
          visible: productProvider.similarProductsList.length > similarIndex
              ? productProvider
                      .similarProductsList[similarIndex].data?.isNotEmpty ??
                  false
              : false,
          child: SimilarProductsSection(
            products: productProvider.similarProductsList[similarIndex],
            subCategoryId: productProvider
                .productData[similarIndex].data!.subCategory!.id!,
            productId: productProvider.productData[similarIndex].data!.id!,
          ),
        ),
        const SizedBox(height: 60)
      ],
    );
  }
}
