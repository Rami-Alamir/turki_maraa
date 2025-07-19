import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turki_maraa_app/controllers/app_provider.dart';
import 'package:turki_maraa_app/controllers/cart_provider.dart';
import '../../../../models/extra.dart';
import 'product_information.dart';
import 'product_description.dart';
import 'product_header.dart';
import 'extras_list.dart';
import 'shalwata_extra.dart';
import 'similar_products_section.dart';
import 'without_extra.dart';
import 'not_available.dart';
import '../../../../controllers/product_provider.dart';
import '../../../../core/utilities/app_localizations.dart';

class ProductDetailsList extends StatefulWidget {
  final int index;
  final int similarIndex;
  const ProductDetailsList({
    super.key,
    required this.index,
    required this.similarIndex,
  });

  @override
  State<ProductDetailsList> createState() => _ProductDetailsListState();
}

class _ProductDetailsListState extends State<ProductDetailsList> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProductHeader(
          imgList: productProvider.productData[widget.index].data!.images!,
        ),
        Visibility(
          visible:
              !productProvider.productData[widget.index].data!.isActive! ||
              !productProvider.productData[widget.index].data!.isAvailable!,
          child: const NotAvailable(),
        ),
        ProductDescription(
          isFavourite: productProvider.isFavourite,
          product: productProvider.productData[widget.index],
          salePrice: productProvider.getProductSalePrice(widget.index),
          price: productProvider.getProductPrice(widget.index),
        ),
        ProductInformation(
          product: productProvider.productData[widget.index],
          weight: productProvider.getProductWeight(widget.index),
        ),
        if (context.read<AppProvider>().adhaConfig?.categoryId ==
            productProvider
                .productData[widget.index]
                .data!
                .subCategory!
                .categoryId)
          ExtrasList(
            title: AppLocalizations.of(
              context,
            )!.tr('choose_the_day_of_sacrifice'),
            tags: [
              if (productProvider.productData[widget.index].data!.id != 1260 &&
                  (context.read<CartProvider>().checkCity()))
                ExtraData(nameAr: 'اليوم الأول', nameEn: 'First day'),
              if (productProvider.productData[widget.index].data!.id != 1260)
                ExtraData(nameAr: 'اليوم الثاني', nameEn: 'Second day'),
              ExtraData(nameAr: 'اليوم الثالث', nameEn: 'Third day'),
              ExtraData(nameAr: 'اليوم الرابع', nameEn: 'Fourth day'),
            ],
            onTap: (value) {
              setState(() {
                productProvider.selectedDay = value;
                if (!(context
                        .read<AppProvider>()
                        .adhaConfig
                        ?.cutStatus?[productProvider.selectedDay] ??
                    true)) {
                  productProvider.setSelectedChopping = -1;
                }
              });
            },
            selected: productProvider.selectedDay,
          ),
        Visibility(
          visible:
              productProvider.productData[widget.index].data!.sizes!.length > 1,
          child: ExtrasList(
            title: AppLocalizations.of(context)!.tr('size'),
            tags: productProvider.productData[widget.index].data!.sizes!,
            onTap: (value) {
              productProvider.setSelectedSize = value;
            },
            selected: productProvider.selectedSize,
          ),
        ),
        ExtrasList(
          title: AppLocalizations.of(context)!.tr('chopping'),
          tags: productProvider.productData[widget.index].data!.chopping!,
          selected: productProvider.selectedChopping,
          onTap: (value) {
            productProvider.setSelectedChopping = value;
          },
          isVisible: productProvider.selectedDay != -1
              ? (context
                        .read<AppProvider>()
                        .adhaConfig
                        ?.cutStatus?[productProvider
                                .productData[widget.index]
                                .data!
                                .id !=
                            1260
                        ? productProvider.selectedDay
                        : productProvider.selectedDay + 2] ??
                    true)
              : true,
        ),
        ExtrasList(
          title: AppLocalizations.of(context)!.tr('packaging'),
          tags: productProvider.productData[widget.index].data!.packaging!,
          selected: productProvider.selectedPackaging,
          onTap: (value) {
            productProvider.setSelectedPackaging = value;
          },
        ),
        if (productProvider.productData[widget.index].data!.isShalwata!)
          ShalwataExtra(
            selected: productProvider.selectedShalwata,
            onTap: (value) {
              productProvider.setSelectedShalwata = value;
            },
          ),
        Visibility(
          visible: productProvider.productData[widget.index].data!.isActive!,
          child: WithoutExtra(
            product: productProvider.productData[widget.index],
          ),
        ),
        Visibility(
          visible:
              productProvider.similarProductsList.length > widget.similarIndex
              ? productProvider
                        .similarProductsList[widget.similarIndex]
                        .data
                        ?.isNotEmpty ??
                    false
              : false,
          child: SimilarProductsSection(
            products: productProvider.similarProductsList[widget.similarIndex],
            subCategoryId: productProvider
                .productData[widget.similarIndex]
                .data!
                .subCategory!
                .id!,
            productId:
                productProvider.productData[widget.similarIndex].data!.id!,
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
