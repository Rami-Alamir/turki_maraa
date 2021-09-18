import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/screens/home/home_list.dart';
import 'package:new_turki/screens/home/home_list2.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';

class DiscoverCard extends StatelessWidget {
  final Item item;

  const DiscoverCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 90,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeList2(item: item)),
          );
        },
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              width: 165,
              height: 90,
              child: SizedBox(
                height: 90,
                width: 165,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      '${item.image?.trim()}',
                      width: 165,
                      height: 90,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Container(
              height: 90,
              width: 165,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Container(
                  width: 140.0,
                  height: 22,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      item.title!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
