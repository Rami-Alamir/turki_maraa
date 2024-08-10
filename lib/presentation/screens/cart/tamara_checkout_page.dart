import 'package:flutter/material.dart';
import 'package:tamara_flutter_sdk/tamara_checkout.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/route_constants.dart';

class TamaraCheckoutPage extends StatelessWidget {
  final String checkoutUrl;

  const TamaraCheckoutPage({super.key, required this.checkoutUrl});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: TamaraCheckout(
                checkoutUrl,
                Constants.checkoutSuccess,
                Constants.checkoutFailure,
                Constants.checkoutCancel,
                onPaymentSuccess: () {
                  Navigator.pushReplacementNamed(context, orderStatus,
                      arguments: true);
                },
                onPaymentFailed: () {
                  Navigator.pushReplacementNamed(context, orderStatus,
                      arguments: false);
                },
                onPaymentCanceled: () {
                  Navigator.pushReplacementNamed(context, orderStatus,
                      arguments: false);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
