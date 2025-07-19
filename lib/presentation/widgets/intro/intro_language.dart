import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/app_language.dart';

class IntroLanguage extends StatelessWidget {
  const IntroLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 60, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<AppLanguage>(
            builder: (_, lang, _) {
              return TextButton(
                onPressed: () {
                  lang.changeLanguage();
                },
                child: Text(
                  lang.language == 'ar' ? 'En' : 'العربية',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
