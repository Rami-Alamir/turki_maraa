import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/profile/gift_card.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/rectangle_text_field.dart';

//This feature will be active soon
class AddGiftCard extends StatelessWidget {
  const AddGiftCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('add_a_gift_card'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            const GiftCard(),
            RectangleTextField(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              // controller: _auth.giftController,
              controller: TextEditingController(),
              textInputType: TextInputType.number,
              onChanged: (value) {
                //  _auth.checkGiftCard(context);
              },
              maxLength: 16,
              hint: AppLocalizations.of(context)!
                  .tr('enter_the_card_number_here'),
            ),
          ],
        ),
      ),
    );
  }
}
