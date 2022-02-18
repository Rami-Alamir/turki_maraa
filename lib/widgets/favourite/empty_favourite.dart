import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class EmptyFavourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.screenHeight! / 7,
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('assets/images/wishlist.png',
                  width: 200, height: 0200),
            ),
            Text(
              AppLocalizations.of(context)!.tr('empty_favourite'),
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
