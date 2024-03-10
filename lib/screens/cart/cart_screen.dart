import 'package:flutter/material.dart';
import 'package:shopsmart/screens/cart/bottom_checkout.dart';
import 'package:shopsmart/screens/cart/cart_widget.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/widgets/empty_bag.dart';
import 'package:shopsmart/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Your cart is empty',
              subTitle:
                  'Look like your cart is empty add something and  make me happy',
              buttonText: 'Shop now',
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomSheetWidget(),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              title: const TitlesTextWidget(
                label: 'Cart(6)',
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CartWidget();
                }),
          );
  }
}
