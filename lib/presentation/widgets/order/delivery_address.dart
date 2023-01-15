import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/shared/main_card.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_address'),
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
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(Icons.location_pin,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                width: SizeConfig.screenWidth! * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                      ordersProvider.order.data!.selectedAddress!.address!,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.8)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
