import 'package:flutter/material.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/models/notification_data.dart';
import 'package:new_turki/models/points_tran.dart';
import 'package:new_turki/models/products.dart';
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

  static List<ProductData> bestSellerList = [
    ProductData(
      id: 1,
      nameAr: 'الهامور',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/vbR7bnUmEKYRwMTaC5T6yyNVjU1eiIkdqWrohjlt.webp',
      productImages: [
        ProductImages(
            imageUrl:
                'https://api.fishday.com.sa/storage/uploads/vbR7bnUmEKYRwMTaC5T6yyNVjU1eiIkdqWrohjlt.webp')
      ],
      price: 100.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'حمام فرنسي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      productImages: [
        ProductImages(
            imageUrl:
                'https://cdnprod.mafretailproxy.com/sys-master-root/hd1/h05/9194857070622/110964_main.jpg_480Wx480H')
      ],
      image:
          'https://cdnprod.mafretailproxy.com/sys-master-root/hd1/h05/9194857070622/110964_main.jpg_480Wx480H',
      price: 50.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'برجر لحم عجل',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      productImages: [
        ProductImages(
          imageUrl:
              'https://cdn.salla.sa/7Uv2ZnbDos0fZoX1fUSQMWKDq7mYxezM8kvh1wqt.jpeg',
        )
      ],
      image:
          'https://cdn.salla.sa/7Uv2ZnbDos0fZoX1fUSQMWKDq7mYxezM8kvh1wqt.jpeg',
      price: 60.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'أوصال شوي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      productImages: [
        ProductImages(
          imageUrl:
              'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
        )
      ],
      image:
          'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
      price: 60.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'ريش غنم',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      productImages: [
        ProductImages(
          imageUrl:
              'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
        )
      ],
      image:
          'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
      price: 95.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    )
  ];

  static List<Item> itemsList = [
    Item(
      image:
          'https://cdn.salla.sa/dbPPv/ArNOJzNYSAzorMhVAEw2CVWu8Zid2tdadfIDhfr9.jpg',
      price: "1850",
      nameAr: 'نعيمي',
      nameEn: "Naime",
      id: '1',
    ),
    Item(
      price: "1850",
      nameAr: "برجر",
      nameEn: "Burger",
      image:
          'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
      id: '2',
    ),
    Item(
      price: "1850",
      nameAr: "مفروم",
      nameEn: "Burger",
      image:
          'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
      id: '3',
    ),
  ];

  final List<String> banners = [
    'https://www.cooperbutchers.com/media/mbimages/b/a/banner_02.jpg',
    'https://media-exp1.licdn.com/dms/image/C4E1BAQG1SWqAyr9jaw/company-background_10000/0/1612628803012?e=2159024400&v=beta&t=sxVAog3nqeO0uV4HwE2JpvoTp57oxNSAWfMGYKokERo',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBmHgNwdnmp3C7AJt7ZQevJ1_DV8h1hElLgBT21We2RTcJjKNZDXXiTKaqu1ooTKOvNNI&usqp=CAU',
    'https://pbs.twimg.com/media/E9e-hOMWUAEnAw2.jpg'
  ];
  final List<DiscoverItem> discoverList = [
    DiscoverItem(
        banner:
            'https://expertphotography.b-cdn.net/wp-content/uploads/2020/06/meat-photography-12.jpg',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZgsBZ51rLjHnX3JCGUxMRPZ8jy--uJp9C3RIfonWo05IwLKYw37772Q1VMI6nrdWCk1E&usqp=CAU',
        nameAr: 'عروضنا',
        descriptionAr: 'تشكيلة واسعة من المنتجات الفاخرة سريعة التحضير',
        descriptionEn:
            'A wide range of premium products that are ready to be prepared',
        nameEn: "offers",
        id: '1'),
    DiscoverItem(
        banner:
            'https://expertphotography.b-cdn.net/wp-content/uploads/2020/06/meat-photography-12.jpg',
        image:
            'https://media.istockphoto.com/photos/ribeye-steaks-cooking-on-flaming-grill-panorama-picture-id1151530639?k=6&m=1151530639&s=612x612&w=0&h=N7SM5rN4F6gkTeOU2yiObOHo8Zjl7zalvdQ6SkQLOp4=',
        nameAr: 'مجهز للشواء',
        nameEn: "BBQ",
        descriptionAr: 'تشكيلة واسعة من المنتجات الفاخرة سريعة التحضير',
        descriptionEn:
            'A wide range of premium products that are ready to be prepared',
        id: '2'),
    DiscoverItem(
        descriptionAr: 'تشكيلة واسعة من المنتجات الفاخرة سريعة التحضير',
        descriptionEn:
            'A wide range of premium products that are ready to be prepared',
        image:
            'https://expertphotography.b-cdn.net/wp-content/uploads/2020/06/meat-photography-12.jpg',
        nameAr: 'سلملي عالجوع',
        nameEn: "Peace be upon hunger",
        id: '3',
        banner:
            'https://expertphotography.b-cdn.net/wp-content/uploads/2020/06/meat-photography-12.jpg'),
    DiscoverItem(
        descriptionAr: 'تشكيلة واسعة من المنتجات الفاخرة سريعة التحضير',
        descriptionEn:
            'A wide range of premium products that are ready to be prepared',
        banner:
            'https://expertphotography.b-cdn.net/wp-content/uploads/2020/06/meat-photography-12.jpg',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUMKOybQvnZpcVZNoLQ9gR5c94P5K7qDsE1UJ6tudSHnWDilW27S2kliLFe4CxzcTcS0&usqp=CAU',
        nameAr: 'جديدنا',
        nameEn: "New arrival",
        id: '4'),
  ];

  // List<CategoryData> categoryData = [
  //   CategoryData(
  //     image: "assets/images/hary.png",
  //     color: Color.fromRGBO(90, 4, 9, 1),
  //     color2: Color.fromRGBO(107, 0, 0, 0.9),
  //     titleAr: 'لحوم',
  //     titleEn: 'Meat',
  //   ),
  //   CategoryData(
  //       image: "assets/images/c1.png",
  //       color: Color.fromRGBO(226, 198, 101, 1),
  //       color2: Color.fromRGBO(233, 198, 101, 1),
  //       titleAr: 'دواجن',
  //       titleEn: 'Poultry'),
  //   CategoryData(
  //       image: "assets/images/i5.png",
  //       color2: Color.fromRGBO(51, 79, 45, 1),
  //       color: Color.fromRGBO(66, 79, 45, 1),
  //       titleAr: 'خضار وفواكه',
  //       titleEn: 'Fruits and vegetables'),
  //   CategoryData(
  //       image: "assets/images/fish.png",
  //       color2: Color.fromRGBO(235, 190, 210, 1),
  //       color: Color.fromRGBO(224, 183, 201, 1),
  //       titleAr: 'أسماك',
  //       titleEn: 'Fis'),
  // ];
}
