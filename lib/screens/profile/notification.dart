import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/profile/notification_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';

class UserNotification extends StatefulWidget {
  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('notifications'),
        back: true,
      ),
      body: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: SizeConfig.screenWidth! > 800
                ? 3
                : SizeConfig.screenWidth! > 600
                    ? 2
                    : 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 5,
          ),
          itemCount: DummyData.notificationsList.length,
          itemBuilder: (BuildContext ctx, index) {
            return NotificationCard(
              notificationData: DummyData.notificationsList[index],
            );
          }),
    );
  }
}
