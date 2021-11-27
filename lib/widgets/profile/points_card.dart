import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:new_turki/models/points_data.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/show_dialog.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

class PointsCard extends StatelessWidget {
  final PointsData pointsData;

  const PointsCard({required this.pointsData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: InkWell(
        onTap: () {
          ShowConfirmDialog().confirmDialog(
              context, "are_you_sure_you_want_to_redeem_points", () {
            final auth = Provider.of<Auth>(context, listen: false);
            auth.redeemPoints(context, int.parse(pointsData.price));
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: 130,
              height: 130,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Image.network(
                        '${pointsData.image.trim()}',
                        width: SizeConfig.setWidgetWidth(0.35, 0.54, 0.54),
                        height: SizeConfig.setWidgetWidth(0.35, 0.54, 0.54),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: AutoSizeText(
                      pointsData.title,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                      minFontSize: 12,
                      maxFontSize: 14,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Text(
                        pointsData.price.toString() +
                            " " +
                            AppLocalizations.of(context)!.tr("point"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 12),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
