import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class DrawerRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const DrawerRow(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              child: Icon(
                icon,
                color: Theme.of(context).textTheme.headline4!.color,
              ),
            ),
            Text(AppLocalizations.of(context)!.tr(title),
                style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }
}
