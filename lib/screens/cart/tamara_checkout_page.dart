import 'package:flutter/material.dart';
import 'package:tamara_sdk/tamara_sdk.dart';

class TamaraCheckoutPage extends StatelessWidget {
  final String checkoutUrl;

  const TamaraCheckoutPage({required this.checkoutUrl});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Expanded(
                    child: TamaraCheckout(
                  checkoutUrl,
                  'https://almaraacompany.com/turki-api/api/v1/checkout/success',
                  'https://almaraacompany.com/turki-api/api/v1/checkout/failure',
                  "https://almaraacompany.com/turki-api/api/v1/checkout/cancel",
                  onPaymentSuccess: () {
                    print('onPaymentSuccess');
                    Navigator.pushReplacementNamed(context, '/OrderStatus',
                        arguments: true);
                  },
                  onPaymentFailed: () {
                    print('onPaymentFailed');
                    Navigator.pushReplacementNamed(context, '/OrderStatus',
                        arguments: false);
                  },
                  onPaymentCanceled: () {
                    print('onPaymentCanceled');
                    Navigator.pushReplacementNamed(context, '/OrderStatus',
                        arguments: false);
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
