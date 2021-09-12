import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

class PhoneNumber extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController keyController = TextEditingController();
  PhoneNumber({required this.phoneController});

  @override
  Widget build(BuildContext context) {
    keyController.text = '+966';
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
                  onChanged: print,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'SA',
                  favorite: ['+966', 'SA'],
                  countryFilter: ['SA', 'AE', 'BH', 'KW', 'QA'],
                  textStyle: TextStyle(color: Colors.black),
                  // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                _textField(context, SizeConfig.screenWidth! * 0.55,
                    phoneController, 'ادخل رقم جوالك هنا', true)
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

  Widget _textField(BuildContext context, double width,
      TextEditingController controller, String hint, bool enabled) {
    return SizedBox(
      width: width,
      child: TextField(
        enabled: enabled,
        autofocus: true,
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        keyboardType: TextInputType.phone,
        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          focusColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
