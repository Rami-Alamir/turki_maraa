import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/widgets/order/delivery_address.dart';
import 'package:new_turki/widgets/order/order_details_card.dart';
import 'package:new_turki/widgets/order/payment_method.dart';
import 'package:new_turki/widgets/shared/not_auth.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';
import '../../widgets/order/order_details_header.dart';
import '../../widgets/order/order_note.dart';

class OrderDetails extends StatefulWidget {
  final String? id;

  const OrderDetails({required this.id});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    final _orders = Provider.of<OrdersProvider>(context, listen: false);
    _orders.getOrderData(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context);
    final _auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('order_details')),
      body: !_auth.isAuth
          ? NotAuth()
          : _orders.isLoading2
              ? SpinkitIndicator()
              : _orders.retry2
                  ? Retry(
                      onPressed: () {
                        _orders.setIsLoading2 = true;
                        _orders.getOrderData(widget.id!);
                      },
                    )
                  : RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onRefresh: () async {
                        await _orders.getOrderData(widget.id!);
                      },
                      child: ListView(
                        children: [
                          OrderDetailsHeader(
                            order: _orders.order.data!,
                          ),
                          DeliveryAddress(
                              address: _orders
                                  .order.data!.selectedAddress!.address!),
                          PaymentMethod(
                              paymentTypeId:
                                  _orders.order.data!.paymentTypeId!),
                          OrderNote(note: _orders.order.data!.comment!),
                          OrderDetailsCard(
                            order: _orders.order,
                            count: _orders.orderItems(),
                          )
                        ],
                      )),
    );
  }
}
