import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'phone_number_textfield.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/app_colors.dart';

class PhoneNumber extends StatelessWidget {
  final String isoCountryCode;
  final bool isWhite;
  const PhoneNumber(
      {Key? key, required this.isoCountryCode, this.isWhite = false})
      : super(key: key);

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
            PhoneNumberTextfield(
                isWhite: isWhite,
                isoCountryCode: isoCountryCode,
                formKey: auth.formKey!,
                controller: auth.phoneController,
                enabled: !isWhite),
            Divider(
              color:
                  isWhite ? AppColors.white : AppColors.grey.withOpacity(0.5),
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
