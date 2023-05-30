import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favourite_card.dart';
import '../../../controllers/favourite_provider.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<FavouriteProvider>(context);
    return ListView(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: (favourite.favourite?.dataT?.data?.length) ?? 0,
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext ctxt, int index) {
              return FavouriteCard(
                index: index,
                data: favourite.favourite!.dataT!.data![index],
              );
            }),
      ],
    );
  }
}
