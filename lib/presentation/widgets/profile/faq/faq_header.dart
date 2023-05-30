import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class FaqHeader extends StatelessWidget {
  const FaqHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 150, maxHeight: 200),
      height: SizeConfig.screenWidth! / 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10),
            child: SvgPicture.asset(FixedAssets.questions),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              AppLocalizations.of(context)!.tr('help_header'),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
