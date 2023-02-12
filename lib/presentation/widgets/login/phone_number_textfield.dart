import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utilities/app_localizations.dart';

class PhoneNumberTextfield extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final double width;
  final TextEditingController controller;
  final String hint;
  final bool enabled;

  const PhoneNumberTextfield(
      {Key? key,
      required this.formKey,
      required this.width,
      required this.controller,
      required this.hint,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Form(
        key: formKey,
        child: TextFormField(
          enabled: enabled,
          autofocus: false,
          onTap: () {
            final Auth auth = Provider.of<Auth>(context, listen: false);
            auth.logoVisibility = false;
          },
          cursorColor: Theme.of(context).primaryColor,
          controller: controller,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              height: 1.8),
          validator: (text) {
            if (text!.length < 9) {
              return AppLocalizations.of(context)!
                  .tr("please_enter_a_valid_mobile_number");
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.black),
            counterText: "",
            contentPadding: EdgeInsets.zero,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
