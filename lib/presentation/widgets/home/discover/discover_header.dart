import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/discover_provider.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../core/constants/app_colors.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverProvider>(
      builder: (_, discoverProvider, _) {
        final bool isAr =
            AppLocalizations.of(context)!.locale == const Locale('ar');
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.transparent,
              height: 250,
              width: SizeConfig.screenWidth!,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      discoverProvider.discoverItem!.data!.subImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 40,
              child: SizedBox(
                width: 250,
                child: Text(
                  isAr
                      ? discoverProvider.discoverItem!.data!.descriptionAr!
                      : discoverProvider.discoverItem!.data!.descriptionEn!,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    height: 2,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
