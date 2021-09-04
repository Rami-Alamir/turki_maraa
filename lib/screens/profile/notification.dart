import 'package:flutter/material.dart';
import 'package:new_turki/widgets/notification_card.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';

class UserNotification extends StatefulWidget {
  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'الإشعارات',
        back: true,
      ),
      body: ListView(
        children: [
          NotificationCard(
            image: 'https://pbs.twimg.com/media/E2ktN-fVgAEOsrp.jpg',
            total: 1450,
            date: "منذ ساعة",
            title: "عرض خاص لمدة ٤ ساعات",
            subtitle: 'خصم ١٠٪ على منتجات العجل والحور باستخدام الكود  DBH10',
            status: 'جاري التجهيز',
            id: '50805',
            style: TextStyle(
                height: 1.6,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Theme.of(context).primaryColor),
          ),
          NotificationCard(
            image:
                'https://pbs.twimg.com/media/E8q1ZsxXMAEo6WV?format=jpg&name=small',
            total: 1450,
            date: ' 3 أيام',
            title: "توصيل مجاني",
            subtitle:
                "اطلب الان واحصل على توصيل مجاني في سيارات مجهزة بثلاجات ليصلك طلبك طازج",
            status: 'جاري التجهيز',
            id: '50805',
            style: TextStyle(
                height: 1.6,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
