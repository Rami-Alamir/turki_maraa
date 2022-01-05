import 'package:flutter/material.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class DiscoverCard extends StatelessWidget {
  final DiscoverItem item;

  const DiscoverCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 90,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Navigator.pushNamed(context, '/Discover', arguments: item),
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              width: 165,
              height: 90,
              child: SizedBox(
                height: 90,
                width: 165,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      '${item.image.trim()}',
                      width: 165,
                      height: 90,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Container(
              height: 90,
              width: 165,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Container(
                  width: 140.0,
                  height: 22,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      AppLocalizations.of(context)!.locale == Locale('ar')
                          ? item.nameAr
                          : item.nameEn,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
