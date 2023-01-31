import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/route_constants.dart';

class TabbyCheckoutPage extends StatefulWidget {
  final TabbySession session;

  const TabbyCheckoutPage({Key? key, required this.session}) : super(key: key);
  @override
  State<TabbyCheckoutPage> createState() => _TabbyCheckoutPageState();
}

class _TabbyCheckoutPageState extends State<TabbyCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: TabbyWebView(
            webUrl: widget.session.availableProducts.installments!.webUrl,
            onResult: (WebViewResult resultCode) async {
              final CartProvider cartProvider =
                  Provider.of<CartProvider>(context, listen: false);
              cartProvider.clearCart();
              final bool status = await cartProvider
                  .capturePayment(widget.session.paymentId.toString());
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, orderStatus,
                  arguments: resultCode.name == "authorized" ? status : false);
            },
          ),
        ),
      ),
    );
  }
}
