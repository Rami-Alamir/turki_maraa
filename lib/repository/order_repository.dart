import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/models/orders_data.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class OrderRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //add to cart
  Future<int> placeOrder(body, String authorization) async {
    print('orders/add-order');
    print(body.toString());
    final response = await _helper.post2("orders/add-order", body,
        authorization: authorization);
    return response;
  }

  //get cart list
  Future<OrdersData> getOrdersList(String authorization) async {
    final response = await _helper.get("orders", authorization: authorization);
    OrdersData? ordersData;
    try {
      ordersData = OrdersData.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return ordersData!;
  }
}
