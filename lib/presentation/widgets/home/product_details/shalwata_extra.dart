import 'package:flutter/material.dart';
import 'extra_tag.dart';
import '../../../../core/utilities/app_localizations.dart';

class ShalwataExtra extends StatelessWidget {
  final Function onTap;
  final bool selected;
  const ShalwataExtra({
    Key? key,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
            child: Text(AppLocalizations.of(context)!.tr('shalwata'),
                style: Theme.of(context).textTheme.titleSmall),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: ExtraTag(
                selected: selected,
                onTap: () {
                  onTap(!selected);
                },
                title: AppLocalizations.of(context)!.tr('shalwata'),
              )),
        ],
      ),
    );
  }
}
