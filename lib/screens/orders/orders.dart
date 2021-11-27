import 'package:flutter/material.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/screens/other/no_orders.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/order/order_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  final bool? back;

  const Orders({required this.back});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    final _orders = Provider.of<OrdersProvider>(context, listen: false);
    _orders.getOrdersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('orders'),
        back: widget.back!,
      ),
      body: _orders.ordersList.isEmpty
          ? _orders.isLoading
              ? SpinkitIndicator()
              : _orders.retry
                  ? Retry(
                      onPressed: () {
                        _orders.reInitOrdersList();
                      },
                    )
                  : NoOrders()
          : RefreshIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onRefresh: () async {
                await _orders.reInitOrdersList();
              },
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _orders.ordersList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return OrderCard(order: _orders.ordersList[index]);
                  })),
    );
  }
}
