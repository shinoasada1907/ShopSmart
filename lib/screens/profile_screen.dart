import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/screens/auth/login.dart';
import 'package:shopsmart/screens/inner_screen/orders/order_screen.dart';
import 'package:shopsmart/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart/screens/inner_screen/wishlist.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/widgets/app_name_text.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';

import '../widgets/title_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: TitlesTextWidget(
                  label: 'Please Login to have unlimited access',
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://thumbs.dreamstime.com/b/default-profile-picture-avatar-photo-placeholder-vector-illustration-default-profile-picture-avatar-photo-placeholder-vector-189495158.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(label: 'Sinon Sama'),
                        SizedBox(
                          height: 6,
                        ),
                        SubtitleTextWidget(label: 'bonzed2001@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitlesTextWidget(
                    label: 'General',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.orderSvg,
                    text: 'All Orders',
                    function: () {
                      Navigator.pushNamed(context, OrdersScreenFree.routeName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.wishlistSvg,
                    text: 'Whishlist',
                    function: () {
                      Navigator.pushNamed(context, WishlistScreen.routeName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.recent,
                    text: 'Viewed recently',
                    function: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routeName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.address,
                    text: 'Address',
                    function: () {},
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const TitlesTextWidget(
                    label: 'Setting',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 34,
                    ),
                    title: Text(themeProvider.getIsDarkTheme
                        ? 'Dark Mode'
                        : 'Light Mode'),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.login),
                label: const Text(
                  'Login',
                ),
                onPressed: () async {
                  // await MyAppFunctions.showErrorOrWarningDialog(
                  //   context: context,
                  //   subTitle: 'Are you sure you want to signout ?',
                  //   fct: () {},
                  //   isError: false,
                  // );
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(
        label: text,
      ),
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      trailing: const Icon(
        IconlyLight.arrowRight2,
      ),
    );
  }
}
