import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/size_config.dart';
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
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(Radius.circular(12)),
        //   gradient: LinearGradient(
        //       begin: Alignment.bottomLeft,
        //       end: Alignment.topLeft,
        //       colors: [
        //         color,
        //         color2,
        //       ]),
        // ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            image: AssetImage(Theme.of(context).backgroundColor == Colors.black
                ? FixedAssets.backgroundDark
                : FixedAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 10, 0),
              child: SizedBox(
                width: SizeConfig.screenWidth! - 190,
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 18, height: 1.5,
                        fontWeight: FontWeight.w500,
                        // color: const Color.fromRGBO(199, 154, 72, 1),
                      ),
                  maxFontSize: 18,
                  minFontSize: 8,
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
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
    );
  }
}
