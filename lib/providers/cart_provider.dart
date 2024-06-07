import 'package:flutter/material.dart';
import 'package:shopsmart/models/cart_model.dart';
import 'package:shopsmart/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getcartItems {
    return _cartItems;
  }

  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  double getTotal({required ProductsProvider productProvider}) {
    double total = 0.0;
    _cartItems.forEach(
      (key, value) {
        final getCurrentProduct =
            productProvider.findByProductId(value.productId);
        if (getCurrentProduct == null) {
          total += 0;
        } else {
          total +=
              double.parse(getCurrentProduct.productPrice) * value.quantity;
        }
      },
    );
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItems.forEach(
      (key, value) {
        total += value.quantity;
      },
    );
    return total;
  }
}
