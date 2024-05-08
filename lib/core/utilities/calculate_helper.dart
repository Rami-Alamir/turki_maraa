import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'size_config.dart';
import '../../models/order.dart';
import '../../models/product_details.dart';
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

  double getProductPrice(
      {required ProductDetails productData,
      required int selectedSize,
      required int selectedPackaging,
      required int selectedChopping,
      required bool selectedShalwata}) {
    double price = double.parse(productData.data!.price!);
    if (selectedSize >= 0) {
      price = double.parse(productData.data!.sizes![selectedSize].price!);
    }
    if (selectedPackaging >= 0) {
      price +=
          double.parse(productData.data!.packaging![selectedPackaging].price!);
    }
    if (selectedChopping >= 0) {
      price +=
          double.parse(productData.data!.chopping![selectedChopping].price!);
    }
    if (selectedShalwata) {
      price += double.parse(productData.data!.shalwata!.price!);
    }
    return price;
  }

  double getProductSalePrice(
      {required ProductDetails productData,
      required int selectedSize,
      required int selectedPackaging,
      required int selectedChopping,
      required bool selectedShalwata}) {
    double price = double.parse(productData.data!.salePrice!);
    if (selectedSize >= 0) {
      if (double.parse(productData.data!.sizes![selectedSize].salePrice!) > 0) {
        price = double.parse(productData.data!.sizes![selectedSize].salePrice!);
      } else {
        price = double.parse(productData.data!.sizes![selectedSize].price!);
      }
    }
    if (selectedPackaging >= 0) {
      if (double.parse(
              productData.data!.packaging![selectedPackaging].salePrice!) >
          0) {
        price += double.parse(
            productData.data!.packaging![selectedPackaging].salePrice!);
      } else {
        price += double.parse(
            productData.data!.packaging![selectedPackaging].price!);
      }
    }
    if (selectedChopping >= 0) {
      if (double.parse(
              productData.data!.chopping![selectedChopping].salePrice!) >
          0) {
        price += double.parse(
            productData.data!.chopping![selectedChopping].salePrice!);
      } else {
        price +=
            double.parse(productData.data!.chopping![selectedChopping].price!);
      }
    }
    if (selectedShalwata) {
      price += double.parse(productData.data!.shalwata!.price!);
    }
    return price;
  }

  int orderItems(List<Products>? products) {
    int count = 0;
    for (int i = 0; i < (products?.length ?? 0); i++) {
      count += products![i].quantity!;
    }
    return count;
  }

  double calculateDistance(LatLng? latLng, LatLng? locationData) {
    double distance = 1000;
    if (locationData != null && latLng != null) {
      try {
        distance = Geolocator.distanceBetween(locationData.latitude,
                locationData.longitude, latLng.latitude, latLng.longitude) /
            1000;
      } catch (_) {}
    }
    return distance;
  }
}
