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

class TabItem {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;
  late Widget _page;

  TabItem({
    required Widget page,
  }) {
    _page = page;
  }

  // used to set the index of this tab
  // which will be used in identifying if this tab is active
  void setIndex(int i) {
    _index = i;
  }

  int getIndex() => _index;

  // adds a wrapper around the page widgets for visibility
  // visibility widget removes unnecessary problems
  // like interactivity and animations when the page is inactive
  Widget get page {
    return Visibility(
      // only paint this page when currentTab is active
      visible: _index == AppState.currentTab,
      // important to preserve state while switching between tabs
      maintainState: true,
      child: Navigator(
        // key tracks state changes
        key: key,
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.arguments;
          print(settings.arguments.toString());
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => _page);
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
              return MaterialPageRoute(
                  builder: (_) => Policies(policiesData: args));
            case '/UserPoints':
              return MaterialPageRoute(builder: (_) => UserPoints());
            case '/UserWallet':
              return MaterialPageRoute(builder: (_) => UserWallet());
            case '/PersonalInformation':
              return MaterialPageRoute(builder: (_) => PersonalInformation());
            default:
              return null;
          }
        },
      ),
    );
  }
}
