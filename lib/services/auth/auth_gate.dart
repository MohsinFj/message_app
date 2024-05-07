import 'package:flutter/material.dart';
import 'package:message_app/services/auth/auth_service.dart';
import 'package:message_app/services/auth/login_or_register.dart';
import 'package:message_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthServices().authStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}
