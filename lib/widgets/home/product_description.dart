import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

import 'circle_icon.dart';

class ProductDescription extends StatelessWidget {
  final bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0, 0, 0),
              child: Container(
                width: SizeConfig.screenWidth! - 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نعيمي',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      'نعيمي',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 20, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15.0, 12.0, 0),
              child: Row(
                children: [
                  CircleIcon(
                      icon: Icons.share,
                      onTap: () {},
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0)),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0),
                    child: CircleIcon(
                        icon: isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        onTap: () {
                          // isFavourite = !isFavourite;
                          // setState(() {});
                        },
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0, 0, 0)),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 12, left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star,
                size: 20,
                color: Color.fromRGBO(250, 202, 29, 1),
              ),
              Icon(
                Icons.star,
                size: 20,
                color: Color.fromRGBO(250, 202, 29, 1),
              ),
              Icon(
                Icons.star,
                size: 20,
                color: Color.fromRGBO(250, 202, 29, 1),
              ),
              Icon(
                Icons.star,
                size: 20,
                color: Color.fromRGBO(250, 202, 29, 1),
              ),
              Icon(
                Icons.star,
                size: 20,
                color: Color.fromRGBO(223, 223, 223, 1),
              ),
              Text(
                ' (4.8) ',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12, 4, 12),
              child: Text(
                '1850${AppLocalizations.of(context)!.tr('sr')}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 16, height: 1.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '(شامل ضريبة القيمة المضافة)',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'خروف نعيمي بلدي مربى محليا في مزارعنا يصلك طازج ومغلف ومقطع حسب اختيارك',
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }
}
