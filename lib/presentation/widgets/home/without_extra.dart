import '../../../controllers/products_provider.dart';
import '../../../models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utilities/app_localizations.dart';
import 'extra_tag.dart';

class WithoutExtra extends StatelessWidget {
  final ProductDetails product;
  const WithoutExtra({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productProvider =
        Provider.of<ProductsProvider>(context);
    return Visibility(
      visible: (product.data!.isLyh! ||
          product.data!.isKarashah! ||
          product.data!.isKwar3! ||
          product.data!.isRas!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
            child: Text(AppLocalizations.of(context)!.tr('without'),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
            child: Wrap(
              children: [
                Visibility(
                  visible: product.data!.isLyh!,
                  child: ExtraTag(
                    selected: productProvider.withoutTailFat,
                    onTap: () {
                      productProvider.withoutTailFat =
                          !productProvider.withoutTailFat;
                    },
                    title: AppLocalizations.of(context)!.tr('without_tail_fat'),
                  ),
                ),
                Visibility(
                  visible: product.data!.isKarashah!,
                  child: ExtraTag(
                    selected: productProvider.withoutTripe,
                    onTap: () {
                      productProvider.withoutTripe =
                          !productProvider.withoutTripe;
                    },
                    title: AppLocalizations.of(context)!.tr('without_tripe'),
                  ),
                ),
                Visibility(
                  visible: product.data!.isKwar3!,
                  child: ExtraTag(
                    selected: productProvider.withoutTrotters,
                    onTap: () {
                      productProvider.withoutTrotters =
                          !productProvider.withoutTrotters;
                    },
                    title: AppLocalizations.of(context)!.tr('without_trotters'),
                  ),
                ),
                Visibility(
                  visible: product.data!.isRas!,
                  child: ExtraTag(
                    selected: productProvider.withoutHead,
                    onTap: () {
                      productProvider.withoutHead =
                          !productProvider.withoutHead;
                    },
                    title: AppLocalizations.of(context)!.tr('without_head'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
