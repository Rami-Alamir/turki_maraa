import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'delivery_periods_item.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class DeliveryPeriods extends StatelessWidget {
  const DeliveryPeriods({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, cartProvider, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
            child: Text(
              AppLocalizations.of(context)!.tr('delivery_time'),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth,
            height: 85,
            child: ListView.builder(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: cartProvider.deliveryPeriod?.data?.length ?? 0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return DeliveryPeriodsItem(
                    title: AppLocalizations.of(context)!.locale!.languageCode ==
                            'ar'
                        ? (cartProvider.deliveryPeriod?.data![index].nameAr ??
                            "")
                        : (cartProvider.deliveryPeriod?.data![index].nameEn ??
                            ""),
                    selectedValue: index,
                    timeHhmm:
                        cartProvider.deliveryPeriod?.data?[index].timeHhmm ??
                            "",
                  );
                }),
          ),
        ],
      );
    });
  }
}
