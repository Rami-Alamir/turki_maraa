import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rounded_rectangle_button.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final LocationProvider locationProvider =
            Provider.of<LocationProvider>(context, listen: false);
        Navigator.of(context, rootNavigator: true).pushNamed(
            locationProvider.isHms ? hmsMap : gmsMap,
            arguments: -100);
      },
      splashColor: Colors.transparent,
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
