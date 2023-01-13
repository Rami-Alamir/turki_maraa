import 'package:get_it/get_it.dart';
import '../../repository/booking_repository.dart';
import '../../repository/cart_repository.dart';
import '../../repository/favourite_repository.dart';
import '../../repository/home_repository.dart';
import '../../repository/order_repository.dart';
import '../../repository/payment_repository.dart';
import '../../repository/products_repository.dart';
import '../../repository/registration_repository.dart';
import '../../repository/search_repository.dart';
import '../../repository/tamara_repository.dart';
import '../../repository/user_repository.dart';
import '../../repository/version_repository.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton(() => BookingRepository());
    sl.registerLazySingleton(() => CartRepository());
    sl.registerLazySingleton(() => FavouriteRepository());
    sl.registerLazySingleton(() => HomeRepository());
    sl.registerLazySingleton(() => OrderRepository());
    sl.registerLazySingleton(() => PaymentRepository());
    sl.registerLazySingleton(() => ProductsRepository());
    sl.registerLazySingleton(() => RegistrationRepository());
    sl.registerLazySingleton(() => SearchRepository());
    sl.registerLazySingleton(() => TamaraRepository());
    sl.registerLazySingleton(() => UserRepository());
    sl.registerLazySingleton(() => VersionRepository());
  }
}
