import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';

class OrderNote extends StatelessWidget {
  final String note;

  const OrderNote({required this.note});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: note.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              AppLocalizations.of(context)!.tr('note'),
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          MainCard(
            height: 50,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: SizeConfig.screenWidth! * 0.8,
                    child: Text(note,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.5)),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
