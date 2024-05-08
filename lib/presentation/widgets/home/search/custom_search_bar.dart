import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/search_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/service/firebase_helper.dart';
import '../../../../core/utilities/size_config.dart';

class CustomSearchBar extends StatefulWidget {
  final bool autoFocus;

  const CustomSearchBar({super.key, this.autoFocus = true});
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            context.read<SearchProvider>().getSearchResultList(value);
            FirebaseHelper().pushAnalyticsEvent(name: "search", value: value);
          },
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Theme.of(context).textTheme.titleSmall!.color,
          autofocus: widget.autoFocus,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: SizeConfig.screenWidth! > 600 ? 20 : 14,
              fontWeight: FontWeight.normal),
          decoration: InputDecoration(
              fillColor: AppColors.white,
              hintText: AppLocalizations.of(context)!.tr('search_products'),
              hintStyle: Theme.of(context).textTheme.headlineSmall,
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.titleSmall!.color,
              ),
              contentPadding: const EdgeInsets.only(top: 5),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .textTheme
                          .titleLarge!
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
