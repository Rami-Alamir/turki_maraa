import 'package:flutter/material.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';

class AddGiftCard extends StatefulWidget {
  @override
  _AddGiftCardState createState() => _AddGiftCardState();
}

class _AddGiftCardState extends State<AddGiftCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: "AddGiftCard",
      ),
    );
  }
}
