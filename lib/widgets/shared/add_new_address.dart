import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';
import 'rounded_rectangle_button.dart';

class AddNewAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final _auth = Provider.of<Auth>(context, listen: false);
        final _homeProvider = Provider.of<HomeProvider>(context, listen: false);

        if (!_auth.isAuth && _homeProvider.locationServiceStatus == 1)
          Navigator.of(context, rootNavigator: true).pushNamed('/Login');
        else
          Navigator.pushNamed(context, '/SelectAddress', arguments: -100);

        // final _auth = Provider.of<Auth>(context, listen: false);
        // if (_auth.isAuth) {
        //   _selected = false;
        //   Navigator.pushNamed(context, '/AddNewAddress');
        // } else
        //   Navigator.of(context, rootNavigator: true).pushNamed('/Login');
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            RoundedRectangleButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0),
              width: 22,
              height: 22,
              fontSize: 18,
              title: '+',
            ),
            Text(AppLocalizations.of(context)!.tr('add_new_delivery_address'),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
