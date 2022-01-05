import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/product_description.dart';
import 'package:new_turki/widgets/home/product_header.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:new_turki/widgets/home/extras_list.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

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
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.initExtras();
    _homeProvider.getProductData(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);
    final _authProvider = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: _homeProvider.productIsLoading
          ? SpinkitIndicator(
              padding: EdgeInsets.only(top: 60),
            )
          : _homeProvider.productIsRetry
              ? Retry(
                  padding: EdgeInsets.only(top: 60),
                  onPressed: () {
                    _homeProvider.setProductIsLoading = true;
                    _homeProvider.getProductData(widget.id.toString());
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onRefresh: () async {
                    _homeProvider.getProductData(widget.id.toString());
                  },
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ProductHeader(
                        imgList: _homeProvider.productData.data!.images!,
                      ),
                      ProductDescription(
                          product: _homeProvider.productData,
                          price: _homeProvider.getProductPrice()),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(
                      //       15.0, 10.0, 0.0, 10.0),
                      //   child: Text(
                      //     AppLocalizations.of(context)!.tr('product_options'),
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline4
                      //         ?.copyWith(
                      //             fontSize: 16, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      ExtrasList(
                        title: AppLocalizations.of(context)!.tr('size'),
                        tags: _homeProvider.productData.data!.sizes!,
                        onTap: (value) {
                          _homeProvider.setSelectedSize = value;
                        },
                        selected: _homeProvider.selectedSize,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ExtrasList(
                          title: AppLocalizations.of(context)!.tr('chopping'),
                          tags: _homeProvider.productData.data!.chopping!,
                          selected: _homeProvider.selectedChopping,
                          onTap: (value) {
                            _homeProvider.setSelectedChopping = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ExtrasList(
                          title: AppLocalizations.of(context)!.tr('packaging'),
                          tags: _homeProvider.productData.data!.packaging!,
                          selected: _homeProvider.selectedPackaging,
                          onTap: (value) {
                            _homeProvider.setSelectedPackaging = value;
                          },
                        ),
                      ),
                      if (_homeProvider.productData.data!.isShalwata!)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ExtrasList(
                            title: AppLocalizations.of(context)!.tr('shalwata'),
                            tags: [
                              _homeProvider.productData.data!.shalwata!,
                            ],
                            selected: _homeProvider.selectedShalwata,
                            onTap: (value) {
                              print(value);
                              _homeProvider.setSelectedShalwata = value;
                            },
                          ),
                        ),
                      SizedBox(height: 60)
                    ],
                  ),
                ),
      bottomSheet: !_homeProvider.productIsLoading &&
              !_homeProvider.productIsRetry
          ? Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        RoundedRectangleButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              _count = _count == 1 ? _count : _count - 1;
                            });
                          },
                          width: 40,
                          height: 40,
                          fontSize: 22,
                          title: '-',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$_count",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: 16),
                          ),
                        ),
                        RoundedRectangleButton(
                          onPressed: () {
                            setState(() {
                              _count += 1;
                            });
                          },
                          padding: EdgeInsets.all(0),
                          width: 40,
                          height: 40,
                          fontSize: 22,
                          title: '+',
                        ),
                        RoundedRectangleButton(
                          onPressed: () {
                            _cartProvider.addToCart(
                              context: context,
                              authorization:
                                  "Bearer " + _authProvider.accessToken,
                              quantity: '$_count',
                              sizeId:
                                  "${_homeProvider.selectedSize > -1 ? (_homeProvider.productData.data?.sizes?[_homeProvider.selectedSize].id!.toString()) : ""}",
                              preparationId:
                                  "${_homeProvider.selectedPackaging > -1 ? (_homeProvider.productData.data?.packaging?[_homeProvider.selectedPackaging].id!.toString()) : ""}",
                              cutId:
                                  "${_homeProvider.selectedChopping > -1 ? (_homeProvider.productData.data?.chopping?[_homeProvider.selectedChopping].id!.toString()) : ""}",
                              isShalwata:
                                  "${_homeProvider.selectedShalwata > -1 ? (_homeProvider.productData.data?.shalwata!.id!.toString()) : ""}",
                              productId:
                                  '${_homeProvider.productData.data!.id}',
                            );
                          },
                          padding: EdgeInsets.all(0),
                          width: SizeConfig.screenWidth! - 150,
                          height: 40,
                          fontSize: 15,
                          title:
                              AppLocalizations.of(context)!.tr('add_to_cart'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
