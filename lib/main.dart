import 'package:flutter/material.dart';
import 'package:here/view/home/home_page.dart';

void main() {
  runApp(const Here());
}

class Here extends StatelessWidget {
  const Here({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Here!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
