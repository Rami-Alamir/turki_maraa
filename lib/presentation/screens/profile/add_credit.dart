import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/profile/credit_text_field.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';

//This feature will be active soon
class AddCredit extends StatelessWidget {
  const AddCredit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('add_credit'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CreditTextField(),
            RoundedRectangleButton(
                width: SizeConfig.screenWidth! - 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                title: AppLocalizations.of(context)!.tr('next'),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
