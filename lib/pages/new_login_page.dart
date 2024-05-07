import 'package:flutter/material.dart';

class NewLoginPage extends StatelessWidget {
  final void Function()? onTap;
  NewLoginPage({super.key, required this.onTap});

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Form(
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
            height: 30,
          ),
          // welcome back message
          Text(
            "Welcome back, you've been missed!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),

          const SizedBox(
            height: 25,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              validator: (value) => value!.isEmpty ? 'Enter email' : null,
              decoration: InputDecoration(
                  hintText: "Email",
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              validator: (value) =>
                  value!.length < 6 ? 'Enter a password 6+ chars long' : null,
              decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(25.0),
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              child: const Center(
                child: Text("Login"),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Rigster now",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ))),
    );
  }
}
