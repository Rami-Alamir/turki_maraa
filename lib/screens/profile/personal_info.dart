import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    usernameController.text = 'رامي الأمير';
    emailController.text = 'rami.alamir.7@gmail.com';
    nationalityController.text = 'مصري';
    ageController.text = '26';
    usernameController.text = 'رامي الأمير';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: '', back: true),
      body: ListView(
        children: [
          AvatarGlow(
            glowColor: Theme.of(context).primaryColor,
            endRadius: 78.0,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Container(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text('R A',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('الاسم',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: usernameController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('البريد الالكتروني',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: emailController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('الجنسية',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: nationalityController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('العمر',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: ageController,
                ),
              ],
            ),
          ),
          RoundedRectangleButton(
            height: 50,
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            fontSize: 16,
            title: 'تحديث',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
