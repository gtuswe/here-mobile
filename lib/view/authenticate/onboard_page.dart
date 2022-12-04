import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:here/service/authentication.dart';
import 'package:here/view/authenticate/login/login_page.dart';
import 'package:here/view/authenticate/register/register_page.dart';
import 'package:kartal/kartal.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  void initState() {
    super.initState();
    AuthenticationService().initUsers(); // Should be deleted
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 238, 246),
      body: Padding(
        padding: EdgeInsets.only(left: context.width * 0.075, right: context.width * 0.075),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/here_logo2.svg"),
                  const SizedBox(width: 30),
                  Text(
                    "Here!",
                    style: context.textTheme.displayLarge?.copyWith(color: const Color.fromARGB(255, 50, 108, 233)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                title: AutoSizeText(
                  "Enjoy to Tracking your Attendances",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(color: Colors.black),
                  maxFontSize: 64,
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: context.height * 0.02),
                  child: AutoSizeText(
                    "Take your participants attendance in the twinkle of an eye, faster than your shadow",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: context.height * 0.066,
                    child: ElevatedButton(
                      onPressed: () {
                        context.navigateToPage(const RegisterPage());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 103, 80, 164),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Text(
                        "Sign Up",
                        style: context.textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: context.height * 0.066,
                    child: ElevatedButton(
                      onPressed: () {
                        context.navigateToPage(const LoginPage());
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                      ),
                      child: Text(
                        "Log in",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: const Color(0xff6750a4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
