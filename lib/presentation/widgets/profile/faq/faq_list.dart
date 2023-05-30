import 'package:flutter/material.dart';
import 'faq_row.dart';
import '../../../../core/constants/faq_data.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../models/qa.dart';

class FaqList extends StatelessWidget {
  const FaqList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    List<Question> faqList = isAr ? FAQData.faqListAr : FAQData.faqListEn;

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: faqList.length,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext ctxt, int index) {
          return FaqRow(
            question: faqList[index].question,
            answer: faqList[index].answer,
          );
        });
  }
}
