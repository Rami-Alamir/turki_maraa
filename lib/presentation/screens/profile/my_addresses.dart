import 'package:flutter/material.dart';
import '../../widgets/profile/my_addresses/address_list.dart';
import '../../widgets/shared/add_new_address.dart';
import '../../widgets/shared/main_card.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../core/utilities/app_localizations.dart';

class MyAddresses extends StatelessWidget {
  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr("my_addresses"), back: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: const [
            MainCard(
                padding: EdgeInsets.all(5),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: AddNewAddress(),
                    ),
                  ],
                )),
            AddressList()
          ],
        ),
      ),
    );
  }
}
