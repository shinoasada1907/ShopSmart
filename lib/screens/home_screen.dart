import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';
import 'package:shopsmart/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // backgroundColor: AppColors.lightScaffoldColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitlesTextWidget(
              label: 'Hello this is a Title' * 10,
            ),
            const SubtitleTextWidget(
              label: 'Hello World',
            ),
            SwitchListTile(
              title: Text(
                  themeProvider.getIsDarkTheme ? 'Dark Mode' : 'Light Mode'),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
