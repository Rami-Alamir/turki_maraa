import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/route_constants.dart';

class TabbyCheckoutPage extends StatelessWidget {
  final TabbySession session;

  const TabbyCheckoutPage({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "session.availableProducts.installments!.webUrl ${session.availableProducts.installments!.webUrl}");
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: TabbyWebView(
            webUrl: session.availableProducts.installments!.webUrl,
            onResult: (WebViewResult resultCode) async {
              final CartProvider cartProvider =
                  Provider.of<CartProvider>(context, listen: false);
              cartProvider.clearCart();
              cartProvider.setSelectedPayment = 7;
              final bool status = await cartProvider
                  .capturePayment(session.paymentId.toString());
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, orderStatus,
                    arguments:
                        resultCode.name == "authorized" ? status : false);
              }
            },
          ),
        ),
      ),
    );
  }
}
