import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:new_turki/provider/products_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/circle_icon.dart';
import 'package:new_turki/widgets/home/product_description.dart';
import 'package:new_turki/widgets/home/product_details_footer.dart';
import 'package:new_turki/widgets/home/product_header.dart';
import 'package:new_turki/widgets/home/shalwata_extra.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/home/extras_list.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';
import '../../widgets/adha/extras_list_adha_days.dart';
import '../../widgets/home/not_available.dart';
import '../../widgets/home/without_extra.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  const ProductDetails({required this.id});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _count = 1;
  @override
  void initState() {
    final _productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final _favourite = Provider.of<FavouriteProvider>(context, listen: false);
    _productsProvider.setIsFavourite = false;
    _productsProvider.setIsFavourite = _favourite.isFavourite(widget.id);
    _productsProvider.initExtras();
    _productsProvider.getProductData(widget.id.toString(),
        _addressProvider.selectedLatLng, _addressProvider.isoCountryCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<ProductsProvider>(context);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _productsProvider.productIsLoading
          ? SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : _productsProvider.productIsRetry
              ? Retry(
                  padding: EdgeInsets.only(top: 60),
                  onPressed: () {
                    _productsProvider.setProductIsLoading = true;
                    _productsProvider.getProductData(
                        widget.id.toString(),
                        _addressProvider.selectedLatLng,
                        _addressProvider.isoCountryCode);
                  },
                )
              : Stack(
                  children: [
                    RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onRefresh: () async {
                        _productsProvider.getProductData(
                            widget.id.toString(),
                            _addressProvider.selectedLatLng,
                            _addressProvider.isoCountryCode);
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ProductHeader(
                            imgList:
                                _productsProvider.productData.data!.images!,
                          ),
                          Visibility(
                              visible: !_productsProvider
                                  .productData.data!.isActive!,
                              child: NotAvailable()),
                          ProductDescription(
                              isFavourite: _productsProvider.isFavourite,
                              product: _productsProvider.productData,
                              weight: _productsProvider.getProductWeight(),
                              salePrice:
                                  _productsProvider.getProductSalePrice(),
                              price: _productsProvider.getProductPrice()),
                          Visibility(
                            visible: _productsProvider.productData.data!
                                    .subCategory!.categoryId ==
                                34,
                            child: ExtrasListAdhaDays(
                              title: AppLocalizations.of(context)!
                                  .tr('choose_the_day_of_sacrifice'),
                              tags: _productsProvider.days,
                              onTap: (value) {
                                print("vvv$value");
                                _productsProvider.setSelectedDay = value;
                              },
                              selected: _productsProvider.selectedDay,
                            ),
                          ),
                          Visibility(
                            visible: _productsProvider
                                        .productData.data!.sizes!.length >
                                    1 &&
                                _productsProvider.productData.data!.isActive!,
                            child: ExtrasList(
                              title: AppLocalizations.of(context)!.tr('size'),
                              tags: _productsProvider.productData.data!.sizes!,
                              onTap: (value) {
                                print("vvv$value");
                                _productsProvider.setSelectedSize = value;
                              },
                              selected: _productsProvider.selectedSize,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Visibility(
                              visible:
                                  _productsProvider.productData.data!.isActive!,
                              child: ExtrasList(
                                rid: _productsProvider.selectedDay == 0 ? 5 : 0,
                                title: AppLocalizations.of(context)!
                                    .tr('chopping'),
                                tags: _productsProvider
                                    .productData.data!.chopping!,
                                selected: _productsProvider.selectedChopping,
                                onTap: (value) {
                                  _productsProvider.setSelectedChopping = value;
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                _productsProvider.productData.data!.isActive!,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ExtrasList(
                                rid:
                                    _productsProvider.selectedDay == 0 ? 11 : 0,
                                title: AppLocalizations.of(context)!
                                    .tr('packaging'),
                                tags: _productsProvider
                                    .productData.data!.packaging!,
                                selected: _productsProvider.selectedPackaging,
                                onTap: (value) {
                                  _productsProvider.setSelectedPackaging =
                                      value;
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _productsProvider
                                    .productData.data!.isShalwata! &&
                                _productsProvider.productData.data!.isActive!,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ShalwataExtra(
                                selected: _productsProvider.selectedShalwata,
                                onTap: (value) {
                                  print(value);
                                  _productsProvider.setSelectedShalwata = value;
                                },
                              ),
                            ),
                          ),
                          Visibility(
                              visible:
                                  _productsProvider.productData.data!.isActive!,
                              child: WithoutExtra(
                                  product: _productsProvider.productData)),
                          SizedBox(height: 60)
                        ],
                      ),
                    ),
                    Positioned.directional(
                        start: 20,
                        top: 52,
                        textDirection:
                            AppLocalizations.of(context)!.locale == Locale('ar')
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        child: CircleIcon(
                            icon: Icons.arrow_back_ios,
                            onTap: () => Navigator.pop(context),
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0, 0, 0))),
                  ],
                ),
      bottomSheet: !_productsProvider.productIsLoading &&
              !_productsProvider.productIsRetry &&
              _productsProvider.productData.data!.isActive!
          ? ProductDetailsFooter(
              count: _count,
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
