import 'package:flutter/material.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/get_strings.dart';
import 'package:new_turki/widgets/shared/invoice.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';
import '../../utilities/firebase_helper.dart';
import 'min_value_Indicator.dart';

class CartBottomSheet extends StatefulWidget {
  final InvoicePreview invoicePreview;
  final double total;
  final double min;
  const CartBottomSheet({
    required this.invoicePreview,
    required this.total,
    required this.min,
  });

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    String _currency = GetStrings().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        _addressProvider.isoCountryCode);
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
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
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
                              const BorderRadius.all(const Radius.circular(20)),
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
                            myCredit: _cart.cartData!.data!.invoicePreview!
                                .walletAmountUsed!,
                            total: _cart.cartData!.data!.invoicePreview!
                                .totalAmountAfterDiscount!,
                            subtotal: _cart
                                .cartData!.data!.invoicePreview!.orderSubtotal!,
                            shipping: _cart
                                .cartData!.data!.invoicePreview!.deliveryFee!,
                            discountVoucher: _cart.cartData!.data!
                                .invoicePreview!.discountApplied!,
                            vat: _cart.isoCountryCode.toUpperCase() == "AE"
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
                                    '${formatDecimal(_cart.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!)} $_currency',
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
                                currency: _currency),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.tr(
                                    _addressProvider.isoCountryCode
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
                            FirebaseHelper.analytics!
                                .logEvent(name: 'Purchase', parameters: {
                              "paymentMethod": _cart.selectedPayment == 4
                                  ? "Tamara"
                                  : _cart.selectedPayment == 1
                                      ? "COD"
                                      : "Online payment"
                            });
                            _cart.placeOrder(
                                context: context,
                                currency: _currency,
                                addressId: _addressProvider.selectedAddress ==
                                        -1
                                    ? -1
                                    : _addressProvider
                                        .userAddress!
                                        .data![_addressProvider.selectedAddress]
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
