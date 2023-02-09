import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/app_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/hex_color.dart';

class PromotionDialog extends StatelessWidget {
  const PromotionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    final bool isAr =
        AppLocalizations.of(context)!.locale!.languageCode == 'ar';
    return SizedBox(
      width: 100,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        backgroundColor: Theme.of(context).colorScheme.background,
        contentPadding: const EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                if (appProvider.promotion?.redirectUrl != null) {
                  _launchURL(appProvider.promotion!.redirectUrl!);
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: NetworkImage(appProvider.promotion!.image!),
                    fit: BoxFit.cover,
                  ),
                ),
                constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: appProvider.promotion?.redirectUrl != null,
                      child: RoundedRectangleButton(
                        title: isAr
                            ? appProvider.promotion!.titleAr!
                            : appProvider.promotion!.titleEn!,
                        color: HexColor(
                            appProvider.promotion?.subTitleColor ?? "D4AF37"),
                        fontColor: HexColor(
                            appProvider.promotion?.subTitleColor ?? "FFFFFF"),
                        width: 200,
                        height: 40,
                        onPressed: () {
                          _launchURL(appProvider.promotion!.redirectUrl!);
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (_) {}
  }
}
