import 'package:flutter/material.dart';
import 'package:here/view/routes.dart';

void main() {
  runApp(const Here());
}

class Here extends StatefulWidget {
  const Here({Key? key}) : super(key: key);

  @override
  State<Here> createState() => _HereState();
}

class _HereState extends State<Here> {
  ThemeData getThemeData(bool isLightMode,
          {bool isMaterial3 = true, Color colorSeed = Colors.deepPurpleAccent}) =>
      ThemeData(
          colorSchemeSeed: colorSeed,
          useMaterial3: isMaterial3,
          brightness: isLightMode ? Brightness.light : Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Here!',
      debugShowCheckedModeBanner: false,
      theme: getThemeData(true),
      darkTheme: getThemeData(false),
      routes: Routes.routes,
    );
  }
}
