import 'package:flutter/material.dart';
import 'package:omeganotes/themes/themes.dart';
import 'pages/all.dart';
import 'package:provider/provider.dart';
import 'models/theme.dart';

void main(List<String> args) {
  runApp(const OmegaNotes());
}

class OmegaNotes extends StatelessWidget {
  const OmegaNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(
            builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            theme: themeNotifier.isDark ? darkTheme : brightTheme,
            routes: {HomePage.routeName: (context) => HomePage()},
          );
        }));
  }
}
