import 'dart:convert';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class PaymentRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<dynamic> updateOrderPayment(body, String authorization) async {
    final response = await _helper.post4(
        "customers/tabby-manual-payment/update", json.encode(body),
        authorization: authorization);
    return response;
  }
}