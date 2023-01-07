import 'package:flutter/material.dart';
import 'package:here/model/user.dart';
import 'package:here/service/authentication.dart';
import 'package:here/view/authenticate/login/login_page.dart';
import 'package:here/view/authenticate/onboard_page.dart';
import 'package:here/view/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  bool isFirst = false;
  User? user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFunction(),
        builder: (context, snapshot) {
          // Wait list data
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (isFirst == true) {
            return const OnboardPage();
          } else if (user == null) {
            return const LoginPage();
          } else {
            print(user!.name);
            return const MainPage();
          }
        });
  }

  Future<bool> firstOpening() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool? firstOpen = sharedPreferences.getBool("firstOpen");

    if (firstOpen == null || firstOpen == false) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _initFunction() async {
    await firstOpening().then((value) {
      isFirst = value;
    });

    await AuthenticationService().getUser().then((value) {
      user = value;
    });
  }
}
