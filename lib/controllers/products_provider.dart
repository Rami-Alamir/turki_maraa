import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/service/service_locator.dart';
import '../models/banners_data.dart';
import '../models/discover_data.dart';
import '../models/discover_item.dart' as discover_item;
import '../models/product_details.dart';
import '../models/product.dart';
import '../repository/home_repository.dart';
import '../repository/products_repository.dart';

class ProductsProvider with ChangeNotifier {
  bool _foodsIsLoading = true;
  final List<bool> _productIsLoading = [];
  final List<bool> _productIsRetry = [];
  bool _discoverIsLoading = true;
  int _selectedSize = -1;
  int _selectedPackaging = -1;
  int _selectedChopping = -1;
  bool _selectedShalwata = false;
  bool _foodsRetry = false;
  bool _discoverRetry = false;
  final _bannersList = [];
  BannersData? _bannersData;
  Product? _productsList;
  final List<Product> _similarProductsList = [];
  final List<ProductDetails> _productData = [];
  DiscoverData? _discoverData;
  bool _isFavourite = false;
  discover_item.DiscoverItem? _discoverItem;
  bool _withoutTrotters = false;
  bool _withoutHead = false;
  bool _withoutTailFat = false;
  bool _withoutTripe = false;
  LatLng? _latLng;
  String? _isoCountryCode;
  bool get withoutHead => _withoutHead;
  bool get withoutTailFat => _withoutTailFat;
  bool get withoutTripe => _withoutTripe;
  bool get withoutTrotters => _withoutTrotters;
  BannersData? get bannersData => _bannersData;
  bool get isFavourite => _isFavourite;
  List<bool> get productIsRetry => _productIsRetry;
  List<bool> get productIsLoading => _productIsLoading;
  int get selectedSize => _selectedSize;
  bool get discoverIsLoading => _discoverIsLoading;
  bool get discoverRetry => _discoverRetry;
  bool get foodsIsLoading => _foodsIsLoading;
  get bannersList => _bannersList;
  bool get foodsRetry => _foodsRetry;
  List<ProductDetails> get productData => _productData;
  Product get productsList => _productsList!;
  List<Product> get similarProductsList => _similarProductsList;
  DiscoverData? get discoverData => _discoverData;
  int get selectedPackaging => _selectedPackaging;
  int get selectedChopping => _selectedChopping;
  bool get selectedShalwata => _selectedShalwata;
  discover_item.DiscoverItem get discoverItem => _discoverItem!;

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

  void initLoading(index) {
    _productIsLoading.insert(index, true);
    _productIsRetry.insert(index, false);
  }

