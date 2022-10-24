import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/firebase_helper.dart';

class CategoryCard extends StatelessWidget {
  final int categoryId;
  final String title;
  final String image;
  final Color color;
  final Color color2;
  final String titleAr;
  final String titleEn;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.titleAr,
    required this.titleEn,
    required this.image,
    required this.color,
    required this.color2,
    required this.categoryId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, productsHome, arguments: categoryId);
        FirebaseHelper.analytics!
            .logEvent(name: 'Categories', parameters: {"name": titleAr});
        FirebaseHelper.analytics!.logEvent(name: titleEn, parameters: null);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topLeft,
                colors: [
                  color,
                  color2,
                ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, right: 20, left: 20, bottom: 0),
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        // color: const Color.fromRGBO(199, 154, 72, 1),
                      ),
                  maxFontSize: 18,
                  minFontSize: 8,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5, 5, 5),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    height: 120,
                    width: 120,
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
