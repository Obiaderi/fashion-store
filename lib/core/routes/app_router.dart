import 'package:flutter/material.dart';
import 'package:lightsonheights/core/models/product_model.dart';
import 'package:lightsonheights/core/routes/routes.dart';
import 'package:lightsonheights/ui/screens/dashboard/cart/cart_screen.dart';
import 'package:lightsonheights/ui/screens/dashboard/dashboard.dart';
import 'package:lightsonheights/ui/screens/dashboard/product/product_screen.dart';
import 'package:lightsonheights/ui/screens/dashboard/shop/search_shop_screen.dart';
import 'package:lightsonheights/ui/screens/splash/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //welcome routes
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.products:
        return MaterialPageRoute(builder: (_) => const ProductScreen());
      case Routes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.productDetail:
        var args = settings.arguments;
        if (args != null && args is ProductModel) {
          ProductModel argument = args;
          return MaterialPageRoute(
            builder: (_) => ProductScreen(
              product: argument,
            ),
          );
        }
        return errorScreen('Required parameters not set for ${settings.name}');
      case Routes.searchShopScreen:
        var args = settings.arguments;
        if (args != null && args is String) {
          String argument = args;
          return MaterialPageRoute(
            builder: (_) => SearchShopScreen(
              query: argument,
            ),
          );
        }
        return errorScreen('Required parameters not set for ${settings.name}');

      default:
        return errorScreen('No route defined for ${settings.name}');
    }
  }

  static MaterialPageRoute errorScreen(String msg) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text(msg),
              ),
            ));
  }
}
