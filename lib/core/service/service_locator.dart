import 'package:get_it/get_it.dart';
import 'networking/api_base_helper.dart';
import '../utilities/calculate_helper.dart';
import '../utilities/dialog_helper.dart';
import '../utilities/format_helper.dart';
import '../utilities/get_color_by_status.dart';
import '../utilities/get_strings.dart';
import '../utilities/hms_latlng_converter.dart';
import '../utilities/locals_values.dart';
import '../utilities/show_snack_bar.dart';
import '../utilities/size_config.dart';
import '../../repository/booking_repository.dart';
import '../../repository/cart_repository.dart';
import '../../repository/favourite_repository.dart';
import '../../repository/home_repository.dart';
import '../../repository/order_repository.dart';
import '../../repository/payment_repository.dart';
import '../../repository/products_repository.dart';
import '../../repository/login_repository.dart';
import '../../repository/search_repository.dart';
import '../../repository/tamara_repository.dart';
import '../../repository/user_repository.dart';
import '../../repository/version_repository.dart';
import '../../repository/promotions_repository.dart';
import '../../repository/tabby_repository.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton(() => BookingRepository());
    sl.registerLazySingleton(() => CartRepository());
    sl.registerLazySingleton(() => FavouriteRepository());
    sl.registerLazySingleton(() => HomeRepository());
    sl.registerLazySingleton(() => OrderRepository());
    sl.registerLazySingleton(() => PromotionsRepository());
    sl.registerLazySingleton(() => PaymentRepository());
    sl.registerLazySingleton(() => ProductsRepository());
    sl.registerLazySingleton(() => LoginRepository());
    sl.registerLazySingleton(() => SearchRepository());
    sl.registerLazySingleton(() => TamaraRepository());
    sl.registerLazySingleton(() => TabbyRepository());
    sl.registerLazySingleton(() => UserRepository());
    sl.registerLazySingleton(() => VersionRepository());
    sl.registerLazySingleton(() => ApiBaseHelper());
    sl.registerLazySingleton(() => CalculateHelper());
    sl.registerLazySingleton(() => DialogHelper());
    sl.registerLazySingleton(() => FormatHelper());
    sl.registerLazySingleton(() => GetColorByStatus());
    sl.registerLazySingleton(() => GetStrings());
    sl.registerLazySingleton(() => LocalsValues());
    sl.registerLazySingleton(() => HMSLatLngConverter());
    sl.registerLazySingleton(() => ShowSnackBar());
    sl.registerLazySingleton(() => SizeConfig());
  }
}
