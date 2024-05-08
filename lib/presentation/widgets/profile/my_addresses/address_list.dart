import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'address_card.dart';
import '../../../../controllers/address_provider.dart';

class AddressList extends StatelessWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (_, addressProvider, __) {
      return ListView.builder(
          padding: const EdgeInsets.only(bottom: 95),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          addRepaintBoundaries: false,
          itemCount: (addressProvider.userAddress?.data?.length ?? 0),
          itemBuilder: (BuildContext ctxt, int index) {
            return AddressCard(
                index: index,
                userAddress: addressProvider.userAddress!.data![index]);
          });
    });
  }
}
