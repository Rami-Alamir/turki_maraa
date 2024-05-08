import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utilities/app_localizations.dart';

class ServicesItem extends StatelessWidget {
  final String image;
  final String title;

  const ServicesItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: SvgPicture.asset(
                  image,
                  height: 28,
                  width: 28,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 95,
              child: Text(AppLocalizations.of(context)!.tr(title),
                  style: Theme.of(context).textTheme.displayMedium),
            ),
          ],
        ),
      ),
    );
  }
}
