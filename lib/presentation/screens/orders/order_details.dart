import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turki_dabayh/core/utilities/enum/request_status.dart';
import '../../widgets/order/delivery_address.dart';
import '../../widgets/order/order_details_card.dart';
import '../../widgets/order/order_details_header.dart';
import '../../widgets/order/order_note.dart';
import '../../widgets/order/payment_method.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/shared/not_auth.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';


class OrderDetails extends StatefulWidget {
  final String? id;

  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    final OrdersProvider orders =
        Provider.of<OrdersProvider>(context, listen: false);
    orders.getOrderData(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('order_details')),
      body: !orders.isAuth
          ? const NotAuth()
          : orders.requestStatus2 == RequestStatus.isLoading
              ? const SpinkitIndicator()
              :  orders.requestStatus2 == RequestStatus.error
                  ? Retry(
                      onPressed: () {
                        orders.getOrderData(widget.id!,notify: true);
                      },
                    )
                  : RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onRefresh: () async {
                        await orders.getOrderData(widget.id!);
                      },
                      child: ListView(
                        children: [
                          OrderDetailsHeader(
                            order: orders.order.data!,
                          ),
                          DeliveryAddress(
                              address:
                                  orders.order.data!.selectedAddress!.address!),
                          PaymentMethod(
                              paymentTypeId: orders.order.data!.paymentTypeId!),
                          OrderNote(note: orders.order.data!.comment ?? ""),
                          OrderDetailsCard(
                            order: orders.order,
                            count: orders.orderItems(),
                          )
                        ],
                      )),
    );
  }
}
