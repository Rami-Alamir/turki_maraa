import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'extra_tag.dart';
import '../../../../controllers/app_provider.dart';
import '../../../../models/extra.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class ExtrasList extends StatelessWidget {
  final String title;
  final List<ExtraData> tags;
  final Function onTap;
  final int selected;
  final bool? isVisible;

  const ExtrasList({
    super.key,
    required this.title,
    required this.tags,
    required this.onTap,
    required this.selected,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return tags.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      15.0, 15.0, 0.0, 10.0),
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    List<Widget> tagsList = [];
    for (int i = 0; i < tags.length; i++) {
      tagsList.add(Visibility(
        visible: title ==
                AppLocalizations.of(context)!.tr('choose_the_day_of_sacrifice')
            ? DateTime.parse(
                        context.read<AppProvider>().adhaConfig?.dates?[i] ?? "")
                    .compareTo(DateTime.now()) >
                0
            : (tags[i].id == context.read<AppProvider>().adhaConfig?.cutId
                ? isVisible!
                : true),
        child: ExtraTag(
          selected: selected == i,
          onTap: () {
            onTap(i);
          },
          title: "${(isAr ? tags[i].nameAr : tags[i].nameEn)}",
        ),
      ));
    }
    return tagsList;
  }
}
