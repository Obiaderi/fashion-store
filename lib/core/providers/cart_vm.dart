import 'package:flutter/material.dart';
import 'package:lightsonheights/core/helpers/log_state.dart';
import 'package:lightsonheights/core/models/product_model.dart';
import 'package:lightsonheights/core/services/storage_key.dart';
import 'package:lightsonheights/core/services/storage_service.dart';

class CartVM extends ChangeNotifier {
  CartVM() {
    init();
  }

  List<ProductModel> _cartItems = [];
  List<ProductModel> get cartItems => _cartItems;

  double get totalAmount {
    double total = 0;
    for (var product in _cartItems) {
      total += double.parse(product.salesPrice!) * product.quantitySelected!;
    }
    return total;
  }

  addQuantity(ProductModel product) {
    Console.log("addQuantity");
    Console.log(product.quantitySelected.toString());
    Console.log(product.salesPrice.toString());
    int index = _cartItems.indexOf(product);
    _cartItems[index].quantitySelected =
        _cartItems[index].quantitySelected! + 1;

    StorageService.storeStringItem(
        StorageKey.cart, productModelToJson(_cartItems));
    notifyListeners();
  }

  removeQuantity(ProductModel product) {
    int index = _cartItems.indexOf(product);
    if (_cartItems[index].quantitySelected! > 1) {
      _cartItems[index].quantitySelected =
          _cartItems[index].quantitySelected! - 1;
    } else {
      _cartItems.remove(product);
    }
    StorageService.storeStringItem(
        StorageKey.cart, productModelToJson(_cartItems));
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    if (_cartItems.contains(product)) {
      int index = _cartItems.indexOf(product);
      _cartItems[index].quantitySelected =
          _cartItems[index].quantitySelected! + 1;
    } else {
      product.quantitySelected = 1;
      _cartItems.add(product);
    }

    StorageService.storeStringItem(
        StorageKey.cart, productModelToJson(_cartItems));
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    if (_cartItems.contains(product)) {
      int index = _cartItems.indexOf(product);
      if (_cartItems[index].quantitySelected! > 1) {
        _cartItems[index].quantitySelected =
            _cartItems[index].quantitySelected! - 1;
      } else {
        _cartItems.remove(product);
      }
    }

    StorageService.storeStringItem(
        StorageKey.cart, productModelToJson(_cartItems));
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    StorageService.removeStringItem(StorageKey.cart);
    notifyListeners();
  }

  init() async {
    String? storedCartItems =
        await StorageService.getStringItem(StorageKey.cart);
    if (storedCartItems != null) {
      _cartItems = productModelFromJson(storedCartItems);
      notifyListeners();
    }
  }
}
