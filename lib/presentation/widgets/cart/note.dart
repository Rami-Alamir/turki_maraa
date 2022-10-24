import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 15.0, top: 15, left: 15, bottom: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('note'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                width: SizeConfig.screenWidth! - 30,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 5,
                  maxLength: 250,
                  keyboardAppearance: Brightness.dark,
                  textAlign: TextAlign.start,
                  cursorColor: Theme.of(context).primaryColor,
                  controller: cartProvider.noteController,
                  onChanged: (value) {},
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.transparent,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      errorStyle: const TextStyle(fontSize: 12),
                      errorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      disabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      hintText: AppLocalizations.of(context)!.tr("note_hint"),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                              fontSize: 14, fontWeight: FontWeight.normal)),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
