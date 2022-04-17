import 'package:flutter/material.dart';

import '../../utilities/firebase_helper.dart';

class CategoryCardG3 extends StatelessWidget {
  final int categoryId;
  final String title;
  final String titelAr;
  final String titelEn;
  final String image;
  final Color color;
  final Color color2;
  final double scaleFactor;

  const CategoryCardG3({
    required this.title,
    required this.titelAr,
    required this.titelEn,
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
            .logEvent(name: 'Categories', parameters: {"name": titelAr});
        FirebaseHelper.analytics!.logEvent(name: titelEn, parameters: null);
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
              padding: EdgeInsets.only(
                  top: scaleFactor == 0.8 ? 10 : 40.0,
                  right: 20,
                  left: 20,
                  bottom: 0),
              child: Text(title, style: Theme.of(context).textTheme.headline3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    height: scaleFactor == 0.8 ? 100 : 180,
                    width: scaleFactor == 0.8 ? 100 : 150,
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
