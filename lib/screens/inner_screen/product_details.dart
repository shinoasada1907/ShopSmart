import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/cart_provider.dart';
import 'package:shopsmart/providers/products_provider.dart';
import 'package:shopsmart/services/my_app_function.dart';
import 'package:shopsmart/widgets/app_name_text.dart';
import 'package:shopsmart/widgets/products/heart_btn.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';
import 'package:shopsmart/widgets/title_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/ProductDetailsScreen';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findByProductId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.canPop(context) ? Navigator.pop(context) : null;
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
      ),
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    height: size.height * 0.38,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrentProduct.productTitle,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SubtitleTextWidget(
                              label: '${getCurrentProduct.productPrice}\$',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeartBottonWidget(
                                bkgColor: Colors.blue.shade100,
                                productId: getCurrentProduct.productId,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      if (cartProvider.isProductInCart(
                                          productId:
                                              getCurrentProduct.productId)) {
                                        return;
                                      }
                                      try {
                                        await cartProvider.addToCartFirebase(
                                            productId:
                                                getCurrentProduct.productId,
                                            qty: 1,
                                            context: context);
                                      } catch (e) {
                                        await MyAppFunctions
                                            .showErrorOrWarningDialog(
                                          context: context,
                                          subTitle: e.toString(),
                                          fct: () {},
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        )),
                                    icon: Icon(
                                      cartProvider.isProductInCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_outlined,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      cartProvider.isProductInCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? 'In cart'
                                          : 'Add to cart',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(label: 'About this item'),
                            SubtitleTextWidget(
                                label:
                                    'In ${getCurrentProduct.productCategory}')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SubtitleTextWidget(
                            label: getCurrentProduct.productDescription),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
