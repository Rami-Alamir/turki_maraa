import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/profile/points_card.dart';
import 'package:new_turki/widgets/profile/points_header.dart';
import 'package:new_turki/widgets/profile/points_transaction_row.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

class UserPoints extends StatefulWidget {
  @override
  _UserPointsState createState() => _UserPointsState();
}

class _UserPointsState extends State<UserPoints> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    _auth.getUserPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: true);

    return Scaffold(
        appBar: PrimaryAppBar(
          back: true,
          title: AppLocalizations.of(context)!.tr('my_points'),
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onRefresh: () async {
            await _auth.delayed();
          },
          child: ListView(
            children: [
              PointsHeader(
                points: _auth.user.point!.toInt(),
                category: _auth.user.category!,
                msg:
                    'احصل على مزايا ومكافات حصرية عند حصولك على ١٤٥٠ نقطة و ترقيتك للفئة الذهبية',
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  AppLocalizations.of(context)!.tr('redeem_for_rewards'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: 200,
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        itemCount: DummyData.pointsList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                index == 0 ? 8 : 3.0, 0, 0, 0),
                            child: PointsCard(
                                pointsData: DummyData.pointsList[index]),
                          );
                        }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context)!.tr('transaction_details'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DummyData.pointsTran.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext ctxt, int index) {
                    return PointTransactionRow(
                      transaction: DummyData.pointsTran[index],
                    );
                  })
            ],
          ),
        ));
  }
}
