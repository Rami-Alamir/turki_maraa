import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:turki_dabayh/presentation/screens/intro/intro.dart';
import '../constants/route_constants.dart';
import '../service/firebase_helper.dart';
import '../../models/discover_data.dart';
import '../../presentation/screens/app/app.dart';
import '../../presentation/screens/cart/tabby_checkout_page.dart';
import '../../presentation/screens/cart/shopping_cart.dart';
import '../../presentation/screens/cart/tamara_checkout_page.dart';
import '../../presentation/screens/home/discover.dart';
import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/home/products_home.dart';
import '../../presentation/screens/home/product_details.dart';
import '../../presentation/screens/home/products_list.dart';
import '../../presentation/screens/home/search.dart';
import '../../presentation/screens/orders/order_details.dart';
import '../../presentation/screens/orders/orders.dart';
import '../../presentation/screens/other/new_version.dart';
import '../../presentation/screens/other/no_internet.dart';
import '../../presentation/screens/profile/about.dart';
import '../../presentation/screens/profile/faq.dart';
import '../../presentation/screens/favourite/favourite.dart';
import '../../presentation/screens/profile/my_addresses.dart';
import '../../presentation/screens/profile/personal_information.dart';
import '../../presentation/screens/profile/phone_login.dart';
import '../../presentation/screens/profile/policies.dart';
import '../../presentation/screens/profile/profile.dart';
import '../../presentation/screens/profile/username.dart';
import '../../presentation/screens/profile/verify_phone.dart';
import '../../presentation/screens/cart/order_status.dart';
import '../../presentation/screens/home/home_categories.dart';
import '../../presentation/screens/map/gms_map.dart';
import '../../presentation/screens/map/hms_map.dart';
import '../../presentation/screens/profile/add_credit.dart';
import '../../presentation/screens/profile/add_gift_card.dart';
import '../../presentation/screens/profile/login.dart';
import '../../presentation/screens/profile/notification.dart';
import '../../presentation/screens/profile/points.dart';
import '../../presentation/screens/profile/wallet.dart';

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

  // adds a wrapper around the page widgets_old for visibility
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
          FirebaseHelper().pushAnalyticsEvent(
              name: 'route',
              value: settings.name!.substring(1).isEmpty
                  ? 'Splash'
                  : settings.name!.substring(1));

          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => _page);
            case app:
              return MaterialPageRoute(builder: (_) => const App());
            case noInternet:
              return MaterialPageRoute(builder: (_) => const NoInternet());
            case newVersion:
              return MaterialPageRoute(builder: (_) => const NewVersion());
            case myAddresses:
              return MaterialPageRoute(builder: (_) => const MyAddresses());
            case home:
              return MaterialPageRoute(
                  builder: (_) => Home(
                        parentScaffoldStateKey:
                            args as GlobalKey<ScaffoldState>,
                      ));
            case productDetails:
              return MaterialPageRoute(
                  builder: (_) =>
                      ProductDetails(data: args as Map<String, dynamic>));
            case intro:
              return MaterialPageRoute(builder: (_) => const Intro());
            case homeCategories:
              return MaterialPageRoute(builder: (_) => const HomeCategories());
            case profile:
              return MaterialPageRoute(builder: (_) => const Profile());
            case userPoints:
              return MaterialPageRoute(builder: (_) => const UserPoints());
            case userWallet:
              return MaterialPageRoute(builder: (_) => const UserWallet());
            case addCredit:
              return MaterialPageRoute(builder: (_) => const AddCredit());
            case addGiftCard:
              return MaterialPageRoute(builder: (_) => const AddGiftCard());
            case orders:
              return MaterialPageRoute(
                  builder: (_) => Orders(back: args as bool));
            case notifications:
              return MaterialPageRoute(
                  builder: (_) => const UserNotification());
            case orderDetails:
              return MaterialPageRoute(
                  builder: (_) => OrderDetails(id: args as String));
            case cart:
              return MaterialPageRoute(builder: (_) => const ShoppingCart());
            case login:
              return MaterialPageRoute(builder: (_) => const Login());
            case phoneLogin:
              return MaterialPageRoute(builder: (_) => const PhoneLogin());
            case verifyPhone:
              return MaterialPageRoute(builder: (_) => const VerifyPhone());
            case username:
              return MaterialPageRoute(builder: (_) => const Username());
            case favourite:
              return MaterialPageRoute(builder: (_) => const Favourite());
            case fAQ:
              return MaterialPageRoute(builder: (_) => const Faq());
            case about:
              return MaterialPageRoute(builder: (_) => const About());
            case orderStatus:
              return MaterialPageRoute(
                  builder: (_) => OrderStatus(status: args as bool));
            case tamaraCheckoutPage:
              return MaterialPageRoute(
                  builder: (_) => TamaraCheckoutPage(
                        checkoutUrl: args as String,
                      ));
            case tabbyCheckoutPage:
              return MaterialPageRoute(
                  builder: (_) => TabbyCheckoutPage(
                        session: args as TabbySession,
                      ));
            case policies:
              return MaterialPageRoute(
                  builder: (_) =>
                      Policies(policiesData: args as Map<String, String>));
            case personalInformation:
              return MaterialPageRoute(
                  builder: (_) => const PersonalInformation());
            case productsHome:
              return MaterialPageRoute(
                  builder: (_) => ProductsHome(id: args as int));
            case hmsMap:
              return MaterialPageRoute(
                  builder: (_) => HMSMap(
                        addressIndex: args as int,
                      ));
            case gmsMap:
              return MaterialPageRoute(
                  builder: (_) => GMSMap(
                        addressIndex: args as int,
                      ));
            case search:
              return MaterialPageRoute(builder: (_) => const Search());

            case discover:
              return MaterialPageRoute(
                  builder: (_) => Discover(item: args as Data));
            case productsList:
              return MaterialPageRoute(
                  builder: (_) =>
                      ProductsList(data: args as Map<String, dynamic>));
            default:
              return null;
          }
        },
      ),
    );
  }
}
