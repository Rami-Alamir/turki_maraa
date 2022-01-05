import 'package:flutter/material.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/invoice.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';
import 'promo_code.dart';

class CartBottomSheet extends StatefulWidget {
  final double total;

  const CartBottomSheet({required this.total});
  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification dSNotification) {
        _isExpanded = dSNotification.minExtent == dSNotification.extent;
        print(dSNotification.minExtent < dSNotification.extent);
        print(dSNotification.minExtent);
        print(dSNotification.extent);
        setState(() {});
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.75,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Theme.of(context).colorScheme.secondary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryVariant
                      .withOpacity(0.4),
                  spreadRadius: 8,
                  blurRadius: 12,
                  offset: Offset(0, 5), // changes position of shadow
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                !_isExpanded
                    ? Column(
                        children: [
                          PromoCode(
                              promoCodeController: _cart.promoCodeController),
                          Invoice(
                              myCredit: _cart.useCredit ? 0.0 : 0.0,
                              total: widget.total -
                                  (_cart.useCredit ? 100.6 : 0.0),
                              subtotal: widget.total,
                              shipping: widget.total),
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
                                    '${widget.total} ${AppLocalizations.of(context)!.tr('sr')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.tr('vat'),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    fontSize: 16,
                    onPressed: () {})
              ],
            ),
          );
        },
      ),
    );
  }
}
