import 'package:flutter/material.dart';
import 'package:new_turki/utilities/firebase_helper.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
              title: 'title',
              onPressed: () {
                dd();
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/Success', arguments: "successfully");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Login()),
                // );
              })
        ],
      ),
    );
  }

  Future<void> dd() async {
    await FirebaseHelper.analytics!.setCurrentScreen(
      screenName: 'Home Demo',
      screenClassOverride: 'HomeDemo',
    );
    await FirebaseHelper.analytics!.logEvent(
      name: "TestNewTurkiEvent",
      parameters: <String, dynamic>{
        'plant_name': " currentPlant.name",
        'plant_species': "currentPlant.species",
        'plant_group': "currentPlant.group",
        'new_plant': "widget.newPlant"
      },
    );
  }
}
