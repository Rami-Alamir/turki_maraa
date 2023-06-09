import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import '../../../../models/points_data.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class PointsCard extends StatelessWidget {
  final PointsData pointsData;

  const PointsCard({Key? key, required this.pointsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: InkWell(
        onTap: () {
          // ShowConfirmDialog().confirmDialog(
          //     context, "are_you_sure_you_want_to_redeem_points", () {
          //   final auth = Provider.of<Auth>(context, listen: false);
          //   auth.redeemPoints(context, int.parse(pointsData.price));
          // });
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
                        pointsData.image.trim(),
                        width: SizeConfig.setWidgetWidthWithFactor(
                            0.35, 0.54, 0.54),
                        height: SizeConfig.setWidgetWidthWithFactor(
                            0.35, 0.54, 0.54),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: AutoSizeText(
                    pointsData.title,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    minFontSize: 12,
                    maxFontSize: 14,
                    maxLines: 2,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Text(
                      "${pointsData.price} ${AppLocalizations.of(context)!.tr("point")}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 12),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
