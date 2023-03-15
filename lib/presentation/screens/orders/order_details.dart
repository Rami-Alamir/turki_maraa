import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/order/delivery_address.dart';
import '../../widgets/order/order_details_card.dart';
import '../../widgets/order/order_details_header.dart';
import '../../widgets/order/order_note.dart';
import '../../widgets/order/payment_method.dart';
import '../../widgets/shared/page_builder.dart';
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
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
        appBar: PrimaryAppBar(
            title: AppLocalizations.of(context)!.tr('order_details')),
        body: PageBuilder(
          requestStatus: ordersProvider.requestStatus2,
          onError: () {
            ordersProvider.getOrderData(widget.id!, notify: true);
          },
          isAuth: ordersProvider.isAuth,
          child: RefreshIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onRefresh: () async {
                await ordersProvider.getOrderData(widget.id!);
              },
              child: ListView(
                children: const [
                  OrderDetailsHeader(),
                  DeliveryAddress(),
                  PaymentMethod(),
                  OrderNote(),
                  OrderDetailsCard()
                ],
              )),
        ));
  }
}
