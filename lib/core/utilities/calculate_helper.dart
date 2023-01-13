import 'size_config.dart';
import '../../models/cart_data.dart';

class CalculateHelper {
  // used to calculate value of offset in shopping cart
  double calculateOffset(int length) {
    double offset = length * (SizeConfig.screenWidth! < 600 ? 140 : 165);
    offset += 100;
    return offset;
  }

  double getCartItemTotalPrice(ItemData data) {
    double price = 0.0;
    if (data.size == null) {
      if (data.product!.salePrice! > 0.0) {
        price += data.product!.salePrice!;
      } else {
        price += data.product!.price!;
      }
    } else {
      if (double.parse(data.size!.salePrice!) > 0.0) {
        price += double.parse(data.size!.salePrice!);
      } else {
        price += double.parse(data.size!.price!);
      }
    }
    if (data.shalwata != null) {
      price += double.parse(data.shalwata!.price!);
    }
    return price;
  }

  int calculateCartLength(List<ItemData?>? list) {
    int cartLength = 0;
    for (int i = 0; i < ((list?.length) ?? 0); i++) {
      cartLength += list![i]!.quantity!;
    }
    return cartLength;
  }
}
