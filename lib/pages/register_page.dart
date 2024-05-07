import 'package:flutter/material.dart';
import 'package:message_app/components/loading.dart';
import 'package:message_app/services/auth/auth_service.dart';
import 'package:message_app/components/my_button.dart';
import 'package:message_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //email and password controller and confirm
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmController = TextEditingController();

  bool _loading = false;

  // register function
  void register(BuildContext context) async {
    AuthServices authServices = AuthServices();

    if (_confirmController.text == _passwordController.text) {
      try {
        setState(() {
          _loading = true;
        });
        await authServices.signUpWithEmailAndPassword(
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
              "Exception: email-already-in-use" =>
                const Center(child: Text("الأيميل مستخدم")),
              "Exception: weak-password" => const Center(
                    child: Text(
                  "الرمز يجب ان يتكون من 6 احرف او ارقام",
                  textAlign: TextAlign.center,
                )),
              _ => const Center(child: Text("حصل خطأ")),
            },
          ),
        );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Center(child: Text("الرمز غير متطابق")),
              ));
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
                    height: 20,
                  ),
                  // welcome back message
                  Text(
                    "Let's create an acount for you",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16),
                  ),

                  const SizedBox(
                    height: 15,
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
                    height: 10,
                  ),
                  // password textfield
                  MyTextfield(
                    hintText: "Confirm Password",
                    obscureText: true,
                    controller: _confirmController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // login button
                  MyButton(
                    text: "Register",
                    onTap: () => register(context),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already hava an account? ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login now",
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
