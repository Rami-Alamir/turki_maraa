import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'invoice_row.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/utilities/get_strings.dart';

class Invoice extends StatelessWidget {
  final double subtotal;
  final double discountVoucher;
  final double shipping;
  final double myCredit;
  final double total;
  final String currency;
  final String vat;

  const Invoice({
    Key? key,
    required this.subtotal,
    required this.total,
    this.discountVoucher = 0,
    this.shipping = 0,
    this.myCredit = 0,
    this.currency = "",
    this.vat = "vat_sa",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currencyStr = currency.isNotEmpty
        ? currency
        : sl<GetStrings>().getCurrency(
            AppLocalizations.of(context)!.locale!.languageCode,
            locationProvider.isoCountryCode!);
    String vatStr = vat.isNotEmpty
        ? vat
        : locationProvider.isoCountryCode!.toUpperCase() == "AE"
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
              value:
                  '${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(subtotal)} $currencyStr'),
          InvoiceRow(
              fontColor: Theme.of(context).textTheme.headline4!.color!,
              title: 'delivery_fees',
              value:
                  '${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(shipping)} $currencyStr'),
          InvoiceRow(
            title: 'discount',
            value:
                '-${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(discountVoucher)} $currencyStr',
            visible: discountVoucher > 0,
            fontColor: Colors.green,
          ),
          InvoiceRow(
            title: 'credit2',
            value:
                '-${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(myCredit)} $currencyStr',
            visible: myCredit > 0,
            fontColor: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(
              height: 2,
              color: Theme.of(context)
                  .textTheme
                  .headline4!
                  .color!
                  .withOpacity(0.35),
              indent: 2,
              endIndent: 2,
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0, 0, 0),
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
                    '${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(total)} $currencyStr',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.tr(vatStr),
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
}
