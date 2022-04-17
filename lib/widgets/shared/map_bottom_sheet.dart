import 'package:flutter/material.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';
import '../../provider/address_provider.dart';
import '../../provider/auth.dart';
import '../../utilities/app_localizations.dart';
import '../../utilities/size_config.dart';

class MapBottomSheet extends StatelessWidget {
  final int addressIndex;
  final int userAddressId;
  final String addressDescription;

  const MapBottomSheet(
      {required this.addressIndex,
      required this.userAddressId,
      required this.addressDescription});

  @override
  Widget build(BuildContext context) {
    final _addressProvider = Provider.of<AddressProvider>(context);
    final _auth = Provider.of<Auth>(context);
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
          ),
        ),
        constraints: BoxConstraints(maxHeight: 360),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.tr("delivery_address"),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      addressDescription,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.tr("address_name"),
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(height: 2),
                  ),
                ],
              ),
            ),
            RectangleTextField(
              customWidth: SizeConfig.screenWidth! * 0.9,
              hint: AppLocalizations.of(context)!.tr('address_name_hint'),
              maxLength: 40,
              controller: _addressProvider.addressNameController,
              padding: const EdgeInsets.only(
                  bottom: 20, right: 20, left: 20, top: 10),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Text(
                AppLocalizations.of(context)!.tr('additional_notes'),
                maxLines: 2,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            RectangleTextField(
              customWidth: SizeConfig.screenWidth! * 0.9,
              maxLength: 80,
              maxLines: 2,
              hint: AppLocalizations.of(context)!.tr('additional_notes'),
              controller: _addressProvider.descriptionController,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            Center(
              child: RoundedRectangleButton(
                title: AppLocalizations.of(context)!.tr('confirm'),
                fontSize: 16.0,
                width: SizeConfig.screenWidth! * 0.9,
                padding: const EdgeInsets.all(5),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (addressIndex == -100)
                    await _addressProvider.addNewAddress(
                        context, _auth.isAuth ? _auth.accessToken : "");
                  else
                    await _addressProvider.updateAddress(context,
                        _auth.isAuth ? _auth.accessToken : "", userAddressId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
