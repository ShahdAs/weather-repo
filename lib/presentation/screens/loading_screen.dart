import 'package:flutter/material.dart';
import 'package:project/presentation/globals.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  const LoadingPage._();
  static Page<void> page() => const MaterialPage<void>(child: LoadingPage._());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: backGroundGrad
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  gradient: backGroundGrad,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      blurRadius: 15,
                    ),
                  ]
              ),
              child: const CircularProgressIndicator(color: Colors.white54))
        ],
      ),
    );
  }
}
