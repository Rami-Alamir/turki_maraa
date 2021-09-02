import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/widgets/discover_card.dart';
import 'package:new_turki/widgets/item_card.dart';
import 'package:new_turki/widgets/item_card2.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final List<Item> itemList = [
    Item(
        image:
            'https://cdn.salla.sa/dbPPv/ArNOJzNYSAzorMhVAEw2CVWu8Zid2tdadfIDhfr9.jpg',
        price: 1850,
        title: 'نعيمي'),
    Item(
        image:
            'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
        price: 350,
        title: 'ربع نعيمي'),
    Item(
        image:
            'https://cdn.salla.sa/qQVPQ/kYiTe60SHFEPRKewl9EamdLL9Edab7eYx0pKMEif.jpg',
        price: 100,
        title: 'نعيمي بالكيلو'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'نعيمي',
        back: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemCard2(
                  item: itemList[0],
                ),
                ItemCard2(
                  item: itemList[1],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemCard2(
                  item: itemList[2],
                ),
                ItemCard2(
                  item: itemList[0],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
