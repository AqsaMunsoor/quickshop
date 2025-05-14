import 'package:flutter/material.dart';
import 'package:quickshop/ui/screens/category_detail/category_detail.dart';
import 'package:quickshop/ui/screens/home/home.dart';

import 'package:quickshop/ui/screens/favourites/favourites.dart';

import 'package:quickshop/ui/screens/categories/categories.dart';
import 'package:quickshop/ui/screens/product_detail/product_detail.dart';
import 'package:quickshop/ui/screens/profile/profile.dart';
import 'package:quickshop/ui/screens/splash/splash.dart';

import 'routes.dart';

final navigator = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final appRoutes = {
  AppRoutes.favourites: (_) => const FavouritesScreen(),
  AppRoutes.categories: (_) => const CategoriesScreen(),
  AppRoutes.profile: (_) => const ProfileScreen(),
  AppRoutes.home: (_) => const HomeScreen(),
  AppRoutes.splash: (_) => const SplashScreen(),
  AppRoutes.productDetail: (_) => const ProductDetailScreen(),
  AppRoutes.categoryDetail: (_) => const CategoryDetailScreen(),
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  final route = switch (settings.name) {
    AppRoutes.home => FadeRoute(settings: settings, child: const HomeScreen()),
    AppRoutes.categories => FadeRoute(
      settings: settings,
      child: const CategoriesScreen(),
    ),
    AppRoutes.favourites => FadeRoute(
      settings: settings,
      child: const FavouritesScreen(),
    ),
    AppRoutes.profile => FadeRoute(
      settings: settings,
      child: const ProfileScreen(),
    ),
    _ => null,
  };
  return route;
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;

  @override
  final RouteSettings settings;

  FadeRoute({required this.child, required this.settings})
    : super(
        settings: settings,
        pageBuilder: (context, ani1, ani2) => child,
        transitionsBuilder: (context, ani1, ani2, child) {
          return FadeTransition(opacity: ani1, child: child);
        },
      );
}
