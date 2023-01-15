import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/shared/main_card.dart';

class OrderNote extends StatelessWidget {
  const OrderNote({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    final String note = ordersProvider.order.data?.comment ?? " ";
    return Visibility(
      visible: note.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              AppLocalizations.of(context)!.tr('note'),
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 12),
            ),
          ),
          MainCard(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! * 0.8,
                    child: Text(note,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
