import 'package:flutter/material.dart';
import 'package:project/presentation/globals.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  const LoadingPage._();
  static Page<void> page() => const MaterialPage<void>(child: LoadingPage._());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: backGroundGrad
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(color: Colors.white54))
        ],
      ),
    );
  }
}
