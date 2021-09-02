import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';
import '../models/item.dart';

class PointsCard extends StatelessWidget {
  final Item item;

  const PointsCard({required this.item});

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (context) => ItemDetails()),
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
                          borderRadius: BorderRadius.circular(5.0)),
                      child: SizedBox(
                        width:
                            _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
                        height:
                            _width > 590 ? _width / 2.85 * 0.65 : _width / 2.85,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.5),
                            child: Image.network(
                              '${item.image?.trim()}',
                              width: _width > 590
                                  ? _width / 2.85 * 0.65
                                  : _width / 2.85,
                              height: _width > 590
                                  ? _width / 2.85 * 0.65
                                  : _width / 2.85,
                              fit: BoxFit.cover,
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: AutoSizeText(
                        item.title!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        minFontSize: _width > 590 ? 16 : 12,
                        maxFontSize: _width > 590 ? 18 : 12,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  item.price.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: item.discount! > 0.0
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: item.discount! > 0 ? 10 : 12,
                                      fontWeight: FontWeight.w500),
                                  minFontSize: item.discount! > 0 ? 12 : 12,
                                  maxFontSize: item.discount! > 0 ? 12 : 12,
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  ' نقطة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: item.discount! > 0 ? 8 : 12,
                                      fontWeight: FontWeight.w500),
                                  minFontSize: item.discount! > 0 ? 8 : 12,
                                  maxFontSize: item.discount! > 0 ? 8 : 12,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
