import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/order/order/order_card.dart';
import '../../widgets/shared/empty_list.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';

class Orders extends StatelessWidget {
  final bool? back;

  const Orders({super.key, this.back});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('orders'),
        back: back!,
      ),
      body: Consumer<OrdersProvider>(
        builder: (_, ordersProvider, _) {
          return PageBuilder(
            requestStatus: ordersProvider.requestStatus,
            isAuth: ordersProvider.isAuth,
            onError: () {
              ordersProvider.getOrdersList(notify: true);
            },
            child: RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              onRefresh: () async {
                await ordersProvider.getOrdersList();
              },
              child:
                  (ordersProvider.ordersData?.orderData?.data?.length ?? 0) > 0
                  ? ListView(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          addRepaintBoundaries: false,
                          physics: const ScrollPhysics(),
                          itemCount:
                              (ordersProvider
                                  .ordersData
                                  ?.orderData
                                  ?.data
                                  ?.length ??
                              0),
                          itemBuilder: (BuildContext ctxt, int index) {
                            return OrderCard(
                              order: (ordersProvider
                                  .ordersData!
                                  .orderData!
                                  .data![index]),
                            );
                          },
                        ),
                      ],
                    )
                  : const EmptyList(
                      image: FixedAssets.noOrders,
                      title: 'order_now',
                    ),
            ),
          );
        },
      ),
    );
  }
}
