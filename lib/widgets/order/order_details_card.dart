import 'package:flutter/material.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/invoice.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';

import 'order_details_row.dart';

class OrderDetailsCard extends StatefulWidget {
  final int index;

  const OrderDetailsCard({required this.index});
  @override
  _OrderDetailsCardState createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
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
                "${AppLocalizations.of(context)!.tr('items')} (${_orders.ordersData?.data?[widget.index].products?.length ?? 0})",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount:
                    (_orders.ordersData?.data?[widget.index].products?.length ??
                        0),
                itemBuilder: (BuildContext ctxt, int index) {
                  return OrderDetailsRow(
                    item: _orders
                        .ordersData!.data![widget.index].products![index],
                  );
                }),
            Invoice(
              total: double.parse(_orders
                  .ordersData!.data![widget.index].totalAmountAfterDiscount!),
              subtotal: double.parse(
                  _orders.ordersData!.data![widget.index].orderTotal!),
              shipping: double.parse(
                  _orders.ordersData!.data![widget.index].deliveryFee!),
              discountVoucher: 0.0,
              myCredit: double.parse(
                  _orders.ordersData!.data![widget.index].walletAmountUsed!),
            )
          ],
        ),
      ),
    ]);
  }
}
