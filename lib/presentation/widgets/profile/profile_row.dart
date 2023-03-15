import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utilities/app_localizations.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  final bool withDivider;
  final bool withArrow;

  const ProfileRow(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.withArrow = true,
      this.withDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
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
                        child: SvgPicture.asset(
                          icon,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.tr(title),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 12,
                              )),
                    ],
                  ),
                ),
                Visibility(
                  visible: withArrow,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: withDivider,
              child: const Divider(
                thickness: 0.05,
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
