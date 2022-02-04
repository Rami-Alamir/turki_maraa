import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatefulWidget {
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  void initState() {
    final _orders = Provider.of<OrdersProvider>(context, listen: false);
    final _auth = Provider.of<Auth>(context, listen: false);
    if (_auth.isAuth) _orders.getOrdersList(_auth.accessToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 8),
              child: Image.network(
                  'https://sellcodes.com/assets/images/Purchase_Success.png',
                  width: 333,
                  height: 333),
            ),
            Text(
              AppLocalizations.of(context)!.tr('order_successful'),
              style: Theme.of(context).textTheme.headline1!,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 40),
              child: SizedBox(
                width: 250,
                child: Text(
                  AppLocalizations.of(context)!.tr('thank_order'),
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
