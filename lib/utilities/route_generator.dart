import 'package:flutter/material.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/screens/cart/shopping_cart.dart';
import 'package:new_turki/screens/chat/chat.dart';
import 'package:new_turki/screens/home/home.dart';
import 'package:new_turki/screens/orders/orders.dart';
import 'package:new_turki/screens/profile/about.dart';
import 'package:new_turki/screens/profile/faq.dart';
import 'package:new_turki/screens/profile/favourite.dart';
import 'package:new_turki/screens/profile/login.dart';
import 'package:new_turki/screens/profile/notification.dart';
import 'package:new_turki/screens/profile/personal_information.dart';
import 'package:new_turki/screens/profile/points.dart';
import 'package:new_turki/screens/profile/policies.dart';
import 'package:new_turki/screens/profile/profile.dart';
import 'package:new_turki/screens/profile/wallet.dart';
import 'package:new_turki/screens/splash/splash.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/App':
        return MaterialPageRoute(builder: (_) => App());
      case '/Home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/Orders':
        return MaterialPageRoute(builder: (_) => Orders());
      case '/Cart':
        return MaterialPageRoute(builder: (_) => ShoppingCart());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => Chat());
      case '/Login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/Favourite':
        return MaterialPageRoute(builder: (_) => Favourite());
      case '/Notifications':
        return MaterialPageRoute(builder: (_) => UserNotification());
      case '/FAQ':
        return MaterialPageRoute(builder: (_) => Faq());
      case '/About':
        return MaterialPageRoute(builder: (_) => About());
      case '/Policies':
        return MaterialPageRoute(builder: (_) => Policies(policiesData: args));
      case '/UserPoints':
        return MaterialPageRoute(builder: (_) => UserPoints());
      case '/UserWallet':
        return MaterialPageRoute(builder: (_) => UserWallet());
      case '/PersonalInformation':
        return MaterialPageRoute(builder: (_) => PersonalInformation());
      default:
        return null;
    }
  }
}
