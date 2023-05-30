import 'package:flutter/material.dart';
import 'phone_number_textfield.dart';

class PhoneNumber extends StatelessWidget {
  final bool isWhite;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? phoneController;

  const PhoneNumber(
      {Key? key, this.isWhite = false, this.formKey, this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhoneNumberTextfield(
                phoneController: phoneController,
                isWhite: isWhite,
                formKey: formKey,
                enabled: !isWhite),
            Divider(
              color: Theme.of(context).colorScheme.outline,
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
