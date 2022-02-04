import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';

import '../shared/rectangle_text_field.dart';

class RoundedPickerButton extends StatelessWidget {
  final TextEditingController textEditingController;

  const RoundedPickerButton({required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(AppLocalizations.of(context)!.tr('gender'),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  )),
        ),
        InkWell(
          onTap: () {
            showPicker(context);
          },
          child: RectangleTextField(
            controller: textEditingController,
            enable: false,
          ),
        )
      ],
    );
  }

  showPicker(BuildContext context) {
    Picker(
        headerColor: Theme.of(context).backgroundColor,
        containerColor: Theme.of(context).backgroundColor,
        backgroundColor: Theme.of(context).backgroundColor,
        adapter: PickerDataAdapter(
          data: [
            PickerItem(
                text: Text(
                  AppLocalizations.of(context)!.tr('maleString'),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(height: 1.4, fontSize: 16),
                ),
                value: "0"),
            PickerItem(
                text: Text(
                  AppLocalizations.of(context)!.tr('femaleString'),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(height: 1.4, fontSize: 16),
                ),
                value: "1")
          ],
        ),
        confirmText: AppLocalizations.of(context)!.tr('confirm'),
        confirmTextStyle:
            Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14),
        cancelText: AppLocalizations.of(context)!.tr('cancel'),
        cancelTextStyle:
            Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14),
        changeToFirst: false,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(12.0),
        onConfirm: (Picker picker, List value) {
          final auth = Provider.of<Auth>(context, listen: false);
          print(value.toString().substring(1, 2));
          auth.setGender(int.parse(value.toString().substring(1, 2)), context);
          print(value.toString().length);
        }).showModal(context);
  }
}
