import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:myapp/views/index.dart';


class AppRoutes {
  static const String home = "/";
  static const String createUpdate = "/create-update";
  static const String productDetail = "/product-detail";
  static const String productsListView = "/product-list-view";
}

final routesConfig = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.createUpdate,
      builder: (context, state) => const CreateUpdateView(),
    ),
    GoRoute(
      path: AppRoutes.productsListView,
      builder: (context, state) => const ProductsListView(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      builder: (context, state) {
        final productId = state.extra as String?;
        if (productId == null) {
          return const Scaffold(
            body: Center(
              child: Text('No product ID provided!'),
            ),
          );
        }
        return ProductDetailView(productId: productId);
      },
    ),
  ],
);