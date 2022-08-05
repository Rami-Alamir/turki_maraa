import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import '../../utilities/firebase_helper.dart';

class CategoryCard extends StatelessWidget {
  final int categoryId;
  final String title;
  final String titleAr;
  final String titleEn;
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
    required this.titleAr,
    required this.titleEn,
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
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [
              color,
              color2,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: scaleFactor > 1.4 ? 38.0 : 10),
              child: Container(
                constraints: BoxConstraints(
                    minWidth: 70 + (title.length > 7 ? 0 : title.length * 6)),
                width: SizeConfig.screenWidth! / 2 - 20,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 20, left: 20, bottom: 0),
                  child: AutoSizeText(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline3!.color),
                    maxFontSize: 16,
                    minFontSize: 8,
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: (133 * scaleFactor) - 42,
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
                        // child: Image.asset(
                        //   'assets/images/rr.png',
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
