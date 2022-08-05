import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

import '../../utilities/firebase_helper.dart';

class CategoryCardG2 extends StatelessWidget {
  final int categoryId;
  final String title;
  final String image;
  final Color color;
  final Color color2;
  final double scaleFactor;
  final String titleAr;
  final String titleEn;
  const CategoryCardG2({
    required this.title,
    required this.titleAr,
    required this.titleEn,
    required this.scaleFactor,
    required this.image,
    required this.color,
    required this.color2,
    required this.categoryId,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/ProductsHome", arguments: categoryId);
        FirebaseHelper.analytics!
            .logEvent(name: 'Categories', parameters: {"name": titleAr});
        FirebaseHelper.analytics!.logEvent(name: titleEn, parameters: null);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            colors: [
              color,
              color2,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, right: 20, left: 20, bottom: 0),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: title.length < 15 ? 20 : 16),
                maxLines: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    height: (133 * scaleFactor) - 21,
                    width: (SizeConfig.screenWidth! / 2) - 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
