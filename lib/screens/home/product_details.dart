import 'package:flutter/material.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/product_description.dart';
import 'package:new_turki/widgets/home/product_details_footer.dart';
import 'package:new_turki/widgets/home/product_header.dart';
import 'package:new_turki/widgets/home/shalwata_extra.dart';
import 'package:new_turki/widgets/shared/retry.dart';
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
    final _favourite = Provider.of<FavouriteProvider>(context, listen: false);
    _homeProvider.setIsFavourite = false;
    _homeProvider.setIsFavourite = _favourite.isFavourite(widget.id);
    _homeProvider.initExtras();
    _homeProvider.getProductData(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);

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
                    await _homeProvider.getProductData(widget.id.toString());
                  },
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ProductHeader(
                        imgList: _homeProvider.productData.data!.images!,
                      ),
                      ProductDescription(
                          isFavourite: _homeProvider.isFavourite,
                          product: _homeProvider.productData,
                          salePrice: _homeProvider.getProductSalePrice(),
                          price: _homeProvider.getProductPrice()),
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
                          child: ShalwataExtra(
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
      bottomSheet:
          !_homeProvider.productIsLoading && !_homeProvider.productIsRetry
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
