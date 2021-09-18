import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: '',
        back: true,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 40,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/turki3.png",
                    colorBlendMode: BlendMode.dstATop,
                    fit: BoxFit.fill,
                    width: 300,
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'عن تركي للئبائح',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Container(
                    width: SizeConfig.screenWidth! - 30,
                    child: Text(
                      'تعد شركة المرعى للتجارة التي تتخذ من المملكة العربية السعودية مــــقرا لها واحده من اقوى وأبرز الشــــركات الرائـــدة فــــي توصيل اللحوم الطازجــة الى المنازل تأســــــست في عام 2014 وتمتلك شــــركة المـــرعى للتـــجارة امــــــكــــانيات وعـــــلاقات تجـــعل منها عــــلامة فـــــارقة فــــي مـــجال اللــــــحوم. وتعمل شركـة المرعى للتـجارة التي يتفرع منها مركز تركي للذبائح على توفير باقة متنوعة من أصناف اللحوم الطازجة بمعايير وجــودة عالية وتوفر منتجاتها لعملائها في جميع مناطق المـــملكة الــــعربية السعودية ودول الخليج ويعمل لدى شـــركة المـرعى للتــــجارة أكثر من 200 موظف بكل احترافية لتلبية احتياجاتكم.',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 16, height: 1.5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
