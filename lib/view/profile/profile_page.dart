import 'package:flutter/material.dart';
import 'package:here/view/authenticate/login/login_page.dart';
import 'package:kartal/kartal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(),
                    ));
              },
              child: const SizedBox(width: 150, child: Center(child: Text("Exit")))),
          Padding(padding: EdgeInsets.only(top: context.height * 0.3), child: const Text('Profile!')),
        ],
      ),
    );
  }
}
