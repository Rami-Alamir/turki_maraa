import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool withDivider;

  const ProfileRow(
      {required this.title,
      required this.icon,
      required this.onTap,
      this.withDivider = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Icon(
                          icon,
                          color: Theme.of(context).textTheme.headline4!.color!,
                          size: 20,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.tr(title),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context)
                        .textTheme
                        .headline4!
                        .color!
                        .withOpacity(0.8),
                    size: 18,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: withDivider,
              child: Divider(
                indent: 10,
                endIndent: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
