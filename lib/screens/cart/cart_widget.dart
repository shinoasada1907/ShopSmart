import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/models/cart_model.dart';
import 'package:shopsmart/providers/products_provider.dart';
import 'package:shopsmart/screens/cart/quantity_btm_sheet.dart';
import 'package:shopsmart/widgets/products/heart_btn.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';
import 'package:shopsmart/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productsProvider.findByProductId(cartModel.productId);
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.productImage,
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TitlesTextWidget(
                                  label: getCurrentProduct.productTitle,
                                  maxLines: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const HeartBottonWidget(),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubtitleTextWidget(
                                label: '${getCurrentProduct.productPrice}\$',
                                color: Colors.blue,
                              ),
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return const QuantityBottomSheetWidget();
                                      });
                                },
                                icon: const Icon(IconlyLight.arrowDown2),
                                label: Text(
                                  'Qty: ${cartModel.quantity}',
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1,
                                  ),
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(
                                  //     30.0,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
