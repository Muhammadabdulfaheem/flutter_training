// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/screens/main_screen.dart';
import 'package:flutter_training_project/screens/product_details.dart';
import 'package:go_router/go_router.dart';
import 'routes_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesNames.main,
    routes: [
      GoRoute(
        path: RoutesNames.main,
        builder: (BuildContext context, GoRouterState state) {
          return MainTabScreen();
        },
      ),
      // Route for product details
      GoRoute(
        path: RoutesNames.productDetails,
        builder: (BuildContext context, GoRouterState state) {
          final Products product = state.extra as Products;
          return ProductDetails(product: product);
        },
      ),
    ],
  );
}
