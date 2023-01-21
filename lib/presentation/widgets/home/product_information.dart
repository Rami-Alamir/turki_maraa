import 'package:flutter/material.dart';
import '../../../presentation/widgets/home/product_information_item.dart';
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
      child: Row(
        mainAxisAlignment:
            ((product.data!.calories!.isNotEmpty) & (weight.isNotEmpty))
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.start,
        children: [
          ProductInformationItem(
              title: 'weight',
              value: weight,
              description: "",
              size: 20,
              icon: TURKIICONS.weight_1),
          Visibility(
              visible: product.data!.calories!.isNotEmpty,
              child: const Padding(padding: EdgeInsets.all(10))),
          ProductInformationItem(
              title: 'calories',
              description: AppLocalizations.of(context)!.tr('per_grams'),
              value: product.data!.calories!,
              size: 40,
              icon: TURKIICONS.calories_1),
        ],
      ),
    );
  }
}
