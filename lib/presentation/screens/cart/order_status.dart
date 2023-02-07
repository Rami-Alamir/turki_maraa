import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class OrderStatus extends StatefulWidget {
  final bool status;

  const OrderStatus({Key? key, required this.status}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  late bool status;
  late int paymentId;
  @override
  void initState() {
    status = widget.status;
    final OrdersProvider orders =
        Provider.of<OrdersProvider>(context, listen: false);
    orders.getOrdersList();
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    paymentId = cartProvider.selectedPayment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('payment $paymentId');
    return Scaffold(
      body: SizedBox(
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
                  AppLocalizations.of(context)!.tr(status
                      ? (paymentId == 2
                          ? "the_order_has_been_sent_and_the_payment_is_being_verified"
                          : "thank_order")
                      : paymentId == 7
                          ? "tabby_error"
                          : "payment_failed_description"),
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
