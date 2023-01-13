import '../models/tamara_data.dart';
import '../core/service/networking/api_base_helper.dart';

class TamaraRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<TamaraData> getTamaraStatus(
      String countryIsoCode, String currencyCode, String orderValue) async {
    final response = await _helper.get(
        "payment-types/get-payment-types-Tamara?countryIsoCode=$countryIsoCode&currencyCode=$currencyCode&orderValue=$orderValue");
    TamaraData? tamaraData;
    try {
      tamaraData = TamaraData.fromJson(response);
    } catch (_) {}
    return tamaraData!;
  }
}
