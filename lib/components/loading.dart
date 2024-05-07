import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SpinKitCircle(
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 50.0,
        ),
      ),
    );
  }
}
