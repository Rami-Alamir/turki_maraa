import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'country_picker.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/country_utils.dart';
import '../../../core/utilities/dialog_helper.dart';
import '../../../models/country.dart';

class PhoneNumberTextfield extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final bool enabled;
  final bool isWhite;
  final TextEditingController? phoneController;
  const PhoneNumberTextfield({
    super.key,
    required this.formKey,
    required this.enabled,
    required this.isWhite,
    this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (_, auth, _) {
        final Country country = CountryUtils.getCountryByCountryCode(
          auth.isoCountryCode!,
        );
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Form(
            key: formKey,
            child: TextFormField(
              enabled: enabled,
              autofocus: false,
              onTap: () {
                auth.logoVisibility = false;
              },
              onChanged: (value) {
                auth.userPhoneControllerValue = value;
              },
              cursorColor: Theme.of(context).colorScheme.primary,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontSize: 16, height: 1.8),
              validator: (text) {
                if (text!.length < 9) {
                  return AppLocalizations.of(
                    context,
                  )!.tr("please_enter_a_valid_mobile_number");
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                  10,
                  20,
                  10,
                  10,
                ),
                hintText: ' 51 234 5678',
                hintStyle: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(fontSize: 16),
                prefixIcon: GestureDetector(
                  onTap: () =>
                      sl<DialogHelper>().show(context, CountryPicker()),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 80,
                      minWidth: 60,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8),
                          child: Text(
                            country.flag,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        Text(
                          country.dialCode,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontSize: 14,
                                color: isWhite
                                    ? AppColors.white
                                    : Theme.of(
                                        context,
                                      ).textTheme.displayMedium!.color,
                                fontWeight: FontWeight.bold,
                                height: 1.9,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                counterText: "",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
