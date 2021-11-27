import 'package:flutter/material.dart';
import 'package:new_turki/models/notification_data.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/models/points_tran.dart';
import 'package:new_turki/models/qa.dart';
import 'package:new_turki/models/points_data.dart';
import 'package:new_turki/models/wallet.dart';
import 'package:new_turki/utilities/r_a1_i_c_o_n_s_icons.dart';

class DummyData {
  static List<Question> faqList = [
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
  static List<Order> ordersList = [
    Order(
      image:
          'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
      total: "1450",
      date: '30/8/2021',
      type: 'توصيل',
      payment: 'تم السداد',
      status: 'جاري التجهيز',
      orderItems: [OrderItem(qty: "1", title: "حري")],
      id: '50805',
    ),
    Order(
      type: 'استلام من الفرع',
      image:
          'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
      total: "230",
      date: '22/8/2021',
      payment: 'جاري التحقق من عملية الدفع',
      status: 'تم التوصيل',
      orderItems: [
        OrderItem(qty: "1", title: "برجر"),
        OrderItem(qty: "1", title: "مفروم")
      ],
      id: '50812',
    ),
    Order(
      type: 'توصيل',
      image:
          'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
      total: "1320",
      orderItems: [
        OrderItem(qty: "1", title: "برجر"),
        OrderItem(qty: "1", title: "مفروم")
      ],
      payment: 'الدفع عند الاستلام',
      date: '21/8/2021',
      status: 'تم الالغاء',
      id: '50833',
    ),
    Order(
      type: 'توصيل',
      image:
          'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
      total: "1450",
      orderItems: [
        OrderItem(qty: "1", title: "نعيمي"),
        OrderItem(qty: "1", title: "مفروم")
      ],
      date: '30/8/2021',
      payment: 'تم السداد',
      status: 'تم التوصيل',
      id: '50812',
    ),
    Order(
      type: 'توصيل',
      payment: 'تم السداد',
      image:
          'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
      total: "230",
      date: '22/8/2021',
      orderItems: [
        OrderItem(qty: "2", title: "برجر"),
        OrderItem(qty: "1", title: "مفروم")
      ],
      status: 'تم التوصيل',
      id: '50812',
    ),
    Order(
      type: 'توصيل',
      payment: 'تم السداد',
      orderItems: [OrderItem(qty: "1", title: "نعيمي")],
      image:
          'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
      total: "1320",
      date: '21/8/2021',
      status: 'تم الالغاء',
      id: '50833',
    ),
  ];
}
