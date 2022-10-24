import 'package:flutter/material.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../controllers/products_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/home/circle_icon.dart';
import '../../widgets/home/not_available.dart';
import '../../widgets/home/product_details_footer.dart';
import '../../widgets/home/product_information.dart';
import '../../widgets/home/product_description.dart';
import '../../widgets/home/product_header.dart';
import '../../widgets/home/extras_list.dart';
import 'package:provider/provider.dart';
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
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _index = productsProvider.productData.length;
    _similarIndex = productsProvider.similarProductsList.length;
    productsProvider.initLoading(_index);
    productsProvider.initExtras();
    productsProvider.getProductData(
        widget.data['id'].toString(), _index!, true);
    final FavouriteProvider favourite =
        Provider.of<FavouriteProvider>(context, listen: false);
    productsProvider.getSimilarProducts(
        _similarIndex!, widget.data['categoryId'].toString());
    productsProvider.setIsFavourite = false;
    productsProvider.setIsFavourite = favourite.isFavourite(widget.data['id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: productsProvider.productIsLoading[_index!]
          ? const SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : productsProvider.productIsRetry[_index!]
              ? Retry(
                  padding: const EdgeInsets.only(top: 60),
                  onPressed: () {
                    productsProvider.setProductIsLoading(true, _index!);
                    productsProvider.getProductData(
                        widget.data['id'].toString(), _index!, false);
                  },
                )
              : Stack(
                  children: [
                    RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onRefresh: () async {
                        await productsProvider.getProductData(
                            widget.data['id'].toString(), _index!, false);
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ProductHeader(
                            imgList: productsProvider
                                .productData[_index!].data!.images!,
                          ),
                          Visibility(
                              visible: !productsProvider
                                  .productData[_index!].data!.isActive!,
                              child: const NotAvailable()),
                          ProductDescription(
                              isFavourite: productsProvider.isFavourite,
                              product: productsProvider.productData[_index!],
                              salePrice:
                                  productsProvider.getProductSalePrice(_index!),
                              price: productsProvider.getProductPrice(_index!)),
                          ProductInformation(
                            product: productsProvider.productData[_index!],
                            weight: productsProvider.getProductWeight(_index!),
                          ),
                          Visibility(
                            visible: productsProvider
                                    .productData[_index!].data!.sizes!.length >
                                1,
                            child: ExtrasList(
                              title: AppLocalizations.of(context)!.tr('size'),
                              tags: productsProvider
                                  .productData[_index!].data!.sizes!,
                              onTap: (value) {
                                productsProvider.setSelectedSize = value;
                              },
                              selected: productsProvider.selectedSize,
                            ),
                          ),
                          ExtrasList(
                            title: AppLocalizations.of(context)!.tr('chopping'),
                            tags: productsProvider
                                .productData[_index!].data!.chopping!,
                            selected: productsProvider.selectedChopping,
                            onTap: (value) {
                              productsProvider.setSelectedChopping = value;
                            },
                          ),
                          ExtrasList(
                            title:
                                AppLocalizations.of(context)!.tr('packaging'),
                            tags: productsProvider
                                .productData[_index!].data!.packaging!,
                            selected: productsProvider.selectedPackaging,
                            onTap: (value) {
                              productsProvider.setSelectedPackaging = value;
                            },
                          ),
                          if (productsProvider
                              .productData[_index!].data!.isShalwata!)
                            ShalwataExtra(
                              selected: productsProvider.selectedShalwata,
                              onTap: (value) {
                                productsProvider.setSelectedShalwata = value;
                              },
                            ),
                          Visibility(
                              visible: productsProvider
                                  .productData[_index!].data!.isActive!,
                              child: WithoutExtra(
                                  product:
                                      productsProvider.productData[_index!])),
                          Visibility(
                            visible:
                                productsProvider.similarProductsList.length >
                                        _similarIndex!
                                    ? productsProvider
                                            .similarProductsList[_similarIndex!]
                                            .data
                                            ?.isNotEmpty ??
                                        false
                                    : false,
                            child: SimilarProductsSection(
                              products: productsProvider
                                  .similarProductsList[_similarIndex!],
                              subCategoryId: productsProvider
                                  .productData[_similarIndex!]
                                  .data!
                                  .subCategory!
                                  .id!,
                              productId: productsProvider
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
      bottomSheet: !productsProvider.productIsLoading[_index!] &&
              !productsProvider.productIsRetry[_index!] &&
              productsProvider.productData[_index!].data!.isActive!
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
