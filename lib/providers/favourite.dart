import 'package:flutter/material.dart';
import 'package:quickshop/models/product/product.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favorites => _favoriteProducts;

  bool isFavorite(Product product) {
    return _favoriteProducts.any((p) => p.id == product.id);
  }

  void addToFavorites(Product product) {
    if (!isFavorite(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    _favoriteProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }
}
