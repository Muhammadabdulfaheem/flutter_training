// lib/app_router.dart
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/screens/tabbar/tabbar.dart';
import 'package:flutter_training_project/screens/product_details.dart';
import 'package:go_router/go_router.dart';
import 'routes_names.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: RoutesNames.main,
      routes: [
        GoRoute(path: RoutesNames.main, builder: (context, state) => Tabbar()),
        GoRoute(
          path: RoutesNames.productDetails,
          builder: (context, state) {
            final product = state.extra as Products;
            return ProductDetails(product: product);
          },
        ),
      ],
    );
  }
}
