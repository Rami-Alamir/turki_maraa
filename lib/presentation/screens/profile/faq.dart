import 'package:flutter/material.dart';
import '../../widgets/profile/faq/faq_header.dart';
import '../../widgets/profile/faq/faq_list.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../core/utilities/app_localizations.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr("faq"),
        back: true,
      ),
      body: ListView(
        children: const <Widget>[FaqHeader(), FaqList()],
      ),
    );
  }
}
