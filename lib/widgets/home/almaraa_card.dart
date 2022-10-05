import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class AlmaraaCard extends StatelessWidget {
  final GlobalKey<ScaffoldState> appKey;
  const AlmaraaCard({required this.appKey});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/HomeCategories", arguments: appKey);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).backgroundColor),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset("assets/images/almaraa_banner.jpg",
                        fit: BoxFit.fill),
                  ),
                ),
                PositionedDirectional(
                  start: 15,
                  top: 15,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/images/almaraa_icon.png",
                          fit: BoxFit.contain,
                          width: 50,
                          height: 50,
                        ),
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
                          .headline4!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.tr("almaraa_desc"),
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(height: 2, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                        child: Icon(
                          TURKIICONS.delivery_truck_2,
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          size: 15,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.tr("free_delivery"),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
