import 'dart:convert';
import '../core/service/networking/api_base_helper.dart';

class PaymentRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> updateOrderPayment(body, String authorization) async {
    final response = await _helper.post4(
        "customers/tabby-manual-payment/update", json.encode(body),
        authorization: authorization);
    return response;
  }
}
