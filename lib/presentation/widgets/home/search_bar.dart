import 'package:flutter/material.dart';
import '../../../controllers/search_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/utilities/size_config.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final bool autoFocus;

  const SearchBar({Key? key, this.controller, required this.autoFocus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          onChanged: (v) {
            final searchProvider =
                Provider.of<SearchProvider>(context, listen: false);
            searchProvider.getSearchResultList();
            FirebaseHelper().pushAnalyticsEvent(
                name: "search", value: controller.toString());
          },
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Theme.of(context).textTheme.headline6!.color,
          autofocus: autoFocus,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: SizeConfig.screenWidth! > 600 ? 20 : 14,
              fontWeight: FontWeight.normal),
          decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: AppLocalizations.of(context)!.tr('search_products'),
              hintStyle: Theme.of(context).textTheme.headline5,
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.headline6!.color,
              ),
              contentPadding: const EdgeInsets.only(top: 5),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.35),
                      width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.35),
                      width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    width: 1.8,
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.35),
                  )),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent),
        ),
      ),
    );
  }
}
