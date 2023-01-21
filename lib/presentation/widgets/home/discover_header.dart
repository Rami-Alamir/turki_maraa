import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/discover_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    final DiscoverProvider discoverProvider =
        Provider.of<DiscoverProvider>(context);
    return Visibility(
      visible: discoverProvider.discoverItem!.data!.subImage!.isNotEmpty,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.transparent,
              height: 250,
              width: SizeConfig.screenWidth!,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Container(
                  color: Colors.transparent,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        discoverProvider.discoverItem!.data!.subImage!,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ),
          Positioned(
              top: 40,
              right: 40,
              child: SizedBox(
                width: 250,
                child: Text(
                  isAr
                      ? discoverProvider.discoverItem!.data!.descriptionAr!
                      : discoverProvider.discoverItem!.data!.descriptionEn!,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 2),
                ),
              ))
        ],
      ),
    );
  }
}
