import 'package:flutter/material.dart';
import '../../widgets/profile/about/about_body.dart';
import '../../widgets/profile/about/our_services.dart';
import '../../widgets/profile/about/our_vision.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        isTransparent: true,
        title: AppLocalizations.of(context)!.tr('about'),
        back: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: SizeConfig.screenWidth,
                height: 190,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(FixedAssets.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      FixedAssets.logo,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const AboutBody(),
          const OurVision(),
          const OurServices(),
        ],
      ),
    );
  }
}
