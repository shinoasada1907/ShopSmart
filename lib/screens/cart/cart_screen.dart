import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/cart_provider.dart';
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
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getcartItems.isEmpty
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
              title: TitlesTextWidget(
                label: 'Cart(${cartProvider.getcartItems.length})',
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
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.getcartItems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value:
                              cartProvider.getcartItems.values.toList()[index],
                          child: const CartWidget(),
                        );
                      }),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                ),
              ],
            ),
          );
  }
}
