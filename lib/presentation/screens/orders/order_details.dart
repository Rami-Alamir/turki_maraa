import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/order/order_details/delivery_address.dart';
import '../../widgets/order/order_details/order_details_card.dart';
import '../../widgets/order/order_details/order_details_header.dart';
import '../../widgets/order/order_details/order_note.dart';
import '../../widgets/order/order_details/payment_method.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/orders_provider.dart';
import '../../../models/order.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/enum/request_status.dart';

class OrderDetails extends StatefulWidget {
  final String id;

  const OrderDetails({super.key, required this.id});

  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  OrderModel? _order;
  RequestStatus _requestStatus = RequestStatus.isLoading;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      (OrderModel?, RequestStatus) record = await context
          .read<OrdersProvider>()
          .getOrderData(widget.id);
      _order = record.$1;
      _requestStatus = record.$2;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('order_details'),
      ),
      body: Consumer<OrdersProvider>(
        builder: (_, ordersProvider, _) {
          return PageBuilder(
            requestStatus: _requestStatus,
            onError: () async {
              (OrderModel?, RequestStatus) record = await context
                  .read<OrdersProvider>()
                  .getOrderData(widget.id);
              _order = record.$1;
              _requestStatus = record.$2;
            },
            isAuth: ordersProvider.isAuth,
            child: RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              onRefresh: () async {
                (OrderModel?, RequestStatus) record = await context
                    .read<OrdersProvider>()
                    .getOrderData(widget.id);
                _order = record.$1;
                _requestStatus = record.$2;
              },
              child: ListView(
                children: [
                  if (_order != null) ...[
                    OrderDetailsHeader(order: _order!.data!),
                    if ((_order?.data?.order?.selectedAddress?.address ?? "")
                        .isNotEmpty)
                      DeliveryAddress(
                        address:
                            _order?.data?.order?.selectedAddress?.address ?? "",
                      ),
                    PaymentMethod(
                      paymentTypeId: _order!.data!.order!.paymentTypeId!,
                    ),
                    if ((_order?.data?.order?.comment ?? "").isNotEmpty)
                      OrderNote(note: (_order?.data?.order?.comment ?? "")),
                    OrderDetailsCard(order: _order!),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
