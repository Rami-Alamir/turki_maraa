import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/service/firebase_helper.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/route_constants.dart';

class CategoryCard extends StatelessWidget {
  final int categoryId;
  final String title;
  final String image;
  final Color color;
  final Color color2;
  final String titleAr;
  final String titleEn;
  const CategoryCard({
    super.key,
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
        Navigator.pushNamed(context, productsHome, arguments: categoryId);
        FirebaseHelper.analytics!
            .logEvent(name: 'Categories', parameters: {"name": titleAr});
        FirebaseHelper.analytics!.logEvent(name: titleEn, parameters: null);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: FadeInImage(
                  placeholderFit: BoxFit.cover,
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  height: SizeConfig.setWidgetHeight(120, 200, 200),
                  width: SizeConfig.screenWidth,
                  placeholder: const AssetImage(
                    FixedAssets.bannerPlaceholder,
                  )),
            ),
            Container(
              height: SizeConfig.setWidgetHeight(40, 60, 60),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth! - 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: AutoSizeText(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: Theme.of(context).primaryColor ==
                                        AppColors.nd94
                                    ? AppColors.nd94
                                    : Theme.of(context)
                                                .colorScheme
                                                .onTertiary ==
                                            AppColors.purpleGray
                                        ? AppColors.primaryColor
                                        : AppColors.land,
                                fontSize: 15),
                        maxFontSize: 15,
                        minFontSize: 8,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
