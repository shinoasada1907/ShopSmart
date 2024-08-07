import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/consts/theme_data.dart';
import 'package:shopsmart/providers/cart_provider.dart';
import 'package:shopsmart/providers/order_provider.dart';
import 'package:shopsmart/providers/products_provider.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/providers/user_provider.dart';
import 'package:shopsmart/providers/viewed_recently_provider.dart';
import 'package:shopsmart/providers/wishlist_provider.dart';
import 'package:shopsmart/root_screen.dart';
import 'package:shopsmart/screens/auth/forgot_password.dart';
import 'package:shopsmart/screens/auth/login.dart';
import 'package:shopsmart/screens/auth/register.dart';
import 'package:shopsmart/screens/inner_screen/orders/order_screen.dart';
import 'package:shopsmart/screens/inner_screen/product_details.dart';
import 'package:shopsmart/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart/screens/inner_screen/wishlist.dart';
import 'package:shopsmart/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(
                    snapshot.error.toString(),
                  ),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductsProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProductProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return OrderProvicer();
              })
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  title: 'Shop Smart',
                  debugShowCheckedModeBanner: false,
                  theme: Style.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context,
                  ),
                  home: const LoginScreen(),
                  routes: {
                    RootSceen.routeName: (context) => const RootSceen(),
                    ProductDetailsScreen.routeName: (context) =>
                        const ProductDetailsScreen(),
                    WishlistScreen.routeName: (context) =>
                        const WishlistScreen(),
                    ViewedRecentlyScreen.routeName: (context) =>
                        const ViewedRecentlyScreen(),
                    RegisterScreen.routName: (context) =>
                        const RegisterScreen(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    OrdersScreenFree.routeName: (context) =>
                        const OrdersScreenFree(),
                    ForgotPasswordScreen.routeName: (context) =>
                        const ForgotPasswordScreen(),
                    SearchScreen.routName: (context) => const SearchScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}
