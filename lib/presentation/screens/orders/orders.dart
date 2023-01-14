import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../widgets/order/order_card.dart';
import '../../widgets/shared/empty_list.dart';
import '../../widgets/shared/not_auth.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';

class Orders extends StatelessWidget {
  final bool? back;

  const Orders({Key? key, this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of<OrdersProvider>(context);
    print("orders.requestStatus.name");
    print(orders.requestStatus.name);
    return Scaffold(
        appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('orders'),
          back: back!,
        ),
        body: orders.requestStatus== RequestStatus.isLoading
        ? const SpinkitIndicator()
            : !orders.isAuth
                ? const NotAuth()
                :orders.requestStatus== RequestStatus.error
                    ? Retry(
                        onPressed: () {
                          orders.getOrdersList(notify: true);
                        },
                      )
                    : RefreshIndicator(
                        color: Theme.of(context).primaryColor,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
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
                                      itemCount:
                                          (orders.ordersData?.data?.length ??
                                              0),
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return OrderCard(
                                            order: (orders
                                                .ordersData!.data![index]));
                                      }),
                                ],
                              )
                            : const EmptyList(
                                image: FixedAssets.noOrders,
                                title: 'order_now'),
                      ));
  }
}
