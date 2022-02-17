import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/search_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final controller;
  final autoFocus;

  const SearchBar({this.controller, required this.autoFocus});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        height: 50,
        child: TextField(
          controller: controller,
          onChanged: (v) {
            final _searchProvider =
                Provider.of<SearchProvider>(context, listen: false);
            final _addressProvider =
                Provider.of<AddressProvider>(context, listen: false);
            _searchProvider.getSearchResultList(
                _addressProvider.latLng, _addressProvider.isoCountryCode);
          },
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Theme.of(context).textTheme.headline6!.color,
          autofocus: autoFocus,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: width > 600 ? 20 : 14, fontWeight: FontWeight.normal),
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
                          .secondaryVariant
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
                        .secondaryVariant
                        .withOpacity(0.35),
                  )),
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent),
        ),
      ),
    );
  }
}
