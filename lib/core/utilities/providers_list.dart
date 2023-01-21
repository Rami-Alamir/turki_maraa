import 'package:provider/provider.dart';
import '../../controllers/discover_provider.dart';
import '../../controllers/drawer_provider.dart';
import '../../controllers/auth.dart';
import '../../controllers/address_provider.dart';
import '../../controllers/app_language.dart';
import '../../controllers/app_theme.dart';
import '../../controllers/cart_provider.dart';
import '../../controllers/favourite_provider.dart';
import '../../controllers/home_provider.dart';
import '../../controllers/location_provider.dart';
import '../../controllers/orders_provider.dart';
import '../../controllers/product_provider.dart';
import '../../controllers/products_provider.dart';
import '../../controllers/search_provider.dart';
import '../../controllers/user_provider.dart';

class ProvidersList {
  static providersList() {
    return [
      ChangeNotifierProvider<Auth>(create: (context) => Auth()),
      ChangeNotifierProvider<DrawerProvider>(
          create: (context) => DrawerProvider()),
      ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider()),
      ChangeNotifierProxyProvider<Auth, UserProvider>(
          create: (context) => UserProvider(),
          update: (_, auth, user) => user!..updateUserData(auth.userData)),
      ChangeNotifierProxyProvider<Auth, AddressProvider>(
          create: (context) => AddressProvider(),
          update: (_, auth, user) =>
              user!..updateAddressProvider(auth.isAuth, auth.accessToken)),
      ChangeNotifierProxyProvider<Auth, OrdersProvider>(
          create: (context) => OrdersProvider(),
          update: (_, auth, orders) =>
              orders!..updateOrderProvider(auth.accessToken, auth.isAuth)),
      ChangeNotifierProxyProvider<LocationProvider, HomeProvider>(
          create: (context) => HomeProvider(),
          update: (_, location, home) => home!
            ..updateLocation(
                location.latLng,
                location.isoCountryCode,
                location.locationServiceStatus,
                location.currentLocationDescriptionAr,
                location.currentLocationDescriptionEn,
                location.isHms)),
      ChangeNotifierProxyProvider<LocationProvider, SearchProvider>(
          create: (context) => SearchProvider(),
          update: (_, location, search) => search!
            ..updateLocation(
              location.latLng,
              location.isoCountryCode,
            )),
      ChangeNotifierProxyProvider<LocationProvider, ProductsProvider>(
          create: (context) => ProductsProvider(),
          update: (_, location, product) => product!
            ..updateLocation(
              location.latLng,
              location.isoCountryCode,
            )),
      ChangeNotifierProxyProvider<LocationProvider, ProductProvider>(
          create: (context) => ProductProvider(),
          update: (_, location, product) => product!
            ..updateLocation(
              location.latLng,
              location.isoCountryCode,
            )),
      ChangeNotifierProxyProvider<LocationProvider, DiscoverProvider>(
          create: (context) => DiscoverProvider(),
          update: (_, location, discover) => discover!
            ..updateLocation(
              location.latLng,
              location.isoCountryCode,
            )),
      ChangeNotifierProvider<AppLanguage>(create: (context) => AppLanguage()),
      ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
      ChangeNotifierProxyProvider2<Auth, LocationProvider, CartProvider>(
          create: (context) => CartProvider(),
          update: (_, auth, location, cart) => cart!
            ..updateCartProvider(
                auth.accessToken,
                auth.isAuth,
                location.latLng,
                auth.userData,
                location.isoCountryCode,
                location.currentLocationDescriptionAr,
                location.currentLocationDescriptionEn)),
      ChangeNotifierProxyProvider2<Auth, LocationProvider, FavouriteProvider>(
          create: (context) => FavouriteProvider(),
          update: (_, auth, location, favourite) => favourite!
            ..updateFavouriteProvider(auth.accessToken, auth.isAuth,
                location.latLng, location.isoCountryCode)),
    ];
  }
}
