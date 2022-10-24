import 'package:flutter/material.dart';
import '../../../controllers/app_language.dart';
import 'package:provider/provider.dart';

class IntroLanguage extends StatelessWidget {
  const IntroLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLanguage lang = Provider.of<AppLanguage>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 60, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              lang.changeLanguage();
            },
            child: Text(
              lang.language == 'ar' ? 'En' : 'العربية',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(118, 24, 14, 1.0)),
            ),
          ),
        ],
      ),
    );
  }
}
