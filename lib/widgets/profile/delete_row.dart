import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../utilities/app_localizations.dart';

class DeleteRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Platform.isIOS || Platform.isMacOS,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          final _auth = Provider.of<Auth>(context, listen: false);
          _auth.deleteAccount(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.tr('delete_account'),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
