import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/get_strings.dart';
import 'package:provider/provider.dart';
import 'invoice_row.dart';

class Invoice extends StatelessWidget {
  final double subtotal;
  final double discountVoucher;
  final double shipping;
  final double myCredit;
  final double total;
  final String currency;
  final String vat;

  const Invoice({
    required this.subtotal,
    required this.total,
    this.discountVoucher = 0,
    this.shipping = 0,
    this.myCredit = 0,
    this.currency = "",
    this.vat = "vat_sa",
  });

  @override
  Widget build(BuildContext context) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    String _currency = currency.length > 0
        ? currency
        : GetStrings().getCurrency(
            AppLocalizations.of(context)!.locale!.languageCode,
            _addressProvider.isoCountryCode);
    String _vat = vat.length > 0
        ? vat
        : _addressProvider.isoCountryCode.toUpperCase() == "AE"
            ? "vat_ae"
            : 'vat_sa';
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              AppLocalizations.of(context)!.tr('order_summary'),
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),
            ),
          ),
          InvoiceRow(
              fontColor: Theme.of(context).textTheme.headline4!.color!,
              title: 'order_total',
              value: '${formatDecimal(subtotal)} $_currency'),
          InvoiceRow(
              fontColor: Theme.of(context).textTheme.headline4!.color!,
              title: 'delivery_fees',
              value: '$shipping $_currency'),
          InvoiceRow(
            title: 'discount',
            value: '-${formatDecimal(discountVoucher)} $_currency',
            visible: discountVoucher > 0,
            fontColor: Colors.green,
          ),
          InvoiceRow(
            title: 'credit',
            value: '-${formatDecimal(myCredit)} $_currency',
            visible: myCredit > 0,
            fontColor: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 2,
              color: Theme.of(context)
                  .textTheme
                  .headline4!
                  .color!
                  .withOpacity(0.35),
              indent: 7,
              endIndent: 7,
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0, 0, 0),
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
                    '${formatDecimal(total)} $_currency',
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
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.tr(_vat),
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 10,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  formatDecimal(double value) {
    return value.toStringAsFixed(2);
  }
}
