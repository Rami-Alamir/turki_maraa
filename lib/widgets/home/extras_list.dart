import 'package:flutter/material.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/extra_tag.dart';

class ExtrasList extends StatelessWidget {
  final String title;
  final List<Extra> tags;
  final Function onTap;
  final int selected;
  ExtrasList({
    required this.title,
    required this.tags,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return tags.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
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
                width: _width,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: getTags(context),
                ),
              ),
            ],
          );
  }

  List<Widget> getTags(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    List<Widget> tagsList = [];
    for (int i = 0; i < tags.length; i++)
      tagsList.add(ExtraTag(
        selected: selected == i,
        onTap: () {
          print("iiiii$i");
          onTap(i);
        },
        title: _isAr ? tags[i].nameAr : tags[i].nameEn,
      ));
    return tagsList;
  }
}
