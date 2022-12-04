import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _errorText = "";
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  "Welcome Back 👋",
                  style: context.textTheme.headlineLarge!.copyWith(color: Colors.black),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Sign In to your account",
                    style: context.textTheme.titleSmall!.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 16,
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Password",
                            border: const OutlineInputBorder(),
                            counter: TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?"),
                            ),
                          ),
                          validator: (String? data) {
                            if ((data?.length ?? 0) < 8) return "8 Karakterden büyük şifre giriniz";
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
                                    const result =
                                        "deneme"; //final result = await _authService.signIn(_emailController.text, _passwordController.text);
                                    _changeLoading();

                                    if (result != null) {
                                      _errorText = "";
                                    } else {
                                      setState(() {
                                        _errorText = "Kullanıcı adı veya şifre geçersiz";
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 103, 80, 164),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                ),
                                child: Text(
                                  "Login",
                                  style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: context.textTheme.labelSmall!.copyWith(color: Colors.grey),
                                ),
                                TextButton(onPressed: () {}, child: const Text("Sign Up"))
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20),
                            //   child: Text(
                            //     "                Or Sign In With                ",
                            //     style: context.textTheme.labelSmall!.copyWith(color: Colors.grey),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20),
                            //   child: ElevatedButton.icon(
                            //       onPressed: () {},
                            //       icon: const Icon(
                            //         Icons.g_mobiledata,
                            //         color: Colors.red,
                            //       ),
                            //       label: Text("Google",
                            //           style: context.textTheme.labelLarge!.copyWith(color: Colors.black)),
                            //       style: ElevatedButton.styleFrom(
                            //         primary: Colors.white,
                            //       )),
                            // )
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
