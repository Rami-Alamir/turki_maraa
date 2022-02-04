import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:provider/provider.dart';

class IntroLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _lang = Provider.of<AppLanguage>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 60, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              _lang.changeLanguage();
            },
            child: Text(
              _lang.language == 'ar' ? 'En' : 'العربية',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(132, 15, 15, 1),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
