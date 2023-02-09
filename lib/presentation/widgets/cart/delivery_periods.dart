import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'delivery_periods_item.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class DeliveryPeriods extends StatelessWidget {
  const DeliveryPeriods({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_time'),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
          height: 85,
          child: ListView.builder(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: cart.deliveryPeriod.data!.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 10),
                  child: DeliveryPeriodsItem(
                    title: AppLocalizations.of(context)!.locale!.languageCode ==
                            'ar'
                        ? cart.deliveryPeriod.data![index].nameAr!
                        : cart.deliveryPeriod.data![index].nameEn!,
                    selectedValue: index,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
