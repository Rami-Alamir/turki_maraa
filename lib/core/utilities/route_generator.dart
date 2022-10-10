import 'package:flutter/material.dart';
import '../../models/discover_data.dart';
import '../../presentation/screens/app/app.dart';
import '../../presentation/screens/cart/shopping_cart.dart';
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
import '../../presentation/screens/splash/splash.dart';
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
import '../service/firebase_helper.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    FirebaseHelper().pushAnalyticsEvent(
        name: 'route',
        value: settings.name!.substring(1).isEmpty
            ? 'Splash'
            : settings.name!.substring(1));
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/App':
        return MaterialPageRoute(builder: (_) => const App());
      case '/NoInternet':
        return MaterialPageRoute(builder: (_) => const NoInternet());
      case '/NewVersion':
        return MaterialPageRoute(builder: (_) => const NewVersion());
      case '/MyAddresses':
        return MaterialPageRoute(builder: (_) => const MyAddresses());
      case '/Home':
        return MaterialPageRoute(
            builder: (_) => Home(
                  parentScaffoldStateKey: args as GlobalKey<ScaffoldState>,
                ));
      case '/ProductDetails':
        return MaterialPageRoute(
            builder: (_) => ProductDetails(data: args as Map<String, dynamic>));
      case '/HomeCategories':
        return MaterialPageRoute(builder: (_) => const HomeCategories());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => const Profile());
      case '/UserPoints':
        return MaterialPageRoute(builder: (_) => const UserPoints());
      case '/UserWallet':
        return MaterialPageRoute(builder: (_) => const UserWallet());
      case '/AddCredit':
        return MaterialPageRoute(builder: (_) => const AddCredit());
      case '/AddGiftCard':
        return MaterialPageRoute(builder: (_) => const AddGiftCard());
      case '/Orders':
        return MaterialPageRoute(builder: (_) => Orders(back: args as bool));
      case '/Notifications':
        return MaterialPageRoute(builder: (_) => const UserNotification());
      case '/OrderDetails':
        return MaterialPageRoute(
            builder: (_) => OrderDetails(id: args as String));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => const ShoppingCart());
      case '/Login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/PhoneLogin':
        return MaterialPageRoute(builder: (_) => const PhoneLogin());
      case '/VerifyPhone':
        return MaterialPageRoute(builder: (_) => const VerifyPhone());
      case '/Username':
        return MaterialPageRoute(builder: (_) => const Username());
      case '/Favourite':
        return MaterialPageRoute(builder: (_) => const Favourite());
      case '/FAQ':
        return MaterialPageRoute(builder: (_) => const Faq());
      case '/About':
        return MaterialPageRoute(builder: (_) => const About());
      case '/OrderStatus':
        return MaterialPageRoute(
            builder: (_) => OrderStatus(status: args as bool));
      case '/Policies':
        return MaterialPageRoute(
            builder: (_) =>
                Policies(policiesData: args as Map<String, String>));
      case '/PersonalInformation':
        return MaterialPageRoute(builder: (_) => const PersonalInformation());
      case '/ProductsHome':
        return MaterialPageRoute(builder: (_) => ProductsHome(id: args as int));
      case '/HMSMap':
        return MaterialPageRoute(
            builder: (_) => HMSMap(
                  addressIndex: args as int,
                ));
      case '/GMSMap':
        return MaterialPageRoute(
            builder: (_) => GMSMap(
                  addressIndex: args as int,
                ));
      case '/Search':
        return MaterialPageRoute(builder: (_) => const Search());
      case '/Discover':
        return MaterialPageRoute(builder: (_) => Discover(item: args as Data));
      case '/ProductsList':
        return MaterialPageRoute(
            builder: (_) => ProductsList(data: args as Map<String, dynamic>));
      default:
        return null;
    }
  }
}
