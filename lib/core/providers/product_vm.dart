import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lightsonheights/core/enums/view_state.dart';
import 'package:lightsonheights/core/helpers/log_state.dart';
import 'package:lightsonheights/core/models/product_category.dart';
import 'package:lightsonheights/core/models/product_model.dart';

enum SortEnum { recommended, alphaAsc, alphaDesc, lowPrice, highPrice }

enum FilterMethod { category, price }

enum PriceRanges {
  below1000,
  between1000And2000,
  between2000And3000,
  between3000And4000,
  above4000
}

class ProductVM extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ViewState _paginatedState = ViewState.idle;
  ViewState get paginatedState => _paginatedState;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  List<ProductModel> _searchProducts = [];
  List<ProductModel> get searchProducts => _searchProducts;

  final List<ProductModel> _trendingProducts = [];
  List<ProductModel> get trendingProducts => _trendingProducts;

  ProductCategory? _category;
  ProductCategory? get category => _category;

  PriceRanges? _priceRange;
  PriceRanges? get priceRange => _priceRange;

  List<SortEnum> get sortEnumValues => SortEnum.values;
  SortEnum selectedSort = SortEnum.recommended;

  int pageNumber = 1;
  List<ProductModel> _productResponse = [];

  Random random = Random();

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setFilterCategory(ProductCategory category) {
    _category = category;
    notifyListeners();
  }

  void setFilterPriceRange(PriceRanges priceRange) {
    _priceRange = priceRange;
    notifyListeners();
  }

  void setPaginationState(ViewState state) {
    _paginatedState = state;
    notifyListeners();
  }

  Future<List<ProductModel>> getProducts() async {
    setState(ViewState.busy);
    await Future.delayed(const Duration(seconds: 2));

    _productResponse = ProductModel.getAllFashionProducts();

    if (pageNumber == 1 &&
        _productResponse.isNotEmpty &&
        _productResponse.length > 10) {
      _products = _productResponse.take(10).toList();
    } else {
      _products.addAll(_productResponse);
    }
    pageNumber++;
    setState(ViewState.completed);
    return _products;
  }

  Future<List<ProductModel>> getMoreProducts() async {
    setPaginationState(ViewState.busy);
    await Future.delayed(const Duration(seconds: 2));

    List<ProductModel> pageProducts = [];

    if (pageNumber == 2 &&
        _productResponse.isNotEmpty &&
        _productResponse.length > 20) {
      pageProducts = _productResponse.skip(9).take(10).toList();
      _products.addAll(pageProducts);
    } else if (pageNumber == 3 &&
        _productResponse.isNotEmpty &&
        _productResponse.length > 30) {
      pageProducts = _productResponse.skip(19).take(10).toList();
      _products.addAll(pageProducts);
    } else if (pageNumber == 4 &&
        _productResponse.isNotEmpty &&
        _productResponse.length > 40) {
      pageProducts = _productResponse.skip(29).take(10).toList();
      _products.addAll(pageProducts);
    } else {
      _products = _productResponse;
    }
    Console.log("Page Number: $pageNumber");
    Console.log("_products Number: ${_products.length}");
    pageNumber++;
    setPaginationState(ViewState.completed);
    return _products;
  }

  Future<List<ProductModel>> getTrendingProducts() async {
    setState(ViewState.busy);
    await Future.delayed(const Duration(seconds: 2), () {
      setState(ViewState.completed);
    });

    List<ProductModel> result = ProductModel.getAllFashionProducts();

    for (int i = 0; i < 4; i++) {
      int randomNumber = random.nextInt(result.length);
      _trendingProducts.add(result[randomNumber]);
    }

    return _trendingProducts;
  }

  Future<List<ProductModel>> getProductsByCategory(
      ProductCategory category) async {
    setState(ViewState.busy);
    await Future.delayed(const Duration(seconds: 2));
    List<ProductModel> result = ProductModel.getAllFashionProducts()
        .where((product) => product.category == category)
        .toList();
    _products = result;
    setState(ViewState.completed);
    return _products;
  }

  Future<List<ProductModel>> getProductsBySearch(String search) async {
    setState(ViewState.busy);

    await Future.delayed(const Duration(seconds: 2));
    List<ProductModel> result = ProductModel.getAllFashionProducts()
        .where((product) => product.name!.contains(search))
        .toList();

    _searchProducts = result;

    setState(ViewState.completed);

    return _searchProducts;
  }

  Future<List<ProductModel>> getProductsByPriceRange(
      PriceRanges priceRange) async {
    setState(ViewState.busy);

    int min = 0;
    int max = 0;

    if (priceRange == PriceRanges.below1000) {
      min = 0;
      max = 1000;
    } else if (priceRange == PriceRanges.between1000And2000) {
      min = 1000;
      max = 2000;
    } else if (priceRange == PriceRanges.between2000And3000) {
      min = 2000;
      max = 3000;
    } else if (priceRange == PriceRanges.between3000And4000) {
      min = 3000;
      max = 4000;
    } else {
      min = 4000;
      max = 100000;
    }

    await Future.delayed(const Duration(seconds: 2));

    List<ProductModel> result = ProductModel.getAllFashionProducts()
        .where((product) =>
            double.parse(product.salesPrice!) >= min ||
            double.parse(product.salesPrice!) <= max)
        .toList();

    _products = result;
    Console.log("Products: ${_products.length}");
    setState(ViewState.completed);
    return _products;
  }

  // getProductsByPriceRangeAndCategory(var objectModel) {
  //   // console log the type of objectModel
  //   Console.log("objectModel: $objectModel");
  //   if (objectModel is ProductCategory) getProductsByCategory(objectModel);
  //   if (objectModel is PriceRanges) getProductsByPriceRange(objectModel);
  // }

  void setSelectedSortedProducts(SortEnum sort) {
    switch (sort) {
      case SortEnum.lowPrice:
        selectedSort = SortEnum.lowPrice;

        if (products.any((element) => element.salesPrice == null)) {
          products.sort(
            (a, b) => a.id!.compareTo(b.id!),
          );
          notifyListeners();
          break;
        }

        products.sort(
          (a, b) => a.salesPrice!.compareTo(b.salesPrice!),
        );

        notifyListeners();
        break;

      case SortEnum.highPrice:
        selectedSort = SortEnum.highPrice;

        if (products.any((element) => element.salesPrice == null)) {
          products.sort(
            (a, b) => a.id!.compareTo(b.id!),
          );
          notifyListeners();
          break;
        }

        products.sort(
          (a, b) => b.salesPrice!
              .toLowerCase()
              .compareTo(a.salesPrice!.toLowerCase()),
        );

        notifyListeners();
        break;

      case SortEnum.alphaAsc:
        selectedSort = SortEnum.alphaAsc;
        products.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        notifyListeners();
        break;

      case SortEnum.alphaDesc:
        selectedSort = SortEnum.alphaDesc;
        products.sort(
          (a, b) => b.name!.compareTo(a.name!),
        );
        notifyListeners();
        break;

      default:
        selectedSort = SortEnum.recommended;
        products.sort(
          (a, b) => a.id!.compareTo(b.id!),
        );
        notifyListeners();
        break;
    }
  }
}
