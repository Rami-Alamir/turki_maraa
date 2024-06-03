import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';
import '../models/adha_config.dart';

class AdhaRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<AdhaConfig?> getAdhaConfig() async {
    final response =
        await _helper.get4("https://almaraacompany.com/dashboard/adha.json");
    AdhaConfig? adhaConfig;
    try {
      adhaConfig = AdhaConfig.fromJson(response);
    } catch (_) {}
    return adhaConfig;
  }
}