  void setProductIsLoading(bool value, int index) {
    _productIsLoading[index] = value;
    _productIsRetry[index] = false;
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

  set setIsFavourite2(bool value) {
    _isFavourite = value;
    notifyListeners();
  }

  void disposeFood() {
    _foodsIsLoading = true;
    _discoverData = null;
    _bannersList.clear();
    _foodsRetry = false;
  }

  Future<void> getFoodsPageData(int id, {bool isLoading = true}) async {
    _foodsRetry = false;
    _foodsIsLoading = isLoading;
    try {
      await Future.wait([
        _getDiscoverList(id),
        _getBanners(id),
        _getProducts("$id"),
      ]);
    } catch (e) {
      _foodsRetry = true;
    }
    _foodsIsLoading = false;
    notifyListeners();
  }

  Future<void> _getDiscoverList(int categoryId) async {
    _discoverData = null;
    try {
      _discoverData = await sl<HomeRepository>()
          .getDiscover(categoryId, _latLng!, _isoCountryCode!);
    } catch (_) {
      //  _foodsRetry = true;
    }
  }

  Future<void> _getBanners(int categoryId) async {
    try {
      _bannersData = await sl<HomeRepository>()
          .getBannersList(categoryId, _latLng!, _isoCountryCode!);
    } catch (_) {
      _foodsRetry = true;
    }
  }

  // get Products
  Future<void> _getProducts(String id) async {
    try {
      _productsList = await sl<ProductsRepository>()
          .getProductsList(id, _latLng!, _isoCountryCode!);
    } catch (_) {
      _foodsRetry = true;
    }
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
    _productIsLoading[index] = true;
    _productIsRetry[index] = false;
    try {
      ProductDetails product;
      if (isNew) {
        _productData.insert(index, ProductDetails());
      }
      product = await sl<ProductsRepository>()
          .getProduct(id, _latLng!, _isoCountryCode!);
      _productData[index] = product;
      if (_productData[index].data!.sizes!.length == 1) _selectedSize = 0;
    } catch (_) {
      _productIsRetry[index] = true;
    }
    _productIsLoading[index] = false;
    notifyListeners();
  }

  // used in product details
  void initExtras() {
    _selectedSize = -1;
    _selectedChopping = -1;
    _selectedPackaging = -1;
    _selectedShalwata = false;
    _withoutHead = false;
    _withoutTrotters = false;
    _withoutTripe = false;
    _withoutTailFat = false;
  }

  //get discover item Data
  Future<void> getDiscoverItem(int id) async {
    _discoverIsLoading = true;
    _discoverRetry = false;
    try {
      _discoverItem = await sl<HomeRepository>()
          .getDiscoverItem(id, _latLng!, _isoCountryCode!);
    } catch (_) {
      _discoverRetry = true;
    }
    _discoverIsLoading = false;
    notifyListeners();
  }

  // used in product details
  String getProductWeight(int index) {
    String weight = _productData[index].data!.weight!;
    if (_selectedSize >= 0) {
      if (_productData[index].data!.sizes![_selectedSize].weight!.isNotEmpty) {
        weight = _productData[index].data!.sizes![_selectedSize].weight!;
      }
    }
    return weight;
  }

  // used in product details
  double getProductPrice(int index) {
    double price = double.parse(_productData[index].data!.price!);
    if (_selectedSize >= 0) {
      price =
          double.parse(_productData[index].data!.sizes![_selectedSize].price!);
    }
    if (_selectedPackaging >= 0) {
      price += double.parse(
          _productData[index].data!.packaging![_selectedPackaging].price!);
    }
    if (_selectedChopping >= 0) {
      price += double.parse(
          _productData[index].data!.chopping![_selectedChopping].price!);
    }
    if (_selectedShalwata) {
      price += double.parse(_productData[index].data!.shalwata!.price!);
    }
    return price;
  }

  // used in product details
  double getProductSalePrice(int index) {
    double price = double.parse(_productData[index].data!.salePrice!);
    if (_selectedSize >= 0) {
      if (double.parse(
              _productData[index].data!.sizes![_selectedSize].salePrice!) >
          0) {
        price = double.parse(
            _productData[index].data!.sizes![_selectedSize].salePrice!);
      } else {
        price = double.parse(
            _productData[index].data!.sizes![_selectedSize].price!);
      }
    }
    if (_selectedPackaging >= 0) {
      if (double.parse(_productData[index]
              .data!
              .packaging![_selectedPackaging]
              .salePrice!) >
          0) {
        price += double.parse(_productData[index]
            .data!
            .packaging![_selectedPackaging]
            .salePrice!);
      } else {
        price += double.parse(
            _productData[index].data!.packaging![_selectedPackaging].price!);
      }
    }
    if (_selectedChopping >= 0) {
      if (double.parse(_productData[index]
              .data!
              .chopping![_selectedChopping]
              .salePrice!) >
          0) {
        price += double.parse(
            _productData[index].data!.chopping![_selectedChopping].salePrice!);
      } else {
        price += double.parse(
            _productData[index].data!.chopping![_selectedChopping].price!);
      }
    }
    if (_selectedShalwata) {
      price += double.parse(_productData[index].data!.shalwata!.price!);
    }
    return price;
  }

  // update location data
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
