import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/utilities/size_config.dart';

class OrderDetailsRow extends StatelessWidget {
  final Item item;
  final String subtitle;
  const OrderDetailsRow({required this.item, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: SizeConfig.screenWidth!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                width: 60,
                height: 60,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: SizedBox(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      item.title!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 14, color: Colors.black),
                      maxLines: 1,
                    ),
                    Visibility(
                      visible: subtitle.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Container(
                          width: SizeConfig.screenWidth! * .6,
                          child: AutoSizeText(
                            subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.62),
                                    fontWeight: FontWeight.w400),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        width: SizeConfig.screenWidth! * .64,
                        child: AutoSizeText(
                          '${item.price} ريال ',
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
