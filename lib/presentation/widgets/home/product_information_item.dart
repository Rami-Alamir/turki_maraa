import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';

class ProductInformationItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final String description;
  final double size;
  const ProductInformationItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.value,
      required this.description,
      required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value.isNotEmpty,
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: size,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 5.0),
                child: Text(
                  AppLocalizations.of(context)!.tr(title),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(8.0, 5.0, 0.0, 0.0),
                child: Row(
                  children: [
                    Text(
                      "$value ",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
