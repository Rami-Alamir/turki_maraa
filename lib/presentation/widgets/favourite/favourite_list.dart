import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favourite_card.dart';
import '../../../controllers/favourite_provider.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Consumer<FavouriteProvider>(
          builder: (_, favouriteProvider, _) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount:
                  (favouriteProvider.favourite?.dataT?.data?.length) ?? 0,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (BuildContext ctxt, int index) {
                return FavouriteCard(
                  index: index,
                  data: favouriteProvider.favourite!.dataT!.data![index],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
