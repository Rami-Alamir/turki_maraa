import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/profile/faq_row.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/faq_data.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/qa.dart';

class Faq extends StatelessWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    List<Question> faqList = isAr ? FAQData.faqListAr : FAQData.faqListEn;
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr("faq"),
        back: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 150, maxHeight: 200),
            height: SizeConfig.screenWidth! / 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                  child: SvgPicture.asset(FixedAssets.questions),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    AppLocalizations.of(context)!.tr('help_header'),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
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
              }),
        ],
      ),
    );
  }
}
