import 'package:flutter/material.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/screens/cart/shopping_cart.dart';
import 'package:new_turki/screens/chat/chat.dart';
import 'package:new_turki/screens/home/add_new_address.dart';
import 'package:new_turki/screens/home/discover.dart';
import 'package:new_turki/screens/home/home.dart';
import 'package:new_turki/screens/home/products_home.dart';
import 'package:new_turki/screens/home/product_details.dart';
import 'package:new_turki/screens/home/products_list.dart';
import 'package:new_turki/screens/home/search.dart';
import 'package:new_turki/screens/orders/order_details.dart';
import 'package:new_turki/screens/orders/orders.dart';
import 'package:new_turki/screens/other/new_version.dart';
import 'package:new_turki/screens/other/no_internet.dart';
import 'package:new_turki/screens/other/success.dart';
import 'package:new_turki/screens/profile/about.dart';
import 'package:new_turki/screens/profile/add_credit.dart';
import 'package:new_turki/screens/profile/add_gift_card.dart';
import 'package:new_turki/screens/profile/faq.dart';
import 'package:new_turki/screens/favourite/favourite.dart';
import 'package:new_turki/screens/profile/login.dart';
import 'package:new_turki/screens/profile/notification.dart';
import 'package:new_turki/screens/profile/personal_information.dart';
import 'package:new_turki/screens/profile/phone_login.dart';
import 'package:new_turki/screens/profile/points.dart';
import 'package:new_turki/screens/profile/policies.dart';
import 'package:new_turki/screens/profile/profile.dart';
import 'package:new_turki/screens/profile/username.dart';
import 'package:new_turki/screens/profile/verify_phone.dart';
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
            case '/NoInternet':
              return MaterialPageRoute(builder: (_) => NoInternet());
            case '/NewVersion':
              return MaterialPageRoute(builder: (_) => NewVersion());
            case '/Home':
              return MaterialPageRoute(
                  builder: (_) => Home(
                        parentScaffoldStateKey:
                            args as GlobalKey<ScaffoldState>,
                      ));
            case '/ProductDetails':
              return MaterialPageRoute(
                  builder: (_) => ProductDetails(id: args as int));
            case '/Profile':
              return MaterialPageRoute(builder: (_) => Profile());
            case '/Orders':
              return MaterialPageRoute(
                  builder: (_) => Orders(back: args as bool));
            case '/OrderDetails':
              return MaterialPageRoute(
                  builder: (_) => OrderDetails(id: args as String));
            case '/Cart':
              return MaterialPageRoute(builder: (_) => ShoppingCart());
            case '/Chat':
              return MaterialPageRoute(builder: (_) => Chat());
            case '/Login':
              return MaterialPageRoute(builder: (_) => Login());
            case '/PhoneLogin':
              return MaterialPageRoute(builder: (_) => PhoneLogin());
            case '/VerifyPhone':
              return MaterialPageRoute(builder: (_) => VerifyPhone());
            case '/Username':
              return MaterialPageRoute(builder: (_) => Username());
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
            case '/AddCredit':
              return MaterialPageRoute(builder: (_) => AddCredit());
            case '/AddGiftCard':
              return MaterialPageRoute(builder: (_) => AddGiftCard());
            case '/ProductsHome':
              return MaterialPageRoute(
                  builder: (_) => ProductsHome(id: args as int));

            case '/AddNewAddress':
              return MaterialPageRoute(builder: (_) => AddNewAddress());
            case '/Search':
              return MaterialPageRoute(builder: (_) => Search());
            case '/Discover':
              return MaterialPageRoute(
                  builder: (_) => Discover(item: args as DiscoverItem));
            case '/ProductsList':
              return MaterialPageRoute(
                  builder: (_) =>
                      ProductsList(data: args as Map<String, dynamic>));
            case '/Success':
              return MaterialPageRoute(
                  builder: (_) => Success(
                        title: args as String,
                      ));
            default:
              return null;
          }
        },
      ),
    );
  }
}
