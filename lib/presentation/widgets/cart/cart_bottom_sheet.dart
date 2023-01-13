import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'min_value_indicator.dart';
import '../shared/invoice.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/service/firebase_helper.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({Key? key}) : super(key: key);

  @override
  CartBottomSheetState createState() => CartBottomSheetState();
}

class CartBottomSheetState extends State<CartBottomSheet> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
    final double total =
        cart.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!;
    final double min =
        double.parse(cart.cartData!.data!.minOrder!.first.minOrder ?? "60");
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = GetStrings().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification dSNotification) {
        _isExpanded = dSNotification.minExtent == dSNotification.extent;
        setState(() {});
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: min > total ? 0.35 : 0.25,
        maxChildSize: 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Theme.of(context).colorScheme.secondary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.4),
                  spreadRadius: 8,
                  blurRadius: 12,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 8.0, top: 16),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                !_isExpanded
                    ? Column(
                        children: [
                          Invoice(
                            myCredit: cart.cartData!.data!.invoicePreview!
                                .walletAmountUsed!,
                            total: cart.cartData!.data!.invoicePreview!
                                .totalAmountAfterDiscount!,
                            subtotal: cart
                                .cartData!.data!.invoicePreview!.orderSubtotal!,
                            shipping: cart
                                .cartData!.data!.invoicePreview!.deliveryFee!,
                            discountVoucher: cart.cartData!.data!
                                .invoicePreview!.discountApplied!,
                            vat: cart.isoCountryCode.toUpperCase() == "AE"
                                ? "vat_ae"
                                : 'vat_sa',
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.tr('total'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    '${FormatHelper().formatDecimalAndRemoveTrailingZeros(cart.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!)} $currency',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: min > total,
                            child: MinValueIndicator(
                                total: total, min: min, currency: currency),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.tr(
                                    locationProvider.isoCountryCode!
                                                .toUpperCase() ==
                                            "AE"
                                        ? "vat_ae"
                                        : 'vat_sa'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                RoundedRectangleButton(
                    title: AppLocalizations.of(context)!.tr('place_order'),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    fontSize: 16,
                    onPressed: total >= min
                        ? () async {
                            final AddressProvider addressProvider =
                                Provider.of<AddressProvider>(context,
                                    listen: false);
                            FirebaseHelper().pushAnalyticsEvent(
                                name: "purchase",
                                value: GetStrings()
                                    .getPaymentName(cart.selectedPayment));

                            int statusCode = await cart.placeOrder(
                                context: context,
                                currency: currency,
                                addressId: addressProvider.selectedAddress == -1
                                    ? -1
                                    : addressProvider
                                        .userAddress!
                                        .data![addressProvider.selectedAddress]
                                        .id!,
                                language: AppLocalizations.of(context)!
                                            .locale!
                                            .languageCode ==
                                        "en"
                                    ? Lang.en
                                    : Lang.ar);
                            if (!mounted) return;
                            await action(context, statusCode, cart);
                          }
                        : null)
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> action(
      BuildContext context, int statusCode, CartProvider cartProvider) async {
    if (statusCode != -1) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (statusCode) {
        case 0:
          ShowSnackBar().show(context, "unexpected_error");
          break;
        case 1:
          Navigator.of(context, rootNavigator: true)
              .pushNamed(orderSuccess, arguments: statusCode);
          break;
        case 2:
          Navigator.of(context, rootNavigator: true)
              .pushNamed(orderSuccess, arguments: statusCode);
          launchUrlString(cartProvider.arb.data!.invoiceURL!);
          break;
        case 4:
          Navigator.of(context, rootNavigator: true).pushNamed(
              tamaraCheckoutPage,
              arguments: cartProvider.tamara.data!.checkoutUrl!);
          break;
        case 7:
          if (!mounted) return;
          Navigator.of(context, rootNavigator: true)
              .pushNamed(tabbyCheckoutPage, arguments: cartProvider.session);
          break;
      }
    }
  }
}
