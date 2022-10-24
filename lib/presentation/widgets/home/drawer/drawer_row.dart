import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utilities/app_localizations.dart';

class DrawerRow extends StatelessWidget {
  final String icon;
  final bool isSvg;
  final String title;
  final Function onTap;
  const DrawerRow(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.isSvg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 15, 0),
              child: isSvg
                  ? SvgPicture.asset(
                      icon,
                    )
                  : Image.asset(icon, width: 20, height: 20),
            ),
            Text(AppLocalizations.of(context)!.tr(title),
                style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }
}
