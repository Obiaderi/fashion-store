import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lightsonheights/core/enums/view_state.dart';
import 'package:lightsonheights/core/helpers/log_state.dart';
import 'package:lightsonheights/core/models/product_model.dart';

import '../models/product_category.dart';

class ProductCategoryVM extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;

  final List<ProductModel> _productUnderHomeCategory = [];
  List<ProductModel> get productsUnderHomeCategory => _productUnderHomeCategory;

  final List<ProductModel> _relatedProducts = [];
  List<ProductModel> get relatedProducts => _relatedProducts;

  ProductCategory _category = ProductCategory.getProductCategories().first;
  ProductCategory? get category => _category;

  int pageNumber = 1;

  Random random = Random();

  void setCategory(ProductCategory category) {
    _category = category;
    notifyListeners();
  }

  void setState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  Future<List<ProductModel>> getHomeProductsByCategory(
      ProductCategory category) async {
    Console.log("getHomeProductsByCategory");
    setState(ViewState.busy);
    setCategory(category);

    await Future.delayed(const Duration(seconds: 2));

    List<ProductModel> result = ProductModel.getAllFashionProducts()
        .where((product) => product.category == category)
        .toList();
    Console.log('result.length ${result.length}');
    _productUnderHomeCategory.clear();

    if (result.length > 4) {
      for (int i = 0; i < 4; i++) {
        int randomNumber = random.nextInt(result.length);
        _productUnderHomeCategory.add(result[randomNumber]);
      }
    } else {
      _productUnderHomeCategory.addAll(result);
    }

    setState(ViewState.completed);

    return _productUnderHomeCategory;
  }

  Future<List<ProductModel>> getRelatedProducts(
      ProductCategory category) async {
    Console.log("getRelatedProducts");
    setState(ViewState.busy);

    await Future.delayed(const Duration(seconds: 2));

    List<ProductModel> result = ProductModel.getAllFashionProducts()
        .where((product) => product.category == category)
        .toList();
    Console.log('result.length ${result.length}');
    _relatedProducts.clear();

    if (result.length > 6) {
      for (int i = 0; i < 6; i++) {
        int randomNumber = random.nextInt(result.length);
        _relatedProducts.add(result[randomNumber]);
      }
    } else {
      _relatedProducts.addAll(result);
    }

    setState(ViewState.completed);

    return _relatedProducts;
  }
}
