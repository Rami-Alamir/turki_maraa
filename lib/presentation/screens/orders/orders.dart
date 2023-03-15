import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/order/order_card.dart';
import '../../widgets/shared/empty_list.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';

class Orders extends StatelessWidget {
  final bool? back;

  const Orders({Key? key, this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of<OrdersProvider>(context);

    return Scaffold(
        appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('orders'),
          back: back!,
        ),
        body: PageBuilder(
          requestStatus: orders.requestStatus,
          isAuth: orders.isAuth,
          onError: () {
            orders.getOrdersList(notify: true);
          },
          child: RefreshIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            onRefresh: () async {
              await orders.getOrdersList();
            },
            child: (orders.ordersData?.data?.length ?? 0) > 0
                ? ListView(
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: (orders.ordersData?.data?.length ?? 0),
                          itemBuilder: (BuildContext ctxt, int index) {
                            return OrderCard(
                                order: (orders.ordersData!.data![index]));
                          }),
                    ],
                  )
                : const EmptyList(
                    image: FixedAssets.noOrders, title: 'order_now'),
          ),
        ));
  }
}
