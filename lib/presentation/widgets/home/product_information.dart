import 'package:flutter/material.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../../models/product_details.dart';
import '../../../core/utilities/app_localizations.dart';

class ProductInformation extends StatelessWidget {
  final String weight;
  final ProductDetails product;

  const ProductInformation(
      {Key? key, required this.weight, required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: product.data!.calories!.isNotEmpty || weight.isNotEmpty,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
        child: Row(
          mainAxisAlignment:
              ((product.data!.calories!.isNotEmpty) & (weight.isNotEmpty))
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.start,
          children: [
            _item(
                context: context,
                title: 'weight',
                value: weight,
                description: "",
                size: 20,
                icon: TURKIICONS.weight_1),
            Visibility(
                visible: product.data!.calories!.isNotEmpty,
                child: const Padding(padding: EdgeInsets.all(10))),
            _item(
                context: context,
                title: 'calories',
                description: AppLocalizations.of(context)!.tr('per_grams'),
                value: product.data!.calories!,
                size: 40,
                icon: TURKIICONS.calories_1),
          ],
        ),
      ),
    );
  }

  Widget _item(
      {required BuildContext context,
      required String title,
      required IconData icon,
      required String value,
      required String description,
      required double size}) {
    return Visibility(
      visible: value.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: size,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.tr(title),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 5.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Text(
                        "$value ",
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
