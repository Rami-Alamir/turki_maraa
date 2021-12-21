import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

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
          controller: controller ?? TextEditingController(),
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
              contentPadding: EdgeInsets.only(top: 5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: new BorderSide(
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.35),
                      width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: new BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryVariant
                          .withOpacity(0.35),
                      width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: new BorderSide(
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
