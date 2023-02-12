import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'phone_number_textfield.dart';

class PhoneNumber extends StatelessWidget {
  final String isoCountryCode;

  const PhoneNumber({Key? key, required this.isoCountryCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CountryCodePicker(
                //   onChanged: (key) {
                //     auth.initCountyCode(key.toString());
                //   }, // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                //   initialSelection: isoCountryCode,
                //   favorite: const ['+966', 'SA'],
                //   countryFilter: const ['SA', 'AE'],
                //   textStyle: Theme.of(context).textTheme.headline4!.copyWith(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16),
                //   // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                //   flagDecoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(7),
                //   ),
                // ),
                PhoneNumberTextfield(
                    formKey: auth.formKey!,
                    width: SizeConfig.screenWidth! * 0.5,
                    controller: auth.phoneController,
                    hint: AppLocalizations.of(context)!
                        .tr('enter_your_mobile_number_here'),
                    enabled: true)
              ],
            ),
            Divider(
              color: AppColors.black.withOpacity(0.5),
              indent: 10,
              endIndent: 15,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
