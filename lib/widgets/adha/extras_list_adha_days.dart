import 'package:flutter/material.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/extra_tag.dart';

class ExtrasListAdhaDays extends StatelessWidget {
  final String title;
  final List<Extra> tags;
  final Function onTap;
  final int selected;
  final int? rid;
  ExtrasListAdhaDays({
    required this.title,
    required this.tags,
    required this.onTap,
    required this.selected,
    this.rid = 0,
  });

  @override
  Widget build(BuildContext context) {
    return tags.length == 0
        ? Container()
        : Visibility(
            visible: DateTime.now().day < 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  width: SizeConfig.screenWidth,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: getTags(context),
                  ),
                ),
              ],
            ),
          );
  }

  List<Widget> getTags(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    final List<int> _date = [9, 10, 11, 12];
    var currentDate = DateTime.now().day;
    print(" $currentDate");
    List<Widget> tagsList = [];
    print('rid $rid');
    for (int i = 0; i < tags.length; i++)
      if (rid == 0 || rid == tags[i].id)
        tagsList.add(Visibility(
          visible: _date[i] >= currentDate,
          child: ExtraTag(
            selected: selected == i,
            onTap: () {
              onTap(i);
            },
            title: _isAr ? tags[i].nameAr : tags[i].nameEn,
          ),
        ));

    return tagsList;
  }
}
