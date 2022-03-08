import 'package:flutter/widgets.dart';
import 'package:udemy_shop/data/dummy_data.dart';
import 'package:udemy_shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavorite = false;

  List<Product> get items {
    if (_showFavorite) {
      return _items.where((product) => product.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavorite() {
    _showFavorite = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorite = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
