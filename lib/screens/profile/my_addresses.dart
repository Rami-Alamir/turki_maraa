import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/profile/address_card.dart';
import 'package:new_turki/widgets/shared/add_new_address.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  Widget build(BuildContext context) {
    final _addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr("my_addresses"), back: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            MainCard(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AddNewAddress(),
                  ],
                )),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: (_addressProvider.userAddress?.data?.length ?? 0),
                itemBuilder: (BuildContext ctxt, int index) {
                  return AddressCard(
                      index: index,
                      userAddress: _addressProvider.userAddress!.data![index]);
                })
          ],
        ),
      ),
    );
  }
}
