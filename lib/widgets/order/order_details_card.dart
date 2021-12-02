import 'package:flutter/material.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/invoice.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';

import 'order_details_row.dart';

class OrderDetailsCard extends StatefulWidget {
  @override
  _OrderDetailsCardState createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final _order = Provider.of<OrdersProvider>(context);
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
                "${AppLocalizations.of(context)!.tr('items')} (${_order.order.orderItems.length})",
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
                itemCount: _order.order.orderItems.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return OrderDetailsRow(
                    item: _order.order.orderItems[index],
                  );
                }),
            Invoice(
              total: 100,
              subtotal: 500,
              shipping: 0,
              discountVoucher: 100,
              myCredit: 300,
            )
          ],
        ),
      ),
    ]);
  }
}
