import 'package:flutter/material.dart';
import 'package:tamara_sdk/tamara_sdk.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/route_constants.dart';

class TamaraCheckoutPage extends StatelessWidget {
  final String checkoutUrl;

  const TamaraCheckoutPage({Key? key, required this.checkoutUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: TamaraCheckout(
                checkoutUrl,
                KConstants.checkoutSuccess,
                KConstants.checkoutFailure,
                KConstants.checkoutCancel,
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
