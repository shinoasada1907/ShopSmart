import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/consts/theme_data.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/root_screen.dart';
import 'package:shopsmart/screens/auth/login.dart';
import 'package:shopsmart/screens/auth/register.dart';
import 'package:shopsmart/screens/inner_screen/product_details.dart';
import 'package:shopsmart/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart/screens/inner_screen/wishlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
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
              RootSceen.routeName:(context) =>const RootSceen(),
              ProductDetailsScreen.routeName: (context) =>
                  const ProductDetailsScreen(),
              WishlistScreen.routeName: (context) => const WishlistScreen(),
              ViewedRecentlyScreen.routeName: (context) =>
                  const ViewedRecentlyScreen(),
              RegisterScreen.routName: (context) => const RegisterScreen(),
            },
          );
        },
      ),
    );
  }
}
