import 'package:flutter/material.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/invoice.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'order_details_row.dart';

class OrderDetailsCard extends StatelessWidget {
  final Order order;

  const OrderDetailsCard({required this.order});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Text(
          AppLocalizations.of(context)!.tr('order_details'),
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      MainCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 20, bottom: 10),
              child: Text(
                "${AppLocalizations.of(context)!.tr('items')} (${order.data?[0].products?.length ?? 0})",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: order.data?[0].products?.length ?? 0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return OrderDetailsRow(
                    item: order.data![0].products![index],
                  );
                }),
            Invoice(
              total: double.parse(order.data![0].totalAmountAfterDiscount!),
              subtotal: double.parse(order.data![0].orderTotal!),
              shipping: double.parse(order.data![0].deliveryFee!),
              discountVoucher: double.parse(order.data![0].totalAmount!) -
                  double.parse(order.data![0].totalAmountAfterDiscount!),
              myCredit: double.parse(order.data![0].walletAmountUsed!),
            )
          ],
        ),
      ),
    ]);
  }
}
