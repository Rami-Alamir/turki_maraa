import 'package:new_turki/networking/api_base_helper.dart';

import '../models/delivery_period.dart';

class BookingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Delivery periods
  Future<DeliveryPeriod> getDeliveryPeriods() async {
    print('getDeliveryPeriods');
    final response = await _helper.get("delivery-period");
    DeliveryPeriod? deliveryPeriod;
    try {
      deliveryPeriod = DeliveryPeriod.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return deliveryPeriod!;
  }
}
