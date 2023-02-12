import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class AlmaraaCard extends StatelessWidget {
  const AlmaraaCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, homeCategories);
      },
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: SizeConfig.setWidgetHeight(180, 320, 320),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).colorScheme.background),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.network(
                      "https://almaraacompany.com/turki-app/image/banner.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: TextDirection.rtl,
                  start: 5,
                  top: 5,
                  child: Card(
                    elevation: 10,
                    color: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        "https://almaraacompany.com/turki-app/image/almaraa_logo.png",
                        fit: BoxFit.fill,
                        width: SizeConfig.setWidgetWidth(50, 75, 75),
                        height: SizeConfig.setWidgetHeight(50, 75, 75),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0, top: 12),
                    child: Text(
                      AppLocalizations.of(context)!.tr("almaraa"),
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.tr("almaraa_desc"),
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(height: 2, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                        child: Icon(
                          TURKIICONS.delivery_truck_2,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                          size: 15,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.tr("free_delivery"),
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                height: 2,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
