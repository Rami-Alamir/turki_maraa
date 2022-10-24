import 'package:flutter/material.dart';
import '../../../models/discover_data.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import 'discover_card.dart';

class DiscoverSection extends StatelessWidget {
  final DiscoverData discoverList;
  const DiscoverSection({Key? key, required this.discoverList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: (discoverList.data?.length ?? 0) > 0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20, bottom: 15, top: 15),
                  child: Text(AppLocalizations.of(context)!.tr('discover'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
              width: SizeConfig.screenWidth,
              height: 100,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  itemCount: discoverList.data!.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          index == 0 ? 8 : 3.0, 0, 8, 0),
                      child: DiscoverCard(
                        item: discoverList.data![index],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}