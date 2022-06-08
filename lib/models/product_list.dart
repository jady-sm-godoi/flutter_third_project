import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';
import 'package:udemy_shop/data/dummy_data.dart';
import 'package:udemy_shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-udemy-8ce2d-default-rtdb.firebaseio.com';
  final List<Product> _items = dummyProducts;
  // final bool _showFavorite = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    http.post(Uri.parse('$_baseUrl/products.json'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }));
    _items.add(product);
    notifyListeners();
  }

  void editProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'].toString(),
      description: data['description'].toString(),
      price: data['price'] as double,
      imageUrl: data['imageUrl'].toString(),
    );

    if (hasId) {
      editProduct(product);
    } else {
      addProduct(product);
    }
  }
}
