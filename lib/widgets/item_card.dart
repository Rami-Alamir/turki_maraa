import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    print(item.title!);
    double _width = SizeConfig.screenWidth!;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: SizedBox(
        width: _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
        height: _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDetails(
                        name: item.title!,
                      )),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        color: Theme.of(context).accentColor,
                        width:
                            _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
                        height:
                            _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Hero(
                              tag: item.title!,
                              child: Image.network(
                                '${item.image?.trim()}',
                                width: _width > 590
                                    ? _width / 2.85 * 0.65
                                    : _width / 2.85,
                                height: _width > 590
                                    ? _width / 2.85 * 0.65
                                    : _width / 2.85,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: item.tagColor != null,
                    child: Positioned.directional(
                        textDirection: TextDirection.rtl,
                        top: 15,
                        end: 10,
                        child: Container(
                          constraints: BoxConstraints(minWidth: 40),
                          decoration: BoxDecoration(
                            color: item.tagColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 1.0, right: 10, left: 10),
                            child: Text(
                              item.tag!,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: AutoSizeText(
                  item.title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                  minFontSize: _width > 590 ? 16 : 14,
                  maxFontSize: _width > 590 ? 18 : 14,
                  maxLines: 1,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 3, left: 5, right: 5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            item.price.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    decoration: item.discount! > 0.0
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    fontSize: item.discount! > 0 ? 10 : 14,
                                    fontWeight: FontWeight.w500),
                            minFontSize: item.discount! > 0 ? 12 : 14,
                            maxFontSize: item.discount! > 0 ? 12 : 14,
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            ' ريال',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: item.discount! > 0 ? 8 : 12,
                                    fontWeight: FontWeight.w500),
                            minFontSize: item.discount! > 0 ? 8 : 12,
                            maxFontSize: item.discount! > 0 ? 8 : 12,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: item.discount! > 0,
                        child: Padding(
                            padding: EdgeInsets.only(top: 3, left: 5, right: 5),
                            child: Row(
                              children: [
                                AutoSizeText(
                                  (item.price!.toDouble() -
                                          (item.price!.toDouble() *
                                              item.discount! /
                                              100))
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  minFontSize: _width > 590 ? 12 : 14,
                                  maxFontSize: _width > 590 ? 14 : 14,
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  ' ريال',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  minFontSize: _width > 590 ? 12 : 12,
                                  maxFontSize: _width > 590 ? 14 : 12,
                                  maxLines: 1,
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
