import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

import '../../utilities/firebase_helper.dart';

class CategoryCardG1 extends StatelessWidget {
  final int categoryId;
  final String title;
  final String image;
  final Color color;
  final Color color2;
  final String titleAr;
  final String titleEn;
  const CategoryCardG1({
    required this.title,
    required this.titleAr,
    required this.titleEn,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [
                color,
                color2,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, right: 20, left: 20, bottom: 0),
                child: Container(
                  width: SizeConfig.screenWidth! - 280,
                  child: AutoSizeText(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline3!.color),
                    maxFontSize: 18,
                    minFontSize: 8,
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 45, 15, 15),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: Container(
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: 300,
                      width: 190,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
