import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/shared/primary_app_bar.dart';

//This feature will be active soon
class UserNotification extends StatelessWidget {
  const UserNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('notifications'),
        back: true,
      ),
      // body: RefreshIndicator(
      //   color: Theme.of(context).primaryColor,
      //   backgroundColor: Theme.of(context).colorScheme.secondary,
      //   onRefresh: () async {},
      //   child: GridView.builder(
      //       shrinkWrap: true,
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: SizeConfig.screenWidth! > 800
      //             ? 3
      //             : SizeConfig.screenWidth! > 600
      //                 ? 2
      //                 : 1,
      //         crossAxisSpacing: 0,
      //         mainAxisSpacing: 5,
      //       ),
      //       itemCount: DummyData.notificationsList.length,
      //       itemBuilder: (BuildContext ctx, index) {
      //         return NotificationCard(
      //           notificationData: DummyData.notificationsList[index],
      //         );
      //       }),
      // ),
    );
  }
}
