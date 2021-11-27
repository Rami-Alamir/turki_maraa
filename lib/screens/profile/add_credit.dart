import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';

class AddCredit extends StatefulWidget {
  const AddCredit({Key? key}) : super(key: key);

  @override
  _AddCreditState createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('add_credit'),
      ),
      body: ListView(
        children: [
          MainCard(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      AppLocalizations.of(context)!.tr('amount'),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
