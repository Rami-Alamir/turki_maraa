import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../shared/invoice.dart';
import '../shared/rounded_rectangle_button.dart';
import 'min_value_indicator.dart';

class CartBottomSheet extends StatefulWidget {
  final double total;
  final double min;

  const CartBottomSheet({Key? key, required this.total, required this.min})
      : super(key: key);

  @override
  CartBottomSheetState createState() => CartBottomSheetState();
}

class CartBottomSheetState extends State<CartBottomSheet> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
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
        initialChildSize: widget.min > widget.total ? 0.35 : 0.25,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 16),
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
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
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    '${formatDecimal(cart.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!)} $currency',
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
                            visible: widget.min > widget.total,
                            child: MinValueIndicator(
                                total: widget.total,
                                min: widget.min,
                                currency: currency),
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
                    onPressed: widget.total >= widget.min
                        ? () {
                            final AddressProvider addressProvider =
                                Provider.of<AddressProvider>(context,
                                    listen: false);
                            FirebaseHelper().pushAnalyticsEvent(
                                name: "purchase",
                                value: cart.selectedPayment == 4
                                    ? "Tamara"
                                    : cart.selectedPayment == 1
                                        ? "COD"
                                        : "Online payment");
                            cart.placeOrder(
                                context: context,
                                currency: currency,
                                addressId: addressProvider.selectedAddress == -1
                                    ? -1
                                    : addressProvider
                                        .userAddress!
                                        .data![addressProvider.selectedAddress]
                                        .id!);
                          }
                        : null)
              ],
            ),
          );
        },
      ),
    );
  }

  formatDecimal(double value) {
    return value.toStringAsFixed(2);
  }
}
