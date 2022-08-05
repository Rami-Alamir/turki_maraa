import 'package:flutter/material.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';

class UseCredit extends StatelessWidget {
  final String credit;

  const UseCredit({required this.credit});
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Visibility(
      visible: double.parse(credit) > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 15, left: 10),
            child: Container(
              constraints: BoxConstraints(minHeight: 56),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _cartProvider.useCredit,
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          checkColor: Colors.white, // color of tick Mark
                          activeColor:
                              Theme.of(context).textTheme.headline1!.color!,
                          onChanged: (bool? value) {
                            _cartProvider.usMyCredit = value!;
                          },
                        ), //Checkbox
                        Text(
                          '${AppLocalizations.of(context)!.tr('use_my_credit')} ($credit ${AppLocalizations.of(context)!.tr('sr')})',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
