import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';

class NotAvailable extends StatelessWidget {
  const NotAvailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).backgroundColor == Colors.black
        ? const Color.fromRGBO(255, 175, 164, 1)
        : Colors.red;
    return Container(
      margin: const EdgeInsets.only(right: 10.0, top: 15, left: 10),
      constraints: const BoxConstraints(minHeight: 56),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber, color: color),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  AppLocalizations.of(context)!
                      .tr('This_product_is_currently_out_of_stock'),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12, color: color)),
            ),
          ],
        ),
      ),
    );
  }
}
