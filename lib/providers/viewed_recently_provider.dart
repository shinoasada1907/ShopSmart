import 'package:flutter/material.dart';
import 'package:shopsmart/models/viewed_product.dart';
import 'package:uuid/uuid.dart';

class ViewedProductProvider with ChangeNotifier {
  final Map<String, ViewedProductModel> _viewedProductItems = {};
  Map<String, ViewedProductModel> get getViewedProduct {
    return _viewedProductItems;
  }

  void addProductViewed({required String productId}) {
    _viewedProductItems.putIfAbsent(
      productId,
      () => ViewedProductModel(
        viewedProductId: const Uuid().v4(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void removeLocalViewedProduct() {
    _viewedProductItems.clear();
    notifyListeners();
  }
}
