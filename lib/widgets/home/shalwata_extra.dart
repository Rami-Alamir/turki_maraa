import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/extra_tag.dart';

class ShalwataExtra extends StatelessWidget {
  final Function onTap;
  final bool selected;
  ShalwataExtra({
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
          child: Text(
            AppLocalizations.of(context)!.tr('shalwata'),
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: ExtraTag(
              selected: selected,
              onTap: () {
                onTap(!selected);
              },
              title: AppLocalizations.of(context)!.tr('shalwata'),
            )),
      ],
    );
  }
}
