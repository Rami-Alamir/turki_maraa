import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

import '../../utilities/firebase_helper.dart';

class CategoryCard extends StatelessWidget {
  final int categoryId;
  final String title;
  final String titelAr;
  final String titelEn;
  final String image;
  final Color color;
  final Color color2;
  final double scaleFactor;

  const CategoryCard({
    required this.title,
    required this.scaleFactor,
    required this.image,
    required this.color,
    required this.color2,
    required this.categoryId,
    required this.titelAr,
    required this.titelEn,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/ProductsHome", arguments: categoryId);
        FirebaseHelper.analytics!
            .logEvent(name: 'Categories', parameters: {"name": titelAr});
        FirebaseHelper.analytics!.logEvent(name: titelEn, parameters: null);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
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
              child: AutoSizeText(
                title,
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline3!.color),
                textScaleFactor: 1.47,
                maxFontSize: 20,
                minFontSize: 12,
                maxLines: title.length < 12 ? 1 : 2,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: (133 * scaleFactor) - 31,
                maxWidth: (SizeConfig.screenWidth! / 2) - 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0)),
                    child: Container(
                      height: (133 * scaleFactor) - 31,
                      child: Image.network(
                        image,
                        fit: BoxFit.contain,
                        width: (SizeConfig.screenWidth! / 2) - 18,
                      ),
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
