import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class EmptyList extends StatelessWidget {
  final String title;
  final String image;

  const EmptyList({Key? key, this.title = "", required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: (SizeConfig.screenHeight! - 180 - 238) / 2),
              child: Image.asset(
                image,
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Text(
                AppLocalizations.of(context)!.tr(title),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
