import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/widgets/SearchBar.dart';
import 'package:new_turki/widgets/search_row.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
      body: ListView(
        padding: EdgeInsets.only(top: 60),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('بحث',
                    style: TextStyle(
                        color: Color.fromRGBO(132, 15, 15, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 30, left: 30, bottom: 20),
                  child: Text('X',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          SearchBar(
            controller: TextEditingController(),
            autoFocus: true,
            enabled: true,
            onTap: () {},
          ),
          SearchRow(
            item: itemList[0],
          ),
          SearchRow(
            item: itemList[1],
          ),
          SearchRow(
            item: itemList[2],
          ),
        ],
      ),
    );
  }
}
