import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class OrderStatus extends StatelessWidget {
  final bool status;

  const OrderStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context, listen: false);
    final _auth = Provider.of<Auth>(context, listen: false);
    _orders.getOrdersList(_auth.accessToken);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight! / 4, bottom: 30),
              child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            status ? Colors.green : Colors.red,
                            status
                                ? Colors.green.withOpacity(0.8)
                                : Colors.red.withOpacity(0.8),
                          ])),
                  child: Icon(
                    status ? Icons.check : Icons.clear,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 90,
                  )),
            ),
            Text(
              AppLocalizations.of(context)!
                  .tr(status ? "order_successful" : "payment_failed"),
              style: Theme.of(context).textTheme.headline1!,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 40),
              child: SizedBox(
                width: 250,
                child: Text(
                  AppLocalizations.of(context)!.tr(
                      status ? "thank_order" : "payment_failed_description"),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 14, height: 1.9),
                ),
              ),
            ),
            RoundedRectangleButton(
                padding: EdgeInsets.only(top: 50),
                title: AppLocalizations.of(context)!.tr('continue_shopping'),
                onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
    );
  }
}
