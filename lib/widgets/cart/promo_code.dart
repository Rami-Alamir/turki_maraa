import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class PromoCode extends StatelessWidget {
  final TextEditingController promoCodeController;

  const PromoCode({required this.promoCodeController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('promo_code'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryVariant
                      .withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 70,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            width: SizeConfig.screenWidth,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              maxLength: 25,
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              textAlign: TextAlign.start,
              cursorColor: Theme.of(context).primaryColor,
              controller: TextEditingController(),
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  counterText: "",
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 1)),
                  errorStyle: TextStyle(fontSize: 12),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.tr('promo_code'),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.normal)),
              validator: (value) {
                return null;
              },
            ),
          ),
        )
      ],
    );
  }
}
