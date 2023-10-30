// import 'package:flutter/material.dart';
// import 'package:lightsonheights/core/models/product_model.dart';

// class WishListProvider extends ChangeNotifier {
//   WishListProvider() {
//     init();
//   }
//   List<ProductModel> _wishlist = [];
//   List<ProductModel> get wishList => _wishlist;
//   init() {
//     String? defaultText = SharedPrefs.getString("wish");
//     if (defaultText != null) {
//       List<ProductModel> wishs = ProductModel.decode(defaultText);
//       _wishlist = wishs;
//       notifyListeners();
//     }
//   }

//   setwish(List<ProductModel> wishs) {
//     _wishlist = wishs;
//     SharedPrefs.setString("wish", ProductModel.encode(wishs));
//     notifyListeners();
//   }

//   setFav(ProductModel wish) {
//     int index = _wishlist.indexWhere((element) =>
//         (element.id == wish.id) &&
//         (element.selectedVariant?.variantName ==
//             wish.selectedVariant?.variantName));
//     if (index == -1) {
//       _wishlist.add(wish);
//     } else {
//       _wishlist.removeAt(index);
//     }
//     _wishlist = _wishlist;
//     SharedPrefs.setString("wish", ProductModel.encode(_wishlist));
//     notifyListeners();
//   }
// }
