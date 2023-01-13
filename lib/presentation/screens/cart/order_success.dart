import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class OrderSuccess extends StatefulWidget {
  final int paymentType;

  const OrderSuccess({Key? key, required this.paymentType}) : super(key: key);
  @override
  OrderSuccessState createState() => OrderSuccessState();
}

class OrderSuccessState extends State<OrderSuccess> {
  @override
  void initState() {
    final OrdersProvider orders =
        Provider.of<OrdersProvider>(context, listen: false);
    orders.getOrdersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight! / 4, bottom: 30),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.green.withOpacity(1),
                          Colors.green.withOpacity(0.8),
                        ])),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 90,
                )),
            Text(
              AppLocalizations.of(context)!.tr('order_successful'),
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 40),
              child: SizedBox(
                width: 250,
                child: Text(
                  widget.paymentType != 1
                      ? AppLocalizations.of(context)!.tr(
                          "the_order_has_been_sent_and_the_payment_is_being_verified")
                      : AppLocalizations.of(context)!.tr('thank_order'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 14, height: 1.9),
                ),
              ),
            ),
            RoundedRectangleButton(
                padding: const EdgeInsets.only(top: 50),
                title: AppLocalizations.of(context)!.tr('continue_shopping'),
                onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
    );
  }
}
