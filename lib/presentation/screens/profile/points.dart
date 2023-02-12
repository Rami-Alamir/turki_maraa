import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/profile/points_header.dart';
import '../../widgets/shared/primary_app_bar.dart';

//This feature will be active soon
class UserPoints extends StatefulWidget {
  const UserPoints({Key? key}) : super(key: key);

  @override
  UserPointsState createState() => UserPointsState();
}

class UserPointsState extends State<UserPoints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
          back: true,
          title: AppLocalizations.of(context)!.tr('my_points'),
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onRefresh: () async {},
          child: ListView(
            children: [
              const PointsHeader(
                points: 1000,
                category: "_auth.user.category!",
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
                      .displayLarge!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // Container(
                  //   width: SizeConfig.screenWidth,
                  //   height: 200,
                  //   child: ListView.builder(
                  //       padding: const EdgeInsets.only(right: 10, left: 10),
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       physics: ScrollPhysics(),
                  //       itemCount: DummyData.pointsList.length,
                  //       itemBuilder: (BuildContext ctxt, int index) {
                  //         return PointsCard(
                  //             pointsData: DummyData.pointsList[index]);
                  //       }),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 10),
                child: Text(
                  AppLocalizations.of(context)!.tr('transaction_details'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.vertical,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: DummyData.pointsTran.length,
              //     padding: EdgeInsets.all(0),
              //     itemBuilder: (BuildContext ctxt, int index) {
              //       return PointTransactionRow(
              //         transaction: DummyData.pointsTran[index],
              //       );
              //     })
            ],
          ),
        ));
  }
}
