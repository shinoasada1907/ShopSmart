import 'package:flutter/material.dart';

class ViewedProductModel with ChangeNotifier {
  final String viewedProductId;
  final String productId;

  ViewedProductModel({
    required this.viewedProductId,
    required this.productId,
  });
}
