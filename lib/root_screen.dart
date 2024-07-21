import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/cart_provider.dart';
import 'package:shopsmart/providers/products_provider.dart';
import 'package:shopsmart/providers/user_provider.dart';
import 'package:shopsmart/providers/wishlist_provider.dart';
import 'package:shopsmart/screens/cart/cart_screen.dart';
import 'package:shopsmart/screens/home_screen.dart';
import 'package:shopsmart/screens/profile_screen.dart';
import 'package:shopsmart/screens/search_screen.dart';

class RootSceen extends StatefulWidget {
  static const routeName = '/RootSceen';
  const RootSceen({super.key});

  @override
  State<RootSceen> createState() => _RootSceenState();
}

class _RootSceenState extends State<RootSceen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  bool isLoadingProd = true;

  @override
  void initState() {
    super.initState();

    screens = const [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final wishlistsProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    try {
      Future.wait({
        productsProvider.fetchProducts(),
        userProvider.fetchUserInfor(),
      });
      Future.wait({
        cartProvider.fetchCart(),
        wishlistsProvider.fetchWishlist(),
      });
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProd) {
      fetchFCT();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Badge(
              label: Text(cartProvider.getcartItems.length.toString()),
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              child: const Icon(IconlyLight.bag2),
            ),
            label: 'Cart',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
