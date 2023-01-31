import '../models/tabby_captures.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';
import '../core/constants/constants.dart';

class TabbyRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<TabbyCaptures?> capturePayment(
      body, String merchantCode, String id) async {
    final response = await _helper.post5(
      url: "${Constants.tabbyBaseUrl}payments/$id/captures",
      body: body,
      merchantCode: merchantCode,
    );
    TabbyCaptures? tabbyCaptures;
    try {
      tabbyCaptures = TabbyCaptures.fromJson(response);
    } catch (_) {}
    return tabbyCaptures;
  }
}
