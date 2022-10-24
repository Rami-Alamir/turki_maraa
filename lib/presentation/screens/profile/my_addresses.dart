import 'package:flutter/material.dart';
import '../../../controllers/address_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/profile/address_card.dart';
import '../../widgets/shared/add_new_address.dart';
import '../../widgets/shared/main_card.dart';
import '../../widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

class MyAddresses extends StatelessWidget {
  const MyAddresses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr("my_addresses"), back: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            MainCard(
                padding: const EdgeInsets.all(5),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AddNewAddress(),
                  ],
                )),
            ListView.builder(
                padding: const EdgeInsets.only(bottom: 95),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: (addressProvider.userAddress?.data?.length ?? 0),
                itemBuilder: (BuildContext ctxt, int index) {
                  return AddressCard(
                      index: index,
                      userAddress: addressProvider.userAddress!.data![index]);
                }),
          ],
        ),
      ),
    );
  }
}
