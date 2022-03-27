import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset('assets/images/empty_cart.png',
                width: 220, height: 220),
          ),
          Text(
            AppLocalizations.of(context)!.tr('empty_cart'),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
