import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';

import '../rounded_rectangle_button.dart';

class FavouriteCard extends StatelessWidget {
  final String image;
  final String title;

  final double price;

  const FavouriteCard(
      {required this.image, required this.title, required this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails()),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  image,
                  width: SizeConfig.screenWidth! / 3.85,
                  height: SizeConfig.screenWidth! / 3.85,
                  fit: BoxFit.cover,
                )),
            Container(
              height: SizeConfig.screenWidth! / 3.85,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth! -
                        80 -
                        SizeConfig.screenWidth! / 3.85,
                    child: Text(title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    width: SizeConfig.screenWidth! -
                        60 -
                        SizeConfig.screenWidth! / 3.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'حذف',
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                        ),
                        Text(
                          '$price ريال ',
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontSize: 12,
                                    color: Color.fromRGBO(132, 15, 15, 1),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
