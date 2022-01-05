import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/widgets/order/no_orders.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/order/order_card.dart';
import 'package:new_turki/widgets/shared/not_auth.dart';
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
    final _auth = Provider.of<Auth>(context, listen: false);
    _orders.getOrdersList(_auth.accessToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    final _auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('orders'),
        back: widget.back!,
      ),
      body: !_auth.isAuth
          ? NotAuth()
          : _orders.isLoading
              ? SpinkitIndicator()
              : _orders.retry
                  ? Retry(
                      onPressed: () {
                        _orders.setIsLoading = true;
                        _orders.getOrdersList(_auth.accessToken);
                      },
                    )
                  : (_orders.ordersData?.data?.length ?? 0) > 0
                      ? RefreshIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          onRefresh: () async {
                            await _orders.getOrdersList(_auth.accessToken);
                          },
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:
                                  (_orders.ordersData?.data?.length ?? 0),
                              itemBuilder: (BuildContext ctxt, int index) {
                                return OrderCard(
                                    index: index,
                                    order: (_orders.ordersData!.data![index]));
                              }))
                      : NoOrders(),
    );
  }
}
