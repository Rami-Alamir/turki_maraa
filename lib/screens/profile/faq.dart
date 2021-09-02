import 'package:flutter/material.dart';
import 'package:new_turki/models/qa.dart';
import 'package:new_turki/utilities/behavior.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/profile/faq_row.dart';

class Faq extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FaqState();
  }
}

class FaqState extends State<Faq> {
  List<Question> _faqList = [
    Question(
        question: 'ماهي انواع الذبائح ؟',
        answer: '1- نجدي 2- نعيمي 3- حري 4- تيس 5- حاشي 6- عجل'),
    Question(
        question: 'اين يقع مقر تركي للبائح ؟',
        answer:
            'يعتبر مقر تركي للذبائح في مدينة الرياض بالمملكة العربية السعودية حي الربيع طريق الملك عبد العزيز'),
    Question(
        question: 'ماهي أنواع التجهيز للذبائح ؟',
        answer:
            'يوجد لدينا جميع انواع التجهيز والتقطيع ويتم ذلك بحسب رغبة العميل'),
    Question(
        question: 'هل الذبائح بلدية ام مستوردة؟',
        answer: 'جميع ذبائحنا بلدية من حفر الباطن والطائف والقصيم ومزارعنا'),
    Question(
        question: 'هل الذبيحة مفحوصة من المسلخ وسليمة من الامراض؟',
        answer:
            'جميع الذبائح يتم ذبحها في مسلخ البلدية ويتم فحصها من قبل الطبيب البيطري في المسلخ وبعد التأكد من سلامتها يتم ذبحها وأيضا يتم فحصها بعد الذبح'),
    Question(
        question: 'هل تذبح الذبيحة طازجة وفي نفس اليوم؟',
        answer:
            'في تركي للذبائح الذبيحة لا تجهز او تذبح قبل صدور الفاتورة للعميل'),
    Question(
        question: ' ماهي خيارات الدفع المتاحة؟',
        answer:
            'يمكنك اختيار أحد الخيارات التالية للدفع الدفع ً عن الاستلام (نقدا – شبكة) البطاقات الائتمانية ( Mada-  Visa Card – Master Card – STC Pay - APPLE PAY )'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'الأسئلة الشائعة',
        back: true,
      ),
      body: ScrollConfiguration(
        behavior: Behavior(),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 150, maxHeight: 500),
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
                      'أهلا بك، كيف يمكننا مساعدتك؟',
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
                itemCount: _faqList.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (BuildContext ctxt, int index) {
                  return FaqRow(
                    question: _faqList[index].question,
                    answer: _faqList[index].answer,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
