import 'package:flutter/material.dart';
import 'order_details_row.dart';
import '../../shared/invoice.dart';
import '../../shared/main_card.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/get_strings.dart';
import '../../../../core/utilities/calculate_helper.dart';

import '../../../../models/order.dart';

class OrderDetailsCard extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        (order.data!.order!.refNo!.substring(0, 2)));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Text(
          AppLocalizations.of(context)!.tr('order_details'),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      MainCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 20, bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)!.tr('items')} (${sl<CalculateHelper>().orderItems(order.data?.products)})",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: order.data?.products?.length ?? 0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return OrderDetailsRow(
                    item: order.data!.products![index],
                    currency: currency,
                  );
                }),
            Invoice(
              total: double.parse(order.data!.order!.totalAmountAfterDiscount!),
              subtotal: double.parse(order.data!.order!.orderSubtotal!),
              shipping: double.parse(order.data!.order!.deliveryFee!),
              discountVoucher: double.parse(order.data!.order!.totalAmount!) -
                  double.parse(order.data!.order!.totalAmountAfterDiscount!) -
                  double.parse(order.data!.order!.walletAmountUsed!),
              myCredit: double.parse(order.data!.order!.walletAmountUsed!),
              currency: currency,
              vat: (order.data!.order!.refNo!.substring(0, 2)) == "AE"
                  ? "vat_ae"
                  : "vat_sa",
            )
          ],
        ),
      ),
    ]);
  }
}
