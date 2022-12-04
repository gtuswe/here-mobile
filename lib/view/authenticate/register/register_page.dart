import 'package:flutter/material.dart';
import 'package:here/service/authentication.dart';
import 'package:here/view/authenticate/login/login_page.dart';
import 'package:here/view/main_page.dart';
import 'package:kartal/kartal.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final String _errorText = "";
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _schoolNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  "Let’s start 🚀",
                  style: context.textTheme.headlineLarge!.copyWith(color: Colors.black),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Create new account",
                    style: context.textTheme.titleSmall!.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                autocorrect: true,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "First Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (String? data) {
                                  if (data.isNullOrEmpty) return "*";
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _lastNameController,
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: "Last Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (String? data) {
                                  if (data.isNullOrEmpty) return "*";
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _schoolNumberController,
                          keyboardType: TextInputType.number,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "School number",
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? data) {
                            if (data!.isEmpty) return "*";
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Email Address",
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? data) {
                            if (!(data.isValidEmail)) return "Geçersiz email";
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? data) {
                            if ((data?.length ?? 0) < 8) return "8 Karakterden büyük şifre giriniz";
                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? data) {
                            if (data != _passwordController.text) {
                              return "Üstte girilen şifre ile aynı şifreyi giriniz";
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
                      Expanded(
                        flex: 24,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    _changeLoading();
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    AuthenticationService().insertUser(_nameController.text, _lastNameController.text,
                                        _schoolNumberController.text, _emailController.text, _passwordController.text);
                                    _changeLoading();

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => const MainPage(),
                                        ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 103, 80, 164),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                ),
                                child: Text(
                                  "Create Account",
                                  style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Do you have an account?",
                                  style: context.textTheme.labelSmall!.copyWith(color: Colors.grey),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => const LoginPage(),
                                          ));
                                    },
                                    child: const Text("Sign In"))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLoading() {
    setState(() {
      _loading = !_loading;
    });
  }
}
