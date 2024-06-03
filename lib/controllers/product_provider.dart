import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/utilities/calculate_helper.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/product_details.dart';
import '../models/product.dart';
import '../repository/products_repository.dart';

class ProductProvider with ChangeNotifier {
  final List<RequestStatus> _requestStatus = [];
  final List<Product> _similarProductsList = [];
  final List<ProductDetails> _productData = [];
  int _selectedSize = -1;
  int _selectedPackaging = -1;
  int _selectedChopping = -1;
  int _selectedDay = -1;
  bool _selectedShalwata = false;
  bool _isFavourite = false;
  bool _withoutTrotters = false;
  bool _withoutHead = false;
  bool _withoutTailFat = false;
  bool _withoutTripe = false;
  LatLng? _latLng;
  String? _isoCountryCode;

  int get selectedDay => _selectedDay;

  set selectedDay(int value) {
    _selectedDay = value;
    notifyListeners();
  }

  bool get withoutHead => _withoutHead;
  bool get withoutTailFat => _withoutTailFat;
  bool get withoutTripe => _withoutTripe;
  bool get withoutTrotters => _withoutTrotters;
  bool get isFavourite => _isFavourite;
  List<RequestStatus> get requestStatus => _requestStatus;
  int get selectedSize => _selectedSize;
  List<ProductDetails> get productData => _productData;
  List<Product> get similarProductsList => _similarProductsList;
  int get selectedPackaging => _selectedPackaging;
  int get selectedChopping => _selectedChopping;
  bool get selectedShalwata => _selectedShalwata;

  set withoutTrotters(bool value) {
    _withoutTrotters = value;
    notifyListeners();
  }

  set withoutHead(bool value) {
    _withoutHead = value;
    notifyListeners();
  }

  set withoutTailFat(bool value) {
    _withoutTailFat = value;
    notifyListeners();
  }

  set withoutTripe(bool value) {
    _withoutTripe = value;
    notifyListeners();
  }

  set setSelectedShalwata(bool value) {
    _selectedShalwata = value;
    notifyListeners();
  }

  set setSelectedChopping(int value) {
    _selectedChopping = value;
    notifyListeners();
  }

  set setSelectedPackaging(int value) {
    _selectedPackaging = value;
    notifyListeners();
  }

  set setSelectedSize(int value) {
    _selectedSize = value;
    notifyListeners();
  }

  set setIsFavourite(bool value) {
    _isFavourite = value;
  }

  set setIsFavouriteWithNotify(bool value) {
    _isFavourite = value;
    notifyListeners();
  }

  void initLoading(index) {
    _requestStatus.insert(index, RequestStatus.isLoading);
  }

  void setProductIsLoading(int index) {
    _requestStatus[index] = RequestStatus.isLoading;
    notifyListeners();
  }

  // get Similar Products
  Future<void> getSimilarProducts(int index, String id) async {
    try {
      Product products = Product();
      _similarProductsList.insert(index, products);
      _similarProductsList[index] = await sl<ProductsRepository>()
          .getProductsList(id, _latLng!, _isoCountryCode!);
      notifyListeners();
    } catch (_) {}
  }

  // get Product details
  Future<void> getProductData(String id, int index, bool isNew) async {
    _requestStatus[index] = RequestStatus.isLoading;
    try {
      ProductDetails product;
      if (isNew) {
        _productData.insert(index, ProductDetails());
      }
      product = await sl<ProductsRepository>()
          .getProduct(id, _latLng!, _isoCountryCode!);
      _productData[index] = product;
      if (_productData[index].data!.sizes!.length == 1) _selectedSize = 0;
      _requestStatus[index] = RequestStatus.completed;
    } catch (_) {
      _requestStatus[index] = RequestStatus.error;
    }
    notifyListeners();
  }

  void initExtras() {
    _selectedDay = -1;
    _selectedSize = -1;
    _selectedChopping = -1;
    _selectedPackaging = -1;
    _selectedShalwata = false;
    _withoutHead = false;
    _withoutTrotters = false;
    _withoutTripe = false;
    _withoutTailFat = false;
  }

  String getProductWeight(int index) {
    String weight = _productData[index].data!.weight!;
    if (_selectedSize >= 0) {
      if (_productData[index].data!.sizes![_selectedSize].weight!.isNotEmpty) {
        weight = _productData[index].data!.sizes![_selectedSize].weight!;
      }
    }
    return weight;
  }

  double getProductPrice(int index) {
    return sl<CalculateHelper>().getProductPrice(
        productData: _productData[index],
        selectedSize: _selectedSize,
        selectedPackaging: _selectedPackaging,
        selectedChopping: _selectedChopping,
        selectedShalwata: _selectedShalwata);
  }

  double getProductSalePrice(int index) {
    return sl<CalculateHelper>().getProductSalePrice(
        productData: _productData[index],
        selectedSize: _selectedSize,
        selectedPackaging: _selectedPackaging,
        selectedChopping: _selectedChopping,
        selectedShalwata: _selectedShalwata);
  }

  Future<void> updateLocation(
    LatLng? latLng,
    String? isoCountryCode,
  ) async {
    if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _isoCountryCode = isoCountryCode;
      }
    }
  }
}
