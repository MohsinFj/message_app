import 'package:flutter/material.dart';
import 'package:message_app/components/loading.dart';
import 'package:message_app/services/auth/auth_service.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email and password controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  // login function
  void login(
    BuildContext context,
  ) async {
    // auth service
    AuthServices authServices = AuthServices();
    setState(() {
      _loading = true;
    });
    // try login
    try {
      await authServices.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      setState(() {
        _loading = false;
      });

      String error = e.toString();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: switch (error) {
            "Exception: user-not-found" =>
              const Center(child: Text("الأيميل غير صحيح")),
            "Exception: wrong-password" =>
              const Center(child: Text("الرمز غير صحيح")),
            _ => const Center(child: Text("حصل خطأ")),
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Icon(
                    Icons.message,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  // welcome back message
                  Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // email textfield
                  MyTextfield(
                    hintText: "Email",
                    obscureText: false,
                    controller: _emailController,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // password textfield
                  MyTextfield(
                    hintText: "Password",
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // login button
                  MyButton(
                    text: "Login",
                    onTap: () => login(context),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member? ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Rigster now",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),

                  // register button
                ],
              ),
            ),
          );
  }
}
