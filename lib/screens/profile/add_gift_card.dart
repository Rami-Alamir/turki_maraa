import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/profile/gift_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:provider/provider.dart';

class AddGiftCard extends StatefulWidget {
  @override
  _AddGiftCardState createState() => _AddGiftCardState();
}

class _AddGiftCardState extends State<AddGiftCard> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    _auth.giftController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('add_a_gift_card'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            GiftCard(),
            RectangleTextField(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              controller: _auth.giftController,
              textInputType: TextInputType.number,
              onChanged: (value) {
                setState(() {});
                _auth.checkGiftCard(context);
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
