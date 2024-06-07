import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turki_maraa_app/controllers/location_provider.dart';
import 'delivery_date_item.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/datetime_helper.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_date'),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Consumer<CartProvider>(builder: (_, cartProvider, __) {
          return SizedBox(
            width: SizeConfig.screenWidth,
            height: 122,
            child: ListView.builder(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: cartProvider.deliveryDataTime.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return sl<DateTimeHelper>().checkDateWithAdhia(
                          withAdhia:
                              context.read<LocationProvider>().isoCountryCode ==
                                  'SA',
                          notIncludedDates:
                              cartProvider.cartData!.data!.notIncludedDates!,
                          date: cartProvider.deliveryDataTime[index]
                              .toString()
                              .substring(0, 11),
                          timeHhmm:
                              cartProvider.deliveryPeriod.data?.last.timeHhmm ??
                                  "")
                      ? Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              3.0, 15, 10, 10),
                          child: DeliveryDateItem(
                              selectedValue: index,
                              title: cartProvider.deliveryDataTime[index].day
                                  .toString(),
                              subtitle: cartProvider
                                          .deliveryDataTime[index].day ==
                                      DateTime.now().day
                                  ? AppLocalizations.of(context)!.tr('today')
                                  : cartProvider.deliveryDataTime[index].day ==
                                          (DateTime.now().day + 1)
                                      ? AppLocalizations.of(context)!
                                          .tr('tomorrow')
                                      : DateFormat.E(
                                              AppLocalizations.of(context)!
                                                  .locale!
                                                  .languageCode)
                                          .format(cartProvider
                                              .deliveryDataTime[index]),
                              month: DateFormat.MMM(
                                      AppLocalizations.of(context)!
                                          .locale!
                                          .languageCode)
                                  .format(cartProvider.deliveryDataTime[index])),
                        )
                      : const SizedBox.shrink();
                }),
          );
        }),
      ],
    );
  }
}
