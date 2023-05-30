import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utilities/app_localizations.dart';

class AboutRow extends StatelessWidget {
  final String title;
  final String image;
  final MainAxisAlignment? mainAxisAlignment;
  const AboutRow(
      {Key? key,
      required this.title,
      required this.image,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment!,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 15, 10, 0),
            child: SvgPicture.asset(
              image,
              height: 45,
              width: 45,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.tr(title),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 3),
          ),
        ],
      ),
    );
  }
}
