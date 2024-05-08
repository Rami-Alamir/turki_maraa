import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';
import '../models/promotions.dart';

class PromotionsRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<Promotions> getPromotions() async {
    final response = await _helper.get("promotions");
    Promotions? promotions;
    try {
      promotions = Promotions.fromJson(response);
    } catch (_) {}
    return promotions!;
  }
}
