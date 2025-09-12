import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_event.dart';
import '../constants/constants.dart';

class AdjustHelper {
  void pushAdjustAddToCartEvents({
    required String isoCountryCode,
    required String price,
    required String productName,
    required String productId,
    required String quantity,
  }) {
    final AdjustEvent adjustEvent = AdjustEvent(Constants.adjustAddToCart);
    adjustEvent.addPartnerParameter("isoCountryCode", isoCountryCode);
    adjustEvent.addPartnerParameter("productName", productName);
    adjustEvent.addPartnerParameter("productId", productId);
    adjustEvent.addPartnerParameter("quantity", quantity);
    adjustEvent.addPartnerParameter("price", price);
    Adjust.trackEvent(adjustEvent);
  }

  void pushAdjustEvents({required String eventToken}) {
    final AdjustEvent adjustEvent = AdjustEvent(eventToken);
    Adjust.trackEvent(adjustEvent);
  }

  void pushAdjustPurchaseEvents({
    required double total,
    required String currency,
  }) {
    final AdjustEvent adjustEvent = AdjustEvent(Constants.adjustPurchases);
    adjustEvent.setRevenue(total, currency);
    Adjust.trackEvent(adjustEvent);
  }

  void pushAdjustEventsWithValue({
    required String eventToken,
    required String value,
    required String key,
  }) {
    final AdjustEvent adjustEvent = AdjustEvent(eventToken);
    adjustEvent.addPartnerParameter(key, value);
    Adjust.trackEvent(adjustEvent);
  }
}
