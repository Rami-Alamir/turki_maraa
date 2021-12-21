import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty_cart.png',
                width: 333, height: 333),
            Text(
              AppLocalizations.of(context)!.tr('empty_cart'),
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
