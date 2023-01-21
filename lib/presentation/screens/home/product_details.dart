import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../controllers/product_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/home/circle_icon.dart';
import '../../widgets/home/not_available.dart';
import '../../widgets/home/product_details_footer.dart';
import '../../widgets/home/product_information.dart';
import '../../widgets/home/product_description.dart';
import '../../widgets/home/product_header.dart';
import '../../widgets/home/extras_list.dart';
import '../../widgets/home/shalwata_extra.dart';
import '../../widgets/home/similar_products_section.dart';
import '../../widgets/home/without_extra.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductDetails({Key? key, required this.data}) : super(key: key);
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  int _count = 1;
  int? _index;
  int? _similarIndex;

  @override
  void initState() {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    _index = productProvider.productData.length;
    _similarIndex = productProvider.similarProductsList.length;
    productProvider.initLoading(_index);
    productProvider.initExtras();
    productProvider.getProductData(widget.data['id'].toString(), _index!, true);
    productProvider.getSimilarProducts(
        _similarIndex!, widget.data['categoryId'].toString());
    final FavouriteProvider favourite =
        Provider.of<FavouriteProvider>(context, listen: false);
    productProvider.setIsFavourite = favourite.isFavourite(widget.data['id']);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductDetails oldWidget) {
    final FavouriteProvider favourite =
        Provider.of<FavouriteProvider>(context, listen: false);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    productProvider.setIsFavourite = favourite.isFavourite(widget.data['id']);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: productProvider.requestStatus[_index!] == RequestStatus.isLoading
          ? const SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : productProvider.requestStatus[_index!] == RequestStatus.error
              ? Retry(
                  padding: const EdgeInsets.only(top: 60),
                  onPressed: () {
                    productProvider.setProductIsLoading(_index!);
                    productProvider.getProductData(
                        widget.data['id'].toString(), _index!, false);
                  },
                )
              : Stack(
                  children: [
                    RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onRefresh: () async {
                        await productProvider.getProductData(
                            widget.data['id'].toString(), _index!, false);
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ProductHeader(
                            imgList: productProvider
                                .productData[_index!].data!.images!,
                          ),
                          Visibility(
                              visible: !productProvider
                                  .productData[_index!].data!.isActive!,
                              child: const NotAvailable()),
                          ProductDescription(
                              isFavourite: productProvider.isFavourite,
                              product: productProvider.productData[_index!],
                              salePrice:
                                  productProvider.getProductSalePrice(_index!),
                              price: productProvider.getProductPrice(_index!)),
                          ProductInformation(
                            product: productProvider.productData[_index!],
                            weight: productProvider.getProductWeight(_index!),
                          ),
                          Visibility(
                            visible: productProvider
                                    .productData[_index!].data!.sizes!.length >
                                1,
                            child: ExtrasList(
                              title: AppLocalizations.of(context)!.tr('size'),
                              tags: productProvider
                                  .productData[_index!].data!.sizes!,
                              onTap: (value) {
                                productProvider.setSelectedSize = value;
                              },
                              selected: productProvider.selectedSize,
                            ),
                          ),
                          ExtrasList(
                            title: AppLocalizations.of(context)!.tr('chopping'),
                            tags: productProvider
                                .productData[_index!].data!.chopping!,
                            selected: productProvider.selectedChopping,
                            onTap: (value) {
                              productProvider.setSelectedChopping = value;
                            },
                          ),
                          ExtrasList(
                            title:
                                AppLocalizations.of(context)!.tr('packaging'),
                            tags: productProvider
                                .productData[_index!].data!.packaging!,
                            selected: productProvider.selectedPackaging,
                            onTap: (value) {
                              productProvider.setSelectedPackaging = value;
                            },
                          ),
                          if (productProvider
                              .productData[_index!].data!.isShalwata!)
                            ShalwataExtra(
                              selected: productProvider.selectedShalwata,
                              onTap: (value) {
                                productProvider.setSelectedShalwata = value;
                              },
                            ),
                          Visibility(
                              visible: productProvider
                                  .productData[_index!].data!.isActive!,
                              child: WithoutExtra(
                                  product:
                                      productProvider.productData[_index!])),
                          Visibility(
                            visible:
                                productProvider.similarProductsList.length >
                                        _similarIndex!
                                    ? productProvider
                                            .similarProductsList[_similarIndex!]
                                            .data
                                            ?.isNotEmpty ??
                                        false
                                    : false,
                            child: SimilarProductsSection(
                              products: productProvider
                                  .similarProductsList[_similarIndex!],
                              subCategoryId: productProvider
                                  .productData[_similarIndex!]
                                  .data!
                                  .subCategory!
                                  .id!,
                              productId: productProvider
                                  .productData[_similarIndex!].data!.id!,
                            ),
                          ),
                          const SizedBox(height: 60)
                        ],
                      ),
                    ),
                    Positioned.directional(
                        start: 20,
                        top: 52,
                        textDirection: AppLocalizations.of(context)!.locale ==
                                const Locale('ar')
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: CircleIcon(
                            icon: Icons.arrow_back_ios,
                            onTap: () => Navigator.pop(context),
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0, 0, 0))),
                  ],
                ),
      bottomSheet:
          productProvider.requestStatus[_index!] == RequestStatus.completed &&
                  productProvider.productData[_index!].data!.isActive!
              ? ProductDetailsFooter(
                  count: _count,
                  index: _index!,
                  subtract: () {
                    setState(() {
                      _count = _count == 1 ? _count : _count - 1;
                    });
                  },
                  add: () {
                    setState(() {
                      _count += 1;
                    });
                  },
                )
              : Container(),
    );
  }
}
