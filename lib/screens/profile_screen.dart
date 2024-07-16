import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/models/user_model.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/providers/user_provider.dart';
import 'package:shopsmart/screens/auth/login.dart';
import 'package:shopsmart/screens/inner_screen/orders/order_screen.dart';
import 'package:shopsmart/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart/screens/inner_screen/wishlist.dart';
import 'package:shopsmart/screens/loading_manager.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/services/my_app_function.dart';
import 'package:shopsmart/widgets/app_name_text.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';

import '../widgets/title_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfor() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfor();
    } catch (e) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subTitle: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfor();
    super.initState();
  }

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
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: TitlesTextWidget(
                    label: 'Please Login to have unlimited access',
                  ),
                ),
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
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
                                color: Theme.of(context).colorScheme.primary,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage.isEmpty
                                      ? 'https://static.vecteezy.com/system/resources/previews/009/734/564/original/default-avatar-profile-icon-of-social-media-user-vector.jpg'
                                      : userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(label: userModel!.userName),
                              const SizedBox(
                                height: 6,
                              ),
                              SubtitleTextWidget(label: userModel!.userEmail),
                            ],
                          ),
                        ],
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
                    Visibility(
                      visible: userModel == null ? false : true,
                      child: CustomListTitle(
                        imagePath: AssetsManager.orderSvg,
                        text: 'All Orders',
                        function: () {
                          Navigator.pushNamed(
                              context, OrdersScreenFree.routeName);
                        },
                      ),
                    ),
                    Visibility(
                      visible: userModel == null ? false : true,
                      child: CustomListTitle(
                        imagePath: AssetsManager.wishlistSvg,
                        text: 'Whishlist',
                        function: () {
                          Navigator.pushNamed(
                              context, WishlistScreen.routeName);
                        },
                      ),
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
                  icon: Icon(user == null ? Icons.login : Icons.logout),
                  label: Text(
                    user == null ? 'Login' : 'Logout',
                  ),
                  onPressed: () async {
                    if (user == null) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      await MyAppFunctions.showErrorOrWarningDialog(
                        context: context,
                        subTitle: 'Are you sure you want to signout ?',
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        isError: false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
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
