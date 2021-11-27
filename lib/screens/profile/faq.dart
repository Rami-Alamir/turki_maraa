import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/profile/faq_row.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';

class Faq extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FaqState();
  }
}

class FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
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
            constraints: BoxConstraints(minHeight: 150, maxHeight: 200),
            height: SizeConfig.screenWidth! / 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                  child: Icon(
                    Icons.help_outline,
                    color: Theme.of(context).primaryColor,
                    size: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    AppLocalizations.of(context)!.tr('help_header'),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DummyData.faqList.length,
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (BuildContext ctxt, int index) {
                return FaqRow(
                  question: DummyData.faqList[index].question,
                  answer: DummyData.faqList[index].answer,
                );
              }),
        ],
      ),
    );
  }
}
