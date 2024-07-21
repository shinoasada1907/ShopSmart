import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/models/product_model.dart';
import 'package:shopsmart/providers/cart_provider.dart';
import 'package:shopsmart/providers/viewed_recently_provider.dart';
import 'package:shopsmart/screens/inner_screen/product_details.dart';
import 'package:shopsmart/services/my_app_function.dart';
import 'package:shopsmart/widgets/products/heart_btn.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';

class LatestArrivalProductWidget extends StatelessWidget {
  const LatestArrivalProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final productsProvider = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProductProvider = Provider.of<ViewedProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          log('To Do add the navigate to the product  details screen');
          viewedProductProvider.addProductViewed(
              productId: productsProvider.productId);
          await Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: productsProvider.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productsProvider.productImage,
                    height: size.width * 0.24,
                    width: size.width * 0.32,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productsProvider.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartBottonWidget(
                            productId: productsProvider.productId,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProductInCart(
                                  productId: productsProvider.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFirebase(
                                    productId: productsProvider.productId,
                                    qty: 1,
                                    context: context);
                              } catch (e) {
                                await MyAppFunctions.showErrorOrWarningDialog(
                                  context: context,
                                  subTitle: e.toString(),
                                  fct: () {},
                                );
                              }
                              // if (cartProvider.isProductInCart(
                              //     productId: productsProvider.productId)) {
                              //   return;
                              // }
                              // cartProvider.addProductToCart(
                              //     productId: productsProvider.productId);
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                      productId: productsProvider.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FittedBox(
                      child: SubtitleTextWidget(
                        label: '${productsProvider.productPrice}\$',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
