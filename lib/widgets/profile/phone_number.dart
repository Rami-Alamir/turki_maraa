import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

class PhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CountryCodePicker(
                  onChanged: (key) {
                    print(key);
                    _auth.initCountyCode(key.toString());
                  }, // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: _addressProvider.isoCountryCode,
                  favorite: ['+966', 'SA'],
                  countryFilter: ['SA', 'AE', 'BH', 'KW', 'QA', 'OM'],
                  textStyle: Theme.of(context).textTheme.headline4,
                  // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                _textField(
                    context,
                    _auth.formKey!,
                    SizeConfig.screenWidth! * 0.5,
                    _auth.phoneController,
                    AppLocalizations.of(context)!
                        .tr('enter_your_mobile_number_here'),
                    true)
              ],
            ),
            Divider(
              color: Colors.black.withOpacity(0.5),
              indent: 10,
              endIndent: 15,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _textField(
      BuildContext context,
      GlobalKey<FormState> formKey,
      double width,
      TextEditingController controller,
      String hint,
      bool enabled) {
    return SizedBox(
      width: width,
      child: Form(
        key: formKey,
        child: TextFormField(
          enabled: enabled,
          autofocus: true,
          cursorColor: Theme.of(context).primaryColor,
          controller: controller,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          validator: (text) {
            if (text!.length < 9) {
              return AppLocalizations.of(context)!
                  .tr("please_enter_a_valid_mobile_number");
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
