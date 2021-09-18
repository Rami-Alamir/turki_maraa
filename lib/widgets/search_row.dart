import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:new_turki/models/item.dart';

class SearchRow extends StatelessWidget {
  final Item item;
  const SearchRow({required this.item});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            width: 60,
                            height: 60,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Container(
                                color: Theme.of(context).accentColor,
                                width: 60,
                                height: 60,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(
                                      '${item.image?.trim()}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        item.title!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 14),
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: Theme.of(context)
                  .textTheme
                  .headline6!
                  .color!
                  .withOpacity(0.3),
            )
          ],
        ),
      ),
    );
  }
}
