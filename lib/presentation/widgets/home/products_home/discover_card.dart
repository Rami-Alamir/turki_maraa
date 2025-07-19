import 'package:flutter/material.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../models/discover_data.dart';

class DiscoverCard extends StatelessWidget {
  final Data item;

  const DiscoverCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 90,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, discover, arguments: item),
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
                    item.image!.trim(),
                    width: 165,
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              height: 90,
              width: 165,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: SizedBox(
                  width: 140.0,
                  height: 22,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      AppLocalizations.of(context)!.locale == const Locale('ar')
                          ? item.titleAr!
                          : item.titleEn!,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
