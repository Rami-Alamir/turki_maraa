import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final onTap;
  final controller;
  final enabled;
  final autoFocus;

  const SearchBar(
      {this.controller,
      required this.onTap,
      required this.enabled,
      required this.autoFocus});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          child: TextField(
            controller: controller ?? TextEditingController(),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Theme.of(context).textTheme.headline6!.color,
            enabled: enabled,
            autofocus: autoFocus,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: width > 600 ? 20 : 14, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'البحث في المنتجات',
                hintStyle: Theme.of(context).textTheme.headline6,
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
                            .textTheme
                            .headline6!
                            .color!
                            .withOpacity(0.35),
                        width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: new BorderSide(
                        color: Theme.of(context)
                            .textTheme
                            .headline6!
                            .color!
                            .withOpacity(0.35))),
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
