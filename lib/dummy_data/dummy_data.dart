import 'package:flutter/material.dart';
import 'package:new_turki/models/notification_data.dart';
import 'package:new_turki/models/points_tran.dart';
import 'package:new_turki/models/points_data.dart';
import 'package:new_turki/models/wallet.dart';
import 'package:new_turki/utilities/r_a1_i_c_o_n_s_icons.dart';

class DummyData {
  static List<NotificationData> notificationsList = [
    NotificationData(
      image: 'https://pbs.twimg.com/media/E2ktN-fVgAEOsrp.jpg',
      date: "منذ ساعة",
      title: "عرض خاص لمدة ٤ ساعات",
      subtitle: 'خصم ١٠٪ على منتجات العجل والحور باستخدام الكود  DBH10',
    ),
    NotificationData(
      image:
          'https://pbs.twimg.com/media/E8q1ZsxXMAEo6WV?format=jpg&name=small',
      date: ' 3 أيام',
      title: "توصيل مجاني",
      subtitle:
          "اطلب الان واحصل على توصيل مجاني في سيارات مجهزة بثلاجات ليصلك طلبك طازج",
    ),
    NotificationData(
      image: 'https://pbs.twimg.com/media/E2ktN-fVgAEOsrp.jpg',
      date: "منذ ساعة",
      title: "عرض خاص لمدة ٤ ساعات",
      subtitle: 'خصم ١٠٪ على منتجات العجل والحور باستخدام الكود  DBH10',
    ),
    NotificationData(
      image:
          'https://pbs.twimg.com/media/E8q1ZsxXMAEo6WV?format=jpg&name=small',
      date: ' 3 أيام',
      title: "توصيل مجاني",
      subtitle:
          "اطلب الان واحصل على توصيل مجاني في سيارات مجهزة بثلاجات ليصلك طلبك طازج",
    ),
  ];

  static List<PointsData> pointsList = [
    PointsData(
        image:
            'https://i.insider.com/5a5313e8c32ae61f008b4e78?width=1200&format=jpeg',
        price: "5000",
        title: 'استبدل ب ٥٠ ريال رصيد'),
    PointsData(
        image:
            'https://d.newsweek.com/en/full/1608695/newsweek-amplify-money-rewards-weight-loss.png',
        price: "9500",
        title: 'استبدل ب 100 ريال رصيد'),
    PointsData(
        image:
            'https://www.al-madina.com/uploads/images/2021/04/20/1882664.jpg',
        price: "4000",
        title: 'تبرع لجمعة جود'),
    PointsData(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUMKOybQvnZpcVZNoLQ9gR5c94P5K7qDsE1UJ6tudSHnWDilW27S2kliLFe4CxzcTcS0&usqp=CAU',
        price: "12000",
        title: 'كيلو ستيك'),
  ];

  static List<PointsTran> pointsTran = [
    PointsTran(
      image: "assets/images/medal.png",
      before: 500,
      date: '20//05/2021',
      after: 500,
      description: 'اضافة ٥٠٠ نقطة عن الطلب رقم ٥٤٥٤٣',
    ),
    PointsTran(
      image: "assets/images/money.png",
      before: 0,
      date: '20//05/2021',
      after: -500,
      description: 'استبدال برصيد',
    ),
    PointsTran(
      image: "assets/images/medal.png",
      before: 500,
      date: '20//05/2021',
      after: 500,
      description: 'اضافة ٥٠٠ نقطة هدية',
    ),
  ];
  static List<Wallet> walletList = [
    Wallet(
        sId: '1',
        before: 100,
        color: Colors.green,
        iconData: RA1ICONS.money__1_,
        after: 35,
        date: '20//05/2021',
        description: 'اضافة أموال',
        userId: '1'),
    Wallet(
        sId: '1',
        color: Colors.red,
        iconData: RA1ICONS.money__2_,
        before: 65,
        date: '20//05/2021',
        after: -185,
        description: 'سداد قيمة الطلب ٥٠٨٠٧',
        userId: '1'),
    Wallet(
        sId: '200',
        color: Colors.purple,
        iconData: RA1ICONS.badge,
        date: '20//05/2021',
        before: 250,
        after: 50,
        description: 'استبدال نقاط',
        userId: '1'),
    Wallet(
        sId: '200',
        color: Colors.green,
        iconData: RA1ICONS.gift,
        date: '20//05/2021',
        before: 200,
        after: 200,
        description: 'اضافة رصيد هدية',
        userId: '1'),
  ];
}
