import 'package:new_turki/networking/api_base_helper.dart';
import '../models/tamara_data.dart';

class TamaraRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Tamara  Status
  Future<TamaraData> getTamaraStatus(
      String countryIsoCode, String currencyCode, String orderValue) async {
    final response = await _helper.get(
        "payment-types/get-payment-types-Tamara?countryIsoCode=$countryIsoCode&currencyCode=$currencyCode&orderValue=$orderValue");
    print('tamara ${response.toString()}');
    TamaraData? tamaraData;
    try {
      tamaraData = TamaraData.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return tamaraData!;
  }
}
