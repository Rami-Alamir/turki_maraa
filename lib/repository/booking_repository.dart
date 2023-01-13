import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';
import '../models/delivery_period.dart';

class BookingRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<DeliveryPeriod> getDeliveryPeriods() async {
    final response = await _helper.get("delivery-period");
    DeliveryPeriod? deliveryPeriod;
    try {
      deliveryPeriod = DeliveryPeriod.fromJson(response);
    } catch (_) {}
    return deliveryPeriod!;
  }
}
