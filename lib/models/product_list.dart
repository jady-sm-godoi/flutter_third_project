import 'package:flutter/widgets.dart';
import 'package:udemy_shop/data/dummy_data.dart';
import 'package:udemy_shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
