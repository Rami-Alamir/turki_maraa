import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../provider/products_provider.dart';
import 'extra_tag.dart';

class WithoutExtra extends StatelessWidget {
  final Product product;
  WithoutExtra({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductsProvider>(context);
    return Visibility(
      visible: (product.data!.isLyh! &&
          product.data!.isKarashah! &&
          product.data!.isKwar3! &&
          product.data!.isRas!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
            child: Text(
              AppLocalizations.of(context)!.tr('without'),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: Wrap(
              children: [
                Visibility(
                  visible: product.data!.isLyh!,
                  child: Container(
                      child: ExtraTag(
                    selected: _productProvider.withoutTailFat,
                    onTap: () {
                      _productProvider.withoutTailFat =
                          !_productProvider.withoutTailFat;
                    },
                    title: AppLocalizations.of(context)!.tr('without_tail_fat'),
                  )),
                ),
                Visibility(
                  visible: product.data!.isKarashah!,
                  child: Container(
                      child: ExtraTag(
                    selected: _productProvider.withoutTripe,
                    onTap: () {
                      _productProvider.withoutTripe =
                          !_productProvider.withoutTripe;
                    },
                    title: AppLocalizations.of(context)!.tr('without_tripe'),
                  )),
                ),
                Visibility(
                  visible: product.data!.isKwar3!,
                  child: Container(
                      child: ExtraTag(
                    selected: _productProvider.withoutTrotters,
                    onTap: () {
                      _productProvider.withoutTrotters =
                          !_productProvider.withoutTrotters;
                    },
                    title: AppLocalizations.of(context)!.tr('without_trotters'),
                  )),
                ),
                Visibility(
                  visible: product.data!.isRas!,
                  child: Container(
                      child: ExtraTag(
                    selected: _productProvider.withoutHead,
                    onTap: () {
                      _productProvider.withoutHead =
                          !_productProvider.withoutHead;
                    },
                    title: AppLocalizations.of(context)!.tr('without_head'),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
